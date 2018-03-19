	.segment "CODE"

initialize_game:
	lda	#0
	sta	initgamecounter
	FRAMEFUNC	initialize_game_loopframe
initialize_game_loopframe:

	;	NMI still active, 8x sprites, Background in $0000, Sprites also in $0000, Increment 32!!!, Nametable at $2000
	lda	#%10000100
	sta	PPU_CTRL

	; Clear the visible screen (at $2000)
	lda	#$20
	sta	$2006
	lda	initgamecounter
	sta	$2006
	
	ldx	#30
	lda	#0
@loop:	sta	$2007
	dex
	bne	@loop
	
	; In parallel, also clear the second screen (at $2400)
	lda	#$24
	sta	$2006
	lda	initgamecounter
	sta	$2006
	
	ldx	#30
	lda	#0
@loop2:	sta	$2007
	dex
	bne	@loop2
	
	lda	#$20
	sta	$2006
	lda	#0
	sta	$2006
	sta	$2005
	sta	$2005
	
	inc	initgamecounter
	lda	#32
	cmp	initgamecounter
	bne	@rts
	
	FRAMEFUNC initialize_game_clearattribs
	
@rts:	;	NMI still active, 8x sprites, Background in $0000, Sprites also in $0000, Increment 1!!!, Nametable at $2000
	lda	#%10000000
	sta	PPU_CTRL
	rts
	
initialize_game_clearattribs:
	; First screen
	lda	#$23
	sta	$2006
	ldx	#$c0
	stx	$2006
	
	lda	#0
	
@loop:	sta	$2007
	inx
	bne	@loop
	
	; Second screen
	lda	#$27
	sta	$2006
	ldx	#$c0
	stx	$2006
	
	lda	#0
	
@loop2:	sta	$2007
	inx
	bne	@loop2
	
	; Eyes are still visible... Blink twice and then go to game!
	
	lda	#0
	sta	initgamecounter
	FRAMEFUNC initialize_game_blink_eyes
	rts

initialize_game_blink_eyes:
	inc	initgamecounter
	lda	initgamecounter
	cmpframes 20
	beq	@blinkoff
	cmpframes 25
	beq	@blinkon
	cmpframes 50
	beq	@blinkoff
	cmpframes 55
	beq	@blinkon
	cmpframes 100
	beq	@blinkoff
	cmpframes 110
	beq	@nextphase
	rts
@blinkoff:
	jmp	hide_all_sprites_cpu
@blinkon:
	jmp	dog_show_eyes
@nextphase:
	
	ldxy	game_palette_temp
	jsr	printxy
	
	lda	#0
	sta	scrollleft
	sta	playery
	sta	playerdy
	sta	playerdx
	sta	playerysubpixel
	sta	updatetilex
	sta	current_score
	sta	current_score+1
	sta	current_score+2
	sta	$101
	lda	#112
	sta	playery+1
	
	lda	#60
	sta	next_topa_all_bits
	lda	#156
	sta	next_bottoma_all_bits
	lda	#76
	sta	next_topb_all_bits
	lda	#172
	sta	next_bottomb_all_bits
	
	lda	#1
	sta	gamerunning
	
	lda	framecounter
	sta	randomseed
	adc	#$3f
	sta	randomseed+1
	
	FRAMEFUNC gameframefunc
	rts

game_palette_temp:
	.byte	$3f, $00, 4
	.byte	$38, $2c, $27, $28
	
	.byte	$3f, $11, 3
	;.byte	32, 16, 0	; FREJA
	.byte	32, 39, 23	; KAJSA
	
	.byte	$3f, $1d, 3
	.byte	1, 4, 7
	
	.byte	0
	
	