#!/bin/sh

EXPR=$1
SUBST=$3
INCL=$5
EXCL=$7

# TODO: just have argument names prepend
if [[ $4 == "including" ]]; then
    INCL=$5
elif [[ $4 == "excluding" ]]; then
    EXCLUDING=$5
fi

echo EXPR = "${EXPR}"
echo SUBST = "${SUBST}"
echo INPLACE = "${INPLACE}"
echo WHERE = "${WHERE}"

OUTPUT=`grep --color=always -rP  "$EXPR" --include='*.h' --include='*.cpp'`
echo $OUTPUT
exit 0

if [[ ! $INPLACE == "YES" ]]; then
    grep -rP  "$EXPRESSION" --include='*.h' --include='*.cpp'
    exit 0;
else
    FILES=`grep -rlP  "$EXPRESSION" --include='*.h' --include='*.cpp'`
fi


if [[ -z $FILES ]]; then
    echo "No files matching"
    exit 0;
fi

echo $FILES

perl -p -e "s/$EXPRESSION/$SUBSTITUTION/g" $FILES
#perl -p -e 's/(?<!1)BASIC_ERROR/ConsistencyState::BASIC_ERROR/g' `grep -rlP  '(?<!::)(BASIC_ERROR)' --include='*.h' --include='*.cpp'`
