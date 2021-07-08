# [1] * 100
# r0 ずっと 0
# r1 ずっと 1
# r2 アドレス

# r4 終了判定に使う定数
# r5 終了判定


	LI  r0, 0
	LI	r1,	1
	LI	r2,	3

	LI	r4,	100

LP1:	ST		(r2),	r1
	ADD	r2,	r2,	r1

	SGT	r5,	r4,	r2
	BNZ	r5,	LP1:

# r0 ずっと 0
# r1 ずっと 1

# r2 アドレス
# r3 値

# r4 終了判定に使う定数
# r5 終了判定

# r6 埋める時のメモリのアドレス

# r7 素数の数

	LI	r2,	3

	LI	r7,	1

LP2:	LD	r3,	(r2)

	BZ	r3,	CON:

	ADD	r7,	r7, r1

	MLT	r6,	r2,	r2

LP3:	ST		(r6),	r0

	ADD	r6,	r6,	r2

	SGT	r5,	r4,	r6
	BNZ	r5,	LP3:

CON:	ADD	r2,	r2,	r1
	ADD	r2,	r2,	r1
	SGT	r5,	r4,	r2
	BNZ	r5,	LP2:

HLT:	B	HLT:
