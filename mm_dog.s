	.segment	"CODE"
	
dog_showmenu_01:

	;--------------------------------------------------
	;
	;	SET PALETTE
	;
	;--------------------------------------------------
	
	lda	#$3f
	sta	$2006
	lda	#$00
	sta	$2006
	ldx	#0
@paletteloop:
	ldxy	menupalettedata
	jsr	printxy
	
	jsr	framebreak

	;--------------------------------------------------
	;
	;	CLEAR BOTH SUBSCREENS
	;	AND THEIR ATTRIBUTES
	;
	;--------------------------------------------------
	
	ldx	#$20
@blockloop:
	stx	$2006
	lda	#$00
	sta	$2006
	.if (REGION = NTSC)
	ldy	#192
	.else
	ldy	#00
	.endif
	
@loop:	sta	$2007		; 4 cycles
	sta	$2007		; 4 cycles
	sta	$2007		; 4 cycles
	sta	$2007		; 4 cycles
	iny			; 2 cycles
	bne	@loop		; 3 cycles (4 if crossing page boundary) ; 21-22 cycles per 4 bytes -> 256/4*22 = 1408 cycles per block - fits in 1700 cycles for NTSC
	
	jsr	framebreak	; Breaks after each 256 byte block for NTSC, after each 1024 byte block for PAL!
	inx
	txa
	.if (REGION = NTSC)
	cmp	#$28
	.else
	cmp	#$22		; For PAL, the X register isn't actually accurate, but that doesn't matter
	.endif
	bne	@blockloop
	
	;--------------------------------------------------
	;
	;	SET TILE ATTRIBUTES FOR MENU SCREEN
	;
	;	Top 16 tile lines (4 lines of attributes): 0 for now...
	;	Next 4 tile lines (2 empty plus top 2 Kajsa : 1 line of attributes): 0x05 for now... (attribute 1 - add 4 to Kajsa colors)
	;	Next 4 tile lines (lines 3-6 of Kajsa : 1 line of attributes): 0x5a for now (attribute 1/2 - add 4/8 to Kajsa colors)
	;	Next 4 tile lines (lines 7-10 of Kajsa : 1 line of attributes): 0xaf for now... (attribute 2/3 - add 12 to all colors)
	;	Next 2 tile lines : 1 line of attributes : 0xff for now
	;
	;--------------------------------------------------

	lda	#$23
	sta	$2006
	lda	#$c0
	sta	$2006
	
	ldx	#0
	ldy	#32
@tophalfattributesloop:
	stx	$2007
	dey
	bne	@tophalfattributesloop
	
	lda	#$50
	ldy	#8
@topdogattributesloop:
	sta	$2007
	dey
	bne	@topdogattributesloop
	
	lda	#$a5
	ldy	#8
@middledogattributesloop:
	sta	$2007
	dey
	bne	@middledogattributesloop
	
	lda	#$fa
	ldy	#8
@bottomdogattributesloop:
	sta	$2007
	dey
	bne	@bottomdogattributesloop
	
	lda	#$ff
	ldy	#8
@bottomattributesloop:
	sta	$2007
	dey
	bne	@bottomattributesloop
	
	jsr	framebreak
	
	
	
	
	
	ldxy	kajsa_photo_text1
	jsr	printxy
	
	.if (REGION = NTSC)
	ldx	#$20
	stx	$2006
	ldx	#0
	stx	$2006
	
	jsr	framebreak
	
	ldxy	kajsa_photo_text2
	jsr	printxy
	.endif
	
	ldx	#$20
	stx	$2006
	ldx	#0
	stx	$2006
	
	jsr	framebreak
	
	jsr	dog_show_eyes
	
	ldx	#$20				; This is the first time that screen address and smooth scroll are really important to set!
	stx	$2006
	ldx	#0
	stx	$2006
	stx	$2005
	stx	$2005
	
	PLAYMUSIC	dog_appears_music
	
	ldxframes	50
	DELAYX	dog_showmenu_04
	rts

dog_show_eyes:
	; Show Kajsa's beautiful eyes!
	lda	#0
	sta	$2003
	sta	$2003
	ldx	#181	; Y - 1
	stx	$2004
	ldy	#223	; Sprite tile
	sty	$2004
	;lda	#0	; attributes
	sta	$2004
	ldy	#132	; X
	sty	$2004
	;ldx	#181	; Y - 1
	stx	$2004
	ldy	#223	; Sprite tile
	sty	$2004
	;lda	#0	; attributes
	sta	$2004
	ldy	#156	; X
	sty	$2004
	rts

hide_all_sprites_cpu:
	lda	#0
	sta	$2003
	sta	$2003
	lda	#$fe
	ldx	#192
	
@loop:	sta	$2004
	sta	$2004
	sta	$2004
	sta	$2004
	inx
	bne	@loop
	rts

dog_showmenu_04:
	ldxy	the_adventures_text
	jsr	printxy
	
	ldx	#$20
	stx	$2006
	ldx	#0
	stx	$2006
	stx	$2005
	stx	$2005

	PLAYMUSIC	text1_appears_music
	
	ldxframes	50
	DELAYX	dog_showmenu_05
	rts

dog_showmenu_05:
	ldxy	kajsa_big_text
	jsr	printxy
	
	ldx	#$20
	stx	$2006
	ldx	#0
	stx	$2006
	stx	$2005
	stx	$2005
	
	PLAYMUSIC	text2_appears_music
	
	ldxframes	80
	DELAYX	dog_showmenu_06
	rts

dog_showmenu_06:
	lda	#00
	sta	mainmenuframecounter
	PLAYMUSIC	main_menu_music
	FRAMEFUNC	dog_showmenu_06b
	
dog_showmenu_06b:
	lda	mainmenuframecounter
	cmp	#0
	beq	@print_press_start
	cmpframes	40
	beq	@print_spaces
	cmpframes	55
	beq	@clear_counter
	
@increase_and_end:
	lda	mainmenuframecounter
	tax
	inx
	stx	mainmenuframecounter
	
@end:	ldx	#$20
	stx	$2006
	ldx	#0
	stx	$2006
	stx	$2005
	stx	$2005
	
	lda	controller1
	and	#BUTTON_START
	beq	@dont_start_game
	PLAYMUSIC	main_menu_startbutton_music
	FRAMEFUNC	initialize_game
@dont_start_game:	
	rts
	
@clear_counter:
	lda	#0
	sta	mainmenuframecounter
	jmp	@end
	
@print_press_start:
	ldxy	press_start_to_play_text
	jsr	printxy
	jmp	@increase_and_end
	
@print_spaces:
	ldxy	press_start_to_play_blank
	jsr	printxy
	jmp	@increase_and_end

	.segment "RODATA"

	.include	"dog_music.s"

press_start_to_play_text:
	;	Y=14, X=10, ADDR=$21ca, LEN=12, "PRESS  START"
	.byte	$21, $ca, 12
	.byte	$10, $12, $05, $13, $13, $00, $00, $13, $14, $01, $12, $14
	.byte	0
	
press_start_to_play_blank:
	;	Y=14, X=10, ADDR=$21ca, CLEAR, LEN=12, "           "
	.byte	$a1, $ca, 12
	.byte	0
	
the_adventures_text:
	;	Y=2, X=15, ADDR=$204f, LEN=2, "te"
	.byte	$20, $4f, 2, $e0, $e1
	;	Y=3, X=11, ADDR=$206b LEN=10, "ADVENTURES"
	.byte	$20, $6b, 10, 1, 4, 22, 5, 14, 20, 21, 18, 5, 19
	;	Y=4, X=15, ADDR=$208f LEN=2, "OF"
	.byte	$20, $8f, 2, 15, 6
	;	STOP
	.byte	$00

kajsa_big_text:
	;	Y=6, X=11, ADDR=$20cb LEN=10, "KKAAJJSSAA" top blocks
	.byte	$20, $cb, 10, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235
	;	Y=7, X=11, ADDR=$20eb LEN=10, "KKAAJJSSAA" middle blocks
	.byte	$20, $eb, 10, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245
	;	Y=8, X=11, ADDR=$210b LEN=10, "KKAAJJSSAA" middle blocks
	.byte	$21, $0b, 10, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255
	.byte	0

menupalettedata:
	.byte	$3f, $00, 20
	;	Top half text menu: Black background, White, cyan, orange
	.byte	$3f, $20, $2c, $27
	;	Mostly red tones of Kajsa
	.byte	$3f, $37, $17, $07
	;	White and reds of Kajsa
	.byte	$19, $20, $27, $07
	;	White, grey and nose of Kajsa
	.byte	$1c, $20, $10, $08
	
	;	Sprite paletteloop
	.byte	$3f, $11, $21, $3f
	.byte	0

kajsa_photo_text1:
	.byte	$22, $4e, 2
	.byte	128+21, 129+21
	.byte	$22, $55, 1
	.byte	130+21
	
	.byte	$22, $6e, 8
	.byte	131+21, 132+21, 133+21, 134+21, 135+21, 136+21, 137+21, 138+21
	
	.byte	$22, $8e, 8
	.byte	139+21, 140+21, 141+21, 142+21, 143+21, 144+21, 145+21, 146+21
	
	.byte	$22, $ad, 9
	.byte 	147+21, 148+21, 149+21, 150+21, 151+21, 152+21, 153+21, 154+21, 155+21
	
	.byte	$22, $cc, 10
	.byte	156+21, 157+21, 158+21, 159+21, 160+21, 161+21, 162+21, 163+21, 164+21, 165+21
	
	.if (REGION = NTSC)
	.byte	0
kajsa_photo_text2:
	.endif
	
	.byte	$22, $ea, 12
	.byte	166+21, 167+21, 168+21, 169+21, 170+21, 171+21, 172+21, 173+21, 174+21, 175+21, 176+21, 177+21
	
	.byte	$23, $0a, 11
	.byte	178+21, 179+21, 180+21, 181+21, 182+21, 183+21, 184+21, 185+21, 186+21, 187+21, 188+21
	
	.byte	$23, $2f, 6
	.byte	189+21, 190+21, 191+21, 192+21, 193+21, 194+21
	
	.byte	$23, $50, 4
	.byte	195+21, 196+21, 197+21, 198+21
	
	.byte	$23, $71, 3
	.byte	199+21, 200+21, 201+21

	.byte	0
	
	
	
	