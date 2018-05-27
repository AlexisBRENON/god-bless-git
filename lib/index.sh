#! /bin/sh

_gbg_get_index_status() {
    lgbg_git_status="$(git status --porcelain 2> /dev/null)"
    gbg_index_modifications_num=$(echo "${lgbg_git_status}" | grep -Ece '^M')
    gbg_index_has_modifications=$( \
        [ "${gbg_index_modifications_num}" -gt 0 ] && \
        echo "true" || \
        echo "false" )

    gbg_index_moves_num=$(echo "${lgbg_git_status}" | grep -Ece '^R')
    gbg_index_has_moves=$( \
        [ "${gbg_index_moves_num}" -gt 0 ] && \
        echo "true" || \
        echo "false" )

    gbg_index_deletions_num=$(echo "${lgbg_git_status}" | grep -Ece '^D')
    gbg_index_has_deletions=$( \
        [ "${gbg_index_deletions_num}" -gt 0 ] && \
        echo "true" || \
        echo "false" )

    gbg_index_additions_num=$(echo "${lgbg_git_status}" | grep -Ece '^A')
    gbg_index_has_additions=$( \
        [ "${gbg_index_additions_num}" -gt 0 ] && \
        echo "true" || \
        echo "false" )

    export gbg_index_modifications_num
    export gbg_index_has_modifications
    export gbg_index_moves_num
    export gbg_index_has_moves
    export gbg_index_deletions_num
    export gbg_index_has_deletions
    export gbg_index_additions_num
    export gbg_index_has_additions
}
