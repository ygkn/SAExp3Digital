# [1] * 100
# r0 ずっと 0
# r1 メモリのアドレス
# r2 書き込む定数
# r3 アドレスの増分値
# r4 終了判定に使う定数

	LI  r0, 0
	LI	r1,	0
	LI	r2,	1
	LI	r3,	1
	LI	r4,	-101
LP1:	ST		(r1),	r2
	ADD	r1,	r1,	r3
	ADD	r5,	r1,	r4
	BNZ	r5,	LP1:

# r1 操作中のメモリのアドレス
# r2 値
# r3 アドレスの増分値
# r4 終了判定に使う定数
# r5 終了判定
# r6 素数の数
# r7 埋める時のメモリのアドレス
#
	LI	r1,	0
	LI	r2,	0
	LI	r3,	1
	LI	r4,	100
	LI	r6,	0
LP2:	LD	r1,	r2
	BNZ	r2,	CON:

	ADD	r7,	r1, r0
LP3:	MLT	r7,	r7,	r7
	ADD	r6,	r3, r6
	ST		(r7),	r2 # BNZ があったので r2 は 0
	ADD	r7,	r1,	r7
	SGT	r5,	r7,	r4
	BNZ	r5,	LP3:

CON:	ADD	r1,	r3,	r1
	SGT	r5,	r1,	r4
	BNZ	r5,	LP2:

HLT:	B	HLT:
