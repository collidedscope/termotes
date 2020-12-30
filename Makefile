all: montage sizes

montage: examples/montage.cr
	crystal build --release --no-debug examples/montage.cr

sizes: examples/sizes.cr
	crystal build --release --no-debug examples/sizes.cr
