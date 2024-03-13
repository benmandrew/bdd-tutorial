all: \
	build/out_1.png \
	build/out_2.png \
	build/out_3.png \
	build/out_4.png \
	build/out_5.png \
	build/out_6.png \
	build/out_7.png \
	build/out_8.png \
	build/out_9.png \
	build/out_10.png \
	build/out_11.png \
	build/out_12.png \
	build/out_13.png

clean:
	rm -f $(wildcard build/*)

build/%.png: src/%.gv
	dot -Tpng -Gdpi=1000 -o'$@' '$<'

build/out_1.png: build/not_R.png build/implies.png build/Q_and_P.png
	convert $^ -gravity center +append $@

build/out_2.png: build/not_R.png build/implies.png build/0.png
	convert $^ -gravity center +append $@

build/out_3.png: build/R.png
	cp $< $@

build/out_4.png: build/not_R.png build/implies.png build/Q.png
	convert $^ -gravity center +append $@

build/out_5.png: build/not_R.png build/implies.png build/0.png
	convert $^ -gravity center +append $@

build/out_6.png: build/not_R.png build/implies.png build/1.png
	convert $^ -gravity center +append $@

build/out_7.png: build/R.png
	cp $< $@

build/out_8.png: build/1.png
	cp $< $@

build/out_9.png: build/a_1.png
	cp $< $@

build/out_10.png: build/a_2.png
	cp $< $@

build/out_11.png: build/a_3.png
	cp $< $@

build/out_12.png: build/not_P_implies_Q_and_R.png
	cp $< $@

build/out_13.png: build/P_and_Q_xor_R.png
	cp $< $@
