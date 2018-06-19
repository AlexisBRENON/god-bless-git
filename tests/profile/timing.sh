#! /usr/sh

. "./tests/util/setups.sh"

_setup_profiling() {
    echo "${PROFILE_DIR}"
}

_profile() {
    PROFILE_DIR="$(mktemp -d)"

    mkfifo "${PROFILE_DIR}/debug_tee" "${PROFILE_DIR}/tee_sed"
    exec 4<>"${PROFILE_DIR}/debug_tee"
    exec 5<>"${PROFILE_DIR}/tee_sed"
    tee "${PROFILE_DIR}/cmd.txt" <&4 >&5 &
    tee_pid=$!
    sed -u 's/^.*$/now/' <&5 | \
        date -f - +%s.%N \
        > "${PROFILE_DIR}/time.txt" &
    date_pid=$!
    exec 3>&2 2>&4

    set -x
    "$@"
    set +x

    # Fill date buffer
    num_cmd="$(wc -l "${PROFILE_DIR}/cmd.txt" | cut -d' ' -f1)"
    while [ \
        "$(\
            wc -l "${PROFILE_DIR}/time.txt" | \
            cut -d' ' -f1)" \
        -lt "${num_cmd}" ]; do
        echo "" >&5
    done

    exec 2>&3 3>&-

    kill ${date_pid} ${tee_pid}

    exec 4>&- 5>&- 4<&- 5<&-
    rm "${PROFILE_DIR}/debug_tee" "${PROFILE_DIR}/tee_sed"

    while read -r tim ; do
        if [ -z "$last" ] ; then
            last="${tim}"
            first="${tim}"
        fi
        crt="$(\
            echo "${tim} - ${last}" | bc)"
        tot="$(\
            echo "${tim} - ${first}" | bc)"
        LC_ALL=C printf "%3.9f\\t%3.9f\\n" "${tot}" "${crt}"
        last=${tim}
    done < "${PROFILE_DIR}/time.txt" > "${PROFILE_DIR}/acc_time.txt"

    profiling="$(\
        head -n "${num_cmd}" "${PROFILE_DIR}/acc_time.txt" | \
        paste - "${PROFILE_DIR}/cmd.txt"\
        )"

    rm -r "${PROFILE_DIR}"

    echo "${profiling}"
}

_total_time() {
    echo "${1}" | tail -n 1 | cut -f1
}

_longest_command() {
    echo "${1}" | cut -f2-3 | sort -rn | head -n1 | sed 's/\t+* /\t/'
}

_sumup_profile() {
    longest_command_time="$(echo "${2}" | cut -f1)"
    longest_command="$(echo "${2}" | cut -f2)"
    echo "  Total time: ${1} s"
    echo "  longest command: ${longest_command} (took ${longest_command_time})"
}

test_profile_non_repo() {
    _make_it_non_repo

    profiling="$(_profile god_bless_git)"

    total_time="$(_total_time "${profiling}")"
    longest_command="$(_longest_command "${profiling}")"
    _sumup_profile "${total_time}" "${longest_command}"

    assertEquals \
        "success" \
        "$(\
            LC_ALL=C \
            printf 'if (%f < 0.05) "success";\n' "${total_time}" | \
            bc)"
}

test_profile_empty_repo() {
    profiling="$(_profile god_bless_git)"

    total_time="$(_total_time "${profiling}")"
    longest_command="$(_longest_command "${profiling}")"
    _sumup_profile "${total_time}" "${longest_command}"

    assertEquals \
        "success" \
        "$(\
            LC_ALL=C \
            printf 'if (%f < 0.2) "success";\n' "${total_time}" | \
            bc)"
}

test_profile_simple_repo() {
    _make_history 30 20 10
    _make_upstream
    _git checkout master~15
    profiling="$(_profile god_bless_git)"

    total_time="$(_total_time "${profiling}")"
    longest_command="$(_longest_command "${profiling}")"
    _sumup_profile "${total_time}" "${longest_command}"

    assertEquals \
        "success" \
        "$(\
            LC_ALL=C \
            printf 'if (%f < 0.5) "success";\n' "${total_time}" | \
            bc)"
}

test_long_profile_heavy_repo() {
    _make_history \
        2000 300 500 30 20 \
        100 10 500 20 20 \
        20 10 42 10 10 \
        10 10 10 10 10
    _make_upstream
    _make_stashes 10
    profiling="$(_profile god_bless_git)"

    total_time="$(_total_time "${profiling}")"
    longest_command="$(_longest_command "${profiling}")"
    _sumup_profile "${total_time}" "${longest_command}"

    assertEquals \
        "success" \
        "$(\
            LC_ALL=C \
            printf 'if (%f < 1) "success";\n' "${total_time}" | \
            bc)"
}

. "./tests/shunit2/shunit2"
