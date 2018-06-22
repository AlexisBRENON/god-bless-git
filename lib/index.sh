#! /bin/sh

_gbg_get_index_status() {
    if [ "${gbg_is_a_git_repo:-}" = "true" ]; then
        lgbg_git_status="$(git status --porcelain 2> /dev/null || true)"
        lgbg_modifications_num=$(\
            echo "${lgbg_git_status}" | \
            grep -Ece '^M' || true)
        lgbg_has_modifications=$( \
            [ "${lgbg_modifications_num}" -gt 0 ] && \
            echo "true" || \
            echo "false" )

        lgbg_moves_num=$(\
            echo "${lgbg_git_status}" | \
            grep -Ece '^R' || true)
        lgbg_has_moves=$( \
            [ "${lgbg_moves_num}" -gt 0 ] && \
            echo "true" || \
            echo "false" )

        lgbg_deletions_num=$(\
            echo "${lgbg_git_status}" | \
            grep -Ece '^D' || true)
        lgbg_has_deletions=$( \
            [ "${lgbg_deletions_num}" -gt 0 ] && \
            echo "true" || \
            echo "false" )

        lgbg_additions_num=$(\
            echo "${lgbg_git_status}" | \
            grep -Ece '^A' || true)
        lgbg_has_additions=$( \
            [ "${lgbg_additions_num}" -gt 0 ] && \
            echo "true" || \
            echo "false" )
    fi

    gbg_index_modifications_num="${lgbg_modifications_num:-}"
    gbg_index_has_modifications="${lgbg_has_modifications:-}"
    gbg_index_moves_num="${lgbg_moves_num:-}"
    gbg_index_has_moves="${lgbg_has_moves:-}"
    gbg_index_deletions_num="${lgbg_deletions_num:-}"
    gbg_index_has_deletions="${lgbg_has_deletions:-}"
    gbg_index_additions_num="${lgbg_additions_num:-}"
    gbg_index_has_additions="${lgbg_has_additions:-}"

    export gbg_index_modifications_num
    export gbg_index_has_modifications
    export gbg_index_moves_num
    export gbg_index_has_moves
    export gbg_index_deletions_num
    export gbg_index_has_deletions
    export gbg_index_additions_num
    export gbg_index_has_additions
}
