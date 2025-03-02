load up

assert_contains() {
	local -r expected=$1

	shift

	for e; do
		[[ $e == "$expected" ]] && return
	done

	return 1
}

@test '_up should autocomplete the list of parent directory names when given no arguments' {
	mkdir -p "${BATS_TEST_TMPDIR}"/src/main/java
	cd "${BATS_TEST_TMPDIR}"/src/main/java

	COMP_WORDS=(up)
	COMP_CWORD=1
	_up

	assert_contains / "${COMPREPLY[@]}"
	assert_contains src "${COMPREPLY[@]}"
	assert_contains main "${COMPREPLY[@]}"
}

@test '_up should not autocomplete the current directory name when given no arguments' {
	mkdir -p "${BATS_TEST_TMPDIR}"/src/main/java
	cd "${BATS_TEST_TMPDIR}"/src/main/java

	COMP_WORDS=(up)
	COMP_CWORD=1
	_up

	! assert_contains java "${COMPREPLY[@]}"
}

@test '_up should autocomplete the parent directory name' {
	mkdir -p "${BATS_TEST_TMPDIR}"/src/main/java
	cd "${BATS_TEST_TMPDIR}"/src/main/java

	COMP_WORDS=(up ma)
	COMP_CWORD=1
	_up

	assert_contains main "${COMPREPLY[@]}"
}

@test '_up should autocomplete the parent directory name containing whitespace' {
	mkdir -p "${BATS_TEST_TMPDIR}"/com/git\ hub/helpermethod
	cd "${BATS_TEST_TMPDIR}"/com/git\ hub/helpermethod

	COMP_WORD=(up gi)
	COMP_CWORD=1
	_up

	assert_contains "git\ hub" "${COMPREPLY[@]}"
}
