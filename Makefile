IMAGES=$(patsubst src/%.gv,build/%.png,$(wildcard src/*.gv)) \
	build/out_1.png \
	build/out_2.png \
	build/out_3.png \
	build/out_4.png \
	build/out_5.png \
	build/bdd.png

all: images

clean:
	rm -f $(wildcard build/*)

images: $(IMAGES)

build/%.png: src/%.gv
	dot -Tpng -Gdpi=1000 -o'$@' '$<'

build/out_1.png: build/not_R.png build/implies.png build/Q_and_P.png
	convert $^ -gravity center +append $@

build/out_2.png: build/not_R.png build/implies.png build/0.png
	convert $^ -gravity center +append $@

build/out_3.png: build/not_R.png build/implies.png build/Q.png
	convert $^ -gravity center +append $@

build/out_4.png: build/not_R.png build/implies.png build/0.png
	convert $^ -gravity center +append $@

build/out_5.png: build/not_R.png build/implies.png build/1.png
	convert $^ -gravity center +append $@

build/bdd.png: build/P_and_Q_xor_R.png build/not_P_implies_Q_and_R.png build/b_5.png
	montage null: null: $^ null: null: -tile 7x1 -geometry +400+400 $@
