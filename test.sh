SRCPACK=/tmp/pr.tgz
tar czf $SRCPACK Sources Tests Package.swift
REPO=/tmp/reg.linux
mkdir -p $REPO
pushd .
echo "-------------- LINUX SWIFT 4.0 ----------------"
cd $REPO
tar xzf $SRCPACK
docker pull rockywei/swift:4.0
docker run -it -v $REPO:/home -w /home rockywei/swift:4.0 /bin/bash -c "swift build -c release && swift test"
echo "-------------- OS X / Xcode ----------------"
popd
swift build -c release
swift test
