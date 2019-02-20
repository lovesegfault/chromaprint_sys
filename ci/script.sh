# This script takes care of testing your crate

set -ex

main() {
    ls "${PKG_CONFIG_PATH}"
    cross build --features=static --target $TARGET
    cross build --features=static --target $TARGET --release

    if [ ! -z $DISABLE_TESTS ]; then
        return
    fi

    cross test --features=static --target $TARGET
    cross test --features=static --target $TARGET --release
}

# we don't run the "test phase" when doing deploys
if [ -z $TRAVIS_TAG ]; then
    main
fi
