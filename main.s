; http://i.imgur.com/ZSHu2ah.png
; http://wiki.nesdev.com/w/index.php/PPU_scrolling
; http://wiki.nesdev.com/w/index.php/PPU_registers

.macro	ldxy	addr
	ldx	#<addr
	ldy	#>addr
.endmacro

.macro	cmpframes	palframes
	.if (REGION = NTSC)
	cmp	#(palframes*6/5)
	.else
	cmp	#palframes
	.endif
.endmacro

.macro	ldaframes	palframes
	.if (REGION = NTSC)
	lda	#(palframes*6/5)
	.else
	lda	#palframes
	.endif
.endmacro

.macro	ldxframes	palframes
	.if (REGION = NTSC)
	ldx	#(palframes*6/5)
	.else
	ldx	#palframes
	.endif
.endmacro

.macro	ldyframes	palframes
	.if (REGION = NTSC)
	ldy	#(palframes*6/5)
	.else
	ldy	#palframes
	.endif
.endmacro

.macro	WAITVBLANKSTART
	.local	loop
	lda	#$80
loop:	bit	PPU_STATUS
	bpl	loop
.endmacro

; FRAMEFUNC destroys X
.macro	FRAMEFUNC	func
	ldx	#<func				; 2 cycles
	stx	framefuncptr			; 3 cycles
	ldx	#>func				; 2 cycles
	stx	framefuncptr + 1		; 3 cycles
.endmacro					; TOTAL 10 cycles

; DELAYX destroys X
.macro	DELAYX	afterdelayfunc
	stx	delayframes			; 3 cycles
	ldx	#<afterdelayfunc		; 2 cycles
	stx	afterdelayfuncptr		; 3 cycles
	ldx	#>afterdelayfunc		; 2 cycles
	stx	afterdelayfuncptr + 1		; 3 cycles
	FRAMEFUNC	delayfunc		; 10 cycles
.endmacro					; TOTAL 23 cycles

; DELAYA destroys X
.macro	DELAYA	afterdelayfunc
	sta	delayframes			; 3 cycles
	ldx	#<afterdelayfunc		; 2 cycles
	stx	afterdelayfuncptr		; 3 cycles
	ldx	#>afterdelayfunc		; 2 cycles
	stx	afterdelayfuncptr + 1		; 3 cycles
	FRAMEFUNC	delayfunc		; 10 cycles
.endmacro					; TOTAL 23 cycles


; PLAYMUSIC clears X
.macro	PLAYMUSIC	musicdataaddress
	ldx	#<musicdataaddress		; 2 cycles
	stx	musicdata			; 3 cycles
	ldx	#>musicdataaddress		; 2 cycles
	stx	musicdata+1			; 3 cycles
	ldx	#$ff				; 2 cycles
	stx	musicwaitcount			; 3 cycles
	stx	musicwaitsubcount		; 3 cycles
.endmacro					; TOTAL 18 cycles


.macro	SILENCEMUSIC
	PLAYMUSIC	soundofsilence		; 15 cycles
.endmacro					; TOTAL 15 cycles


PPU_CTRL = $2000
PPU_MASK = $2001
PPU_STATUS = $2002
OAM_ADDRESS = $2003
OAM_DMA = $4014
APU_DMC = $4010
APU_STATUS = $4015
APU_FRAME_CTR = $4015

BUTTON_A        = 1 << 7
BUTTON_B        = 1 << 6
BUTTON_SELECT   = 1 << 5
BUTTON_START    = 1 << 4
BUTTON_UP       = 1 << 3
BUTTON_DOWN     = 1 << 2
BUTTON_LEFT     = 1 << 1
BUTTON_RIGHT    = 1 << 0

PAL = 1
NTSC = 0
;REGION = PAL

	; Memory addresses for my zero-page variables
	localtempvar1 = $80
	mainmenuframecounter = $81
	initgamecounter = $81
	gamelast_updatetilex = $81
	
	
	gamerunning = $82
	
	playerysubpixel = $83
	playery = $84	; 12-bit! (4 bits of subpixels)
	playerdy = $86	; SIGNED!!! Shifted left 4 bits for subpixel speeds
			; 0 : still
			; -6 * 5 = max "haw" speed (PAL)
			; -5 * 5 = max "haw" speed (NTSC)
			; +6 * 5 = max "gee" speed (PAL)
			; +5 * 5 = max "gee" speed (NTSC)
	playerdx = $87	; shifted left 5 bits for subpixel speeds.
	                ; 6 * 20 = max forward speed (PAL)
			; 5 * 20 = max forward speed (NTSC)
	
	                ; worlds max length = 65536 values = 64 screen widths
	scrollleft = $88	;14-bit! (5 bits of subpixels!)
	updatetilex = $8a	;6-bit!
	gameframefunc_stackpointer_save=$8b
	framecounter = $8c
	
	next_topa_all_bits = $8d
	next_bottoma_all_bits = $8e
	next_topb_all_bits = $8f
	next_bottomb_all_bits = $90
	road_adjust_bits = $91
	road_adjust_counter = $92
	
	current_score = $93	; 3 bytes - 6 bcd digits
	
	controller1 = $e9
	musicdata = $ea		; 16-bit pointer
	musicwaitsubcount = $ec ; 8-bit fraction of a wait counter
	musicwaitcount = $ed	; 8-bit frame wait counter : 16ths
	
	
	printxyaddr = $ee
	
	
	framefuncptr = $f0
	delayframes = $f2
	afterdelayfuncptr = $f3
	framebreak_areg = $f5
	framebreak_xreg = $f6
	framebreak_yreg = $f7
	framebreak_preg = $f8
	framebreak_rts = $f9	; 16-bit
	
	randomseed = $fb ; 16-bit
	
	walls_topa_list = $0800-64
	walls_bottoma_list = $0800-64-64
	walls_topb_list = $0800-64-64-64
	walls_bottomb_list = $0800-64-64-64-64
	
	.segment "HEADER"
	; https://wiki.nesdev.com/w/index.php/INES
	.byte	"NES",26
	.byte	2		; 32K PRG
	.byte	1		; 8K CHR
	.byte	1      		; Vertical mirroring
	.byte	0		; mapper 000 (NROM)
	.byte	0		; 0 banks of PRG RAM (advanced)
	.byte	REGION		; PAL (NTSC = 0)
	.byte	0		; reserved
	
	.segment "CHARS"
	; "LEFT" section of 256 tiles - addresses $0000..$0fff
	.incbin "first.chr"
	; "RIGHT" section of 256 tiles - addresses $1000..$1fff
	.incbin "second.chr"

	.segment "VECTORS"
	.word 0, 0, 0, nmi, reset, irq
	
	.segment "STARTUP" ; avoids warning
	
;	.segment "CODE"
;	.org	$8000
irq:
	rti

framebreak:				; 6 cycles (JSR)
	sta	framebreak_areg		; 3 cycles
	stx	framebreak_xreg		; 3 cycles
	sty	framebreak_yreg		; 3 cycles
	php				; 3 cycles
	pla				; 4 cycles
	sta	framebreak_preg		; 3 cycles
	pla				; 4 cycles
	sta	framebreak_rts		; 3 cycles
	pla				; 3 cycles
	sta	framebreak_rts+1	; 3 cycles
	.ifdef DEBUG
	ldx	#10			; 2 cycles
	DELAYX	@resume			
	.else
	FRAMEFUNC	@resume		; 10 cycles
	.endif
	rts				; 6 cycles
					; TOTAL 56 cycles
@resume:
	lda	framebreak_rts+1	; 3 cycles
	pha				; 3 cycles
	lda	framebreak_rts		; 3 cycles
	pha				; 3 cycles
	lda	framebreak_preg		; 3 cycles
	pha				; 3 cycles
	plp				; 4 cycles
	ldy	framebreak_yreg		; 3 cycles
	ldx	framebreak_xreg		; 3 cycles
	lda	framebreak_areg		; 3 cycles
	rts				; 6 cycles
					; TOTAL 37 cycles
	
nmi:	pha
	txa
	pha
	tya
	pha
	
	ldx	framefuncptr+1		; 3 cycles
	beq	@afterframefunc         ; 3 cycles
	jsr	@jmp			; 6 cycles
	
@afterframefunc:
	
	jsr	read_controller
	jsr	music_player
	
	pla
	tay
	pla
	tax
	pla
	
	inc	framecounter
	
	rti
@jmp:	jmp	(framefuncptr)		; 5 cycles

delayfunc:
	ldx	delayframes
	dex
	beq	@setupnextframe
	stx	delayframes
	rts
@setupnextframe:
	ldx	afterdelayfuncptr
	stx	framefuncptr
	ldx	afterdelayfuncptr + 1
	stx	framefuncptr + 1
	rts

reset:	sei			; disable IRQs
	cld			; disable decimal mode (?)
	
	ldx	#$40
	stx	$4017		; disable APU frame IRQ (?)
	
	ldx	#$ff
	txs			; set up stack
	
	inx			; now x = 0
	stx	PPU_CTRL	; disable NMI
	stx	PPU_MASK	; disable rendering
	stx	$4010		; disable DMC IRQs
	stx	framefuncptr
	stx	framefuncptr + 1
	
resetvblank1:			; wait for first V-blank
	WAITVBLANKSTART
	
resetclrmem:			; Clear RAM - setting page $03 to #$fe values...
	lda	#$00
	sta	$0000, x
	;sta	$0100, x	; No point in clearing the 6502 stack area...
	sta	$0300, x
	sta	$0400, x
	sta	$0500, x
	sta	$0600, x
	sta	$0700, x
	lda	#$fe
	sta	$0200, x	; Here be sprite coordinates
	inx
	bne	resetclrmem
	
	WAITVBLANKSTART
	
	;ldx	#$00
	;stx	OAM_ADDRESS	; initialize PPU OAM
	lda	#$02		; use page $0200-$02ff for OAM
	sta	OAM_DMA
	
;resetbeep:
;	lda	#$01 ; play short tone
;	sta	APU_STATUS
;	lda	#$9F
;	sta	$4000
;	lda	#$22
;	sta	$4003
	
	lda	#$20
	sta	$2006
	lda	#$00
	sta	$2006
	
	lda	#$80		; Base nametable address = $2000		(------00)	01=$2400 10=$2800 11=$2c00
				; PPU_ADDR += 1 for each PPU_DATA write		(-----0--)	1= += 32K
				; Sprite pattern table address = $0000		(----0---)	1= $1000
				; Background pattern table address = $0000	(---0----)	1= $1000
				; Sprite size = 8x8				(--0-----)	1= 8x16
				; Enable NMI at each V-blank			(1-------)	1= Enable (needed for sprites)
	sta	PPU_CTRL
	
	lda	#$1a		; Color mode				(-------0)
				; Disable left background clipping	(------1-)
				; Enable left sprite clipping		(-----0--)
				; Enable background rendering		(----1---)
				; Enable sprites rendering		(---1----)
				; Normal reds				(--0-----)
				; Normal greens				(-0------)
				; Normal blues				(0-------)
	sta	PPU_MASK
	
	
	WAITVBLANKSTART

	FRAMEFUNC setup_all
	
	lda	#0
	sta	gamerunning
forever:
	lda	gamerunning
	beq	forever
	
	jsr	gamecode
	jmp	forever

setup_all:
	jsr	init_apu
	
	FRAMEFUNC dog_showmenu_01
	
	rts


	.include	"mm_dog.s"
	.include	"text.s"
	.include	"sound.s"
	.include	"controller.s"
	.include	"init_game.s"
	.include	"game-code.s"
	.include	"random.s"
	
;txt_pushstarttoplay:
	; TRYCK PÅ START FÖR ATT SPELA...
;	.byte	$14, $12, $19, $03, $0b, $00, $10, $1d, $00, $13, $14, $01, $12, $14, $00, $06
;	.byte	$1c, $12, $00, $01, $14, $14, $00, $13, $10, $05, $0c, $01, $1e, $1e, $1e
