;	scrollleft = $87	;9-bit!
;	updatetilex = $89	;6-bit!

	.segment "CODE"
	
gamecode:
	lda	framecounter
	tax
@framewait:
	txa
	eor	framecounter
	beq	@framewait
	
	lda	updatetilex
	cmp	gamelast_updatetilex
	bne	@newupdatetilex
	jmp	@nonewupdatetilex
@newupdatetilex:
	sta	gamelast_updatetilex
	tax
	
	lda	next_topa_all_bits
	ror
	ror
	ror
	and	#31
	sta	walls_topa_list, x
	
	lda	next_bottoma_all_bits
	ror
	ror
	ror
	and	#31
	sta	walls_bottoma_list, x
	
	lda	next_topb_all_bits
	ror
	ror
	ror
	and	#31
	sta	walls_topb_list, x
	
	lda	next_bottomb_all_bits
	ror
	ror
	ror
	and	#31
	sta	walls_bottomb_list, x
	
	
	; Modify next_*_all_bits in a good random way...
	inc	road_adjust_counter
	lda	road_adjust_counter
	and	#15
	sta	road_adjust_counter
	bne	@no_prng
	jsr	prng
	sta	road_adjust_bits
	jsr	prng
	and	#7
	sta	road_adjust_counter
@no_prng:
	lda	road_adjust_bits
	ror
	tax
	bcc	@inc_topa
@dec_topa:
	dec	next_topa_all_bits
	lda	#15
	cmp	next_topa_all_bits
	bne	@topa_done
	inc	next_topa_all_bits
	bne	@topa_done
@inc_topa:
	inc	next_topa_all_bits
	lda	#232-32-48
	cmp	next_topa_all_bits
	bne	@topa_done
	dec	next_topa_all_bits
@topa_done:
	txa
	
	ror
	tax
	bcc	@inc_bottoma
@dec_bottoma:
	dec	next_bottoma_all_bits
	bne	@check_bottoma
@inc_bottoma:
	inc	next_bottoma_all_bits
	lda	#232-32
	cmp	next_bottoma_all_bits
	bcc	@bottoma_too_far_down
@check_bottoma:
	lda	next_topa_all_bits
	clc
	adc	#48
	cmp	next_bottoma_all_bits
	bcc	@bottoma_not_too_far_up
	inc	next_bottoma_all_bits
	inc	next_bottoma_all_bits
	bne	@bottoma_done
@bottoma_not_too_far_up:
	adc	#48
	cmp	next_bottoma_all_bits
	bpl	@bottoma_done
@bottoma_too_far_down:
	dec	next_bottoma_all_bits
	dec	next_bottoma_all_bits
@bottoma_done:
	txa
	
	ror
	tax
	bcc	@inc_topb
@dec_topb:
	dec	next_topb_all_bits
	lda	#31
	cmp	next_topb_all_bits
	bne	@topb_on_itself_done
	inc	next_topb_all_bits
	inc	next_topb_all_bits
	bne	@topb_done
@inc_topb:
	inc	next_topb_all_bits
	lda	#232-16-48
	cmp	next_topb_all_bits
	bpl	@topb_on_itself_done
	dec	next_topb_all_bits
	bne	@topb_done
@topb_on_itself_done:
	lda	next_topa_all_bits
	adc	#16
	cmp	next_topb_all_bits
	bmi	@topb_done
	inc	next_topb_all_bits
	inc	next_topb_all_bits
@topb_done:
	txa
	
	ror
	tax
	bcc	@inc_bottomb
@dec_bottomb:
	dec	next_bottomb_all_bits
	bne	@check_bottomb
@inc_bottomb:
	inc	next_bottomb_all_bits
	lda	#232-16
	cmp	next_bottomb_all_bits
	bmi	@bottomb_too_far_down
@check_bottomb:
	lda	next_topb_all_bits
	clc
	adc	#48
	cmp	next_bottomb_all_bits
	bcc	@bottomb_not_too_far_up
	dec	next_topb_all_bits
	dec	next_topb_all_bits
	bne	@bottomb_done
@bottomb_not_too_far_up:
	adc	#48
	cmp	next_bottomb_all_bits
	bpl	@bottomb_done
@bottomb_too_far_down:
	dec	next_bottomb_all_bits
@bottomb_done:
	txa
	
	;inc	next_topa_all_bits
	;inc	next_bottoma_all_bits
	;dec	next_topb_all_bits
	;dec	next_bottomb_all_bits
	;jsr	prng
	;tay
	;and	#$7
	;clc
	;adc	#$fc
	;bne	@mod_found
	;adc	#1
;@mod_found:
	;clc
	;adc	next_topa_all_bits
	;sta	next_topa_all_bits
	
@both_top_and_bottom_updated:
	
	
	;	If score == 0, only add 1 to score if updatetilex == 63
	;	Otherwise, add 1 to score
	lda	#255
	bit	current_score+2
	bne	@increase_score
	bit	current_score+1
	bne	@increase_score
	bit	current_score
	bne	@increase_score
	lda	#63
	cmp	updatetilex
	bne	@dont_increase_score
@increase_score:
	inc	current_score+2
	lda	#15
	and	current_score+2
	cmp	#10
	bne	@increase_score_done
	lda	#$06
	clc
	adc	current_score+2
	sta	current_score+2
	cmp	#$a0
	bcc	@increase_score_done
	lda	#0
	sta	current_score+2
	
	
	inc	current_score+1
	lda	#15
	and	current_score+1
	cmp	#10
	bne	@increase_score_done
	lda	#$06
	clc
	adc	current_score+1
	sta	current_score+1
	cmp	#$a0
	bcc	@increase_score_done
	lda	#0
	sta	current_score+1
	
	
	inc	current_score
	lda	#15
	and	current_score
	cmp	#10
	bne	@increase_score_done
	lda	#$06
	clc
	adc	current_score
	sta	current_score
	cmp	#$a0
	bcc	@increase_score_done
	lda	#0
	sta	current_score
@dont_increase_score:
@increase_score_done:


@nonewupdatetilex:

	
	lda	controller1
	tax
	and	#BUTTON_RIGHT
	beq	@noright
	
@right_button_pressed:
	lda	playerdx
	clc
	.if (REGION = NTSC)
	adc	#5
	cmp	#5*20
	bcc	@speed_adjust_rega_done
	lda	#5*20
	bne	@speed_adjust_rega_done
	.else
	adc	#6
	cmp	#6*20
	bcc	@speed_adjust_rega_done
	lda	#6*20
	bne	@speed_adjust_rega_done
	.endif

@noright:
	
	
	
	lda	playerdx
	sec
	.if (REGION = NTSC)
	sbc	#20
	bcs	@speed_decrease_rega_done
	lda	#0
@speed_decrease_rega_done:
	adc	#15
	.else
	sbc	#24
	bcs	@speed_decrease_rega_done
	lda	#0
@speed_decrease_rega_done:
	adc	#18
	.endif

@speed_adjust_rega_done:
	sta	playerdx
	
	
	
	
	txa
	and	#BUTTON_DOWN+BUTTON_UP
	beq	@no_up_or_down
	and	#BUTTON_UP
	beq	@gee
	
@haw_button_pressed:
	lda	playerdy
	clc
	.if (REGION = NTSC)
	sbc	#5
	cmp	#256-5*5
	bpl	@speed_geehaw_adjust_rega_done
	lda	#256-5*5
	bne	@speed_geehaw_adjust_rega_done
	.else
	sbc	#6
	cmp	#256-6*5
	bpl	@speed_geehaw_adjust_rega_done
	lda	#256-6*5
	bne	@speed_geehaw_adjust_rega_done
	.endif
@gee:
	lda	playerdy
	clc
	.if (REGION = NTSC)
	adc	#5
	cmp	#5*5
	bmi	@speed_geehaw_adjust_rega_done
	lda	#5*5
	bne	@speed_geehaw_adjust_rega_done
	.else
	adc	#6
	cmp	#6*5
	bmi	@speed_geehaw_adjust_rega_done
	lda	#6*5
	bne	@speed_geehaw_adjust_rega_done
	.endif
@no_up_or_down:
	lda	playerdy
	bpl	@slow_down_from_gee
@slow_down_from_haw:
	sec
	ror
	adc	#0
	jmp	@speed_geehaw_adjust_rega_done
@slow_down_from_gee:
	clc
	ror
@speed_geehaw_adjust_rega_done:
	sta	playerdy
	
	
	
@handle_playerpos_y:
	lda	playerdy
	bpl	@handle_playerpos_gee
@handle_playerpos_haw:
	rol
	rol
	rol
	and	#$f8
	clc
	adc	playery
	sta	playery
	bcs	@playerpos_y_done
	dec	playery+1
	jmp	@playerpos_y_done
@handle_playerpos_gee:
	rol
	rol
	rol
	and	#$f8
	clc
	adc	playery
	sta	playery
	bcc	@playerpos_y_done
	inc	playery+1
@playerpos_y_done:
	
@handle_playerpos_x:
	lda	scrollleft
	clc
	adc	playerdx
	
	sta	scrollleft
	bcc	@scrollleft_upperbit_done
	
	inc	scrollleft+1
	lda	#$3f
	and	scrollleft+1
	sta	scrollleft+1
@scrollleft_upperbit_done:

@movement_done:
	;	1. Check if UPDATETILEX != ((SCROLLLEFT >> 8 + 48) & 63)
	lda	scrollleft+1
	clc
	adc	#40
	and	#63
	
	cmp	updatetilex
	bne	@dowritetiles
	
	;	No updating needed!
	;	Clear the nametable drawing buffer!
	lda	#0
	sta	$101
	jmp	@update_sprites

@dowritetiles:
	;	LEN = 30 (increase 32)
	lda	#30
	sta	$101
	iny
	
	;	High byte = ((X >> 3) & 4) | $20
	lda	updatetilex
	tax
	ror
	ror
	ror
	and	#$4
	ora	#$20
	sta	$102
	iny
	
	;	Low byte = X & 31
	txa
	and	#31
	sta	$103
	iny
	
	ldy	#$00
	
@blockloop:
	; y = block index from top!
	tya
	and	#31
	ldx	updatetilex
	cmp	walls_topa_list, x
	beq	@on_top_a
	bcs	@below_top_a
@above_top_a:
@above_top_b:
	lda	#191
	bne	@block_rega_found
@on_top_a:
@on_top_b:
	lda	#63		; TODO: adjust to sub-tile thing
	bne	@block_rega_found

@below_top_a:
	cmp	walls_bottoma_list,x
	beq	@on_bottom_a
	bcs	@below_bottom_a
@above_bottom_a:
@above_bottom_b:
	lda	#0
	beq	@block_rega_found
@on_bottom_a:
	cmp	walls_topb_list, x
	bcs	@below_top_b
	lda	#127		; TODO: adjust to sub_tile thing
	bne	@block_rega_found

@below_bottom_a:
	cmp	walls_topb_list, x
	beq	@on_top_b
	bcc	@above_top_b
@below_top_b:
	cmp	walls_bottomb_list, x
	beq	@on_bottom_b
	bcc	@above_bottom_b
@below_bottom_b:
	lda	#191
	bne	@block_rega_found
@on_bottom_b:
	lda	#127		; TODO: sdjust to sub_tile thing
	bne	@block_rega_found
	
@block_rega_found:
	sta	$104, y
	iny
	cpy	#30
	bne	@blockloop
	
	lda	#0
	sta	$104, y
	
	lda	updatetilex
	clc
	adc	#1
	and	#63
	sta	updatetilex
	
	
	
	
@update_sprites:
	;	Update page 2 with sprite data
	;	Y coordinates
	lda	playery+1
	sta	$0280
	sta	$0284
	sta	$0288
	clc
	adc	#8
	sta	$028c
	sta	$0290
	sta	$0294
	;	Tile indices (use look-up tables)
	;	TODO: Use a separate animation frame counter (because 9 frames...)
	lda	scrollleft+1
;	ror
;	ror
;	ror
	and	#7
	tax
	lda	running_top_left_tiles, x
	sta	$0281
	lda	running_top_center_tiles, x
	sta	$0285
	lda	running_top_right_tiles, x
	sta	$0289
	lda	running_bottom_left_tiles, x
	sta	$028d
	lda	running_bottom_center_tiles, x
	sta	$0291
	lda	running_bottom_right_tiles, x
	sta	$0295
	;	Flags
	lda	#0
	sta	$0282
	sta	$0286
	sta	$028a
	sta	$028e
	sta	$0292
	sta	$0296
	;	X coordinates
	lda	playerdx
	ror
	ror
	ror
	ror
	and	#15
	clc
	adc	#20
	sta	$0283
	sta	$028f
	adc	#8
	sta	$0287
	sta	$0293
	adc	#8
	sta	$028b
	sta	$0297
	
	.ifdef DEBUG
	lda	next_topa_all_bits
	sta	$02f0
	lda	#1
	sta	$02f1
	lda	#0
	sta	$02f2
	lda	#230
	sta	$02f3
	
	lda	next_bottoma_all_bits
	sta	$02f4
	lda	#1
	sta	$02f5
	lda	#0
	sta	$02f6
	lda	#238
	sta	$02f7
	
	lda	next_topb_all_bits
	sta	$02f8
	lda	#2
	sta	$02f9
	lda	#0
	sta	$02fa
	lda	#230
	sta	$02fb
	
	lda	next_bottomb_all_bits
	sta	$02fc
	lda	#2
	sta	$02fd
	lda	#0
	sta	$02fe
	lda	#238
	sta	$02ff
	.endif
	
	
	
	; SCORE
	; Y coords
	lda	#16
	sta	$0210
	sta	$0214
	sta	$0218
	sta	$021c
	sta	$0220
	sta	$0224
	; Flags
	lda	#3
	sta	$0212
	sta	$0216
	sta	$021a
	sta	$021e
	sta	$0222
	sta	$0226
	; X coords
	lda	#30
	sta	$0213
	lda	#37
	sta	$0217
	lda	#44
	sta	$021b
	lda	#51
	sta	$021f
	lda	#58
	sta	$0223
	lda	#65
	sta	$0227
	; Score sprite tiles
	lda	current_score
	tax
	ror
	ror
	ror
	ror
	and	#15
	clc
	adc	#32
	sta	$0211
	txa
	and	#15
	adc	#32
	sta	$0215
	
	lda	current_score + 1
	tax
	ror
	ror
	ror
	ror
	and	#15
	clc
	adc	#32
	sta	$0219
	txa
	and	#15
	adc	#32
	sta	$021d
	
	lda	current_score + 2
	tax
	ror
	ror
	ror
	ror
	and	#15
	clc
	adc	#32
	sta	$0221
	txa
	and	#15
	adc	#32
	sta	$0225
	
	rts

	
gameframefunc:
	;	Use sprite DMA
	lda	#2
	sta	$4014

	;	Use a buffer of max. 160 bytes to draw into nametables
	;	Stored as a stack
	;	Format:
	;	$0101: LEN of block 0	(bit 7 : 0 = inc32, 1 = inc1)
	;	$0102: HIGH byte of nametable starting address
	;	$0103: LOW byte of nametable starting address
	;	$0104: first data byte to write
	;	...
	;	$01??: LEN of block 1 (0 or $80: done!)
	tsx
	stx	gameframefunc_stackpointer_save
	ldx	#$00
	txs
	
@printloop:
	pla			; length
	bpl	@setstep32
	; SET STEP 1
	ldx	#$90		; Base nametable address = $2400		(------00)	00=$2000 01=$2400 10=$2800 11=$2c00
				; PPU_ADDR += 1 for each PPU_DATA write		(-----0--)	1= += 32
				; Sprite pattern table address = $1000		(----0---)	0= $0000 1= $1000
				; Background pattern table address = $0000	(---1----)	0= $0000 1= $1000
				; Sprite size = 8x8				(--0-----)	1= 8x16
				; Enable NMI at each V-blank			(1-------)	1= Enable (needed for sprites)
	stx	PPU_CTRL
	
	bne	@stepsetdone
@setstep32:
	; SET STEP 32
	ldx	#$94		; Base nametable address = $2400		(------00)	00=$2000 01=$2400 10=$2800 11=$2c00
				; PPU_ADDR += 32 for each PPU_DATA write	(-----1--)	0= += 1, 1= += 32
				; Sprite pattern table address = $1000		(----0---)	0= $0000 1= $1000
				; Background pattern table address = $0000	(---1----)	0= $0000 1= $1000
				; Sprite size = 8x8				(--0-----)	1= 8x16
				; Enable NMI at each V-blank			(1-------)	1= Enable (needed for sprites)
	stx	PPU_CTRL
@stepsetdone:
	and	#$7f
	beq	@printend
	tax
	pla
	sta	$2006
	pla
	sta	$2006
@loop:	pla
	sta	$2007
	dex
	bne	@loop
	beq	@printloop
@printend:
	
	ldx	gameframefunc_stackpointer_save
	txs
	
	lda	#0
	sta	$101
	
	; Set scroll correctly using the variables in zeropage!
	lda	scrollleft+1
	ror
	ror
	ror
	and	#4
	ora	#$20
	sta	$2006
	
	lda	#0
	sta	$2006
	
	lda	scrollleft
	ror
	ror
	ror
	ror
	ror
	and	#7
	sta	localtempvar1
	lda	scrollleft+1
	rol
	rol
	rol
	and	#$f8
	ora	localtempvar1
	sta	$2005
	
	lda	#0
	sta	$2005
	
	rts
	
	
	.segment "RODATA"
running_top_left_tiles:
	.byte	42, 48, 51, 56, 60, 64, 67, 71, 77
running_top_center_tiles:
	.byte	43, 43, 52, 52, 52, 52, 43, 72, 43
running_top_right_tiles:
	.byte	44, 44, 44, 44, 44, 44, 44, 73, 78
running_bottom_left_tiles:
	.byte	45, 49, 53, 57, 61, 65, 68, 74, 79
running_bottom_center_tiles:
	.byte	46, 46, 54, 58, 62, 66, 69, 75, 80
running_bottom_right_tiles:
	.byte	47, 50, 55, 59, 63, 63, 70, 76, 81