	.segment	"CODE"

	; https://wiki.nesdev.com/w/index.php/APU_basics
init_apu:
        ; Init $4000-4013
        ldy	#$13
@loop:  lda	init_apu_regs,y
        sta	$4000,y
        dey
        bpl	@loop
 
        ; We have to skip over $4014 (OAMDMA)
        lda	#$0f
        sta	$4015
        lda	#$40
        sta	$4017
	
	lda	#0
	sta	musicdata
	sta	musicdata+1
	lda	#255
	sta	musicwaitcount
	sta	musicwaitsubcount
        rts

music_player:
	; Call this from every nmi
	.if (REGION = NTSC)
	lda	#110
	.else
	lda	#132
	.endif
	clc
	adc	musicwaitsubcount
	sta	musicwaitsubcount
	lda	#0
	adc	musicwaitcount
	sta	musicwaitcount
	beq	@play
	rts
	
@play:	lda	musicdata
	bne	@haveaddr
	lda	musicdata+1
	bne	@haveaddr
	rts
@haveaddr:
	; Status byte:
	; tttccccc
	; ^^^      How many 16th notes to skip AFTER this one
	;    ^^^^^ Which channels get new information
	;    Chanl
	;    43210
	; Special magic value : $ff (make sure this never occurs in music - in that case, use $df followed by $00 after the data stream)
	ldy	#0
	lda	(musicdata), y
	cmp	#$ff
	bne	@dont_stop_the_music
	; $ff found - jump or stop!
	iny
	lda	(musicdata), y
	beq	@stop_the_music		; $ff followed by $00 : stop!
	
	tax
	; This is a jump! X now holds the HIGH(!!!) byte of the new address
	iny
	lda	(musicdata), y		; And X holds the LOW byte
	
	sta	musicdata
	stx	musicdata+1
	jmp	@haveaddr
	
@stop_the_music:
	lda	#0
	sta	musicdata
	sta	musicdata+1
	lda	#$ff
	sta	musicwaitcount
	sta	musicwaitsubcount
	rts
	
@dont_stop_the_music:
	; Keep the number of 16ths to skip after
	and	#$e0
	rol	a
	rol	a
	rol	a
	rol	a
	eor	#$ff
	sta	musicwaitcount
	
	; Then check which channels are getting data
	lda	(musicdata), y
	sta	localtempvar1
	
	; Initialize y to walk along music data
	ldy	#1
	; Check channel 0 for data (four bytes)
	ror	localtempvar1
	bcc	@channel0done
	lda	(musicdata), y
	sta	$4000
	iny
	lda	(musicdata), y
	sta	$4001
	iny
	lda	(musicdata), y
	sta	$4002
	iny
	lda	(musicdata), y
	sta	$4003
	iny
@channel0done:


	; Check channel 1 for data (four bytes)
	ror	localtempvar1
	bcc	@channel1done
	lda	(musicdata), y
	sta	$4004
	iny
	lda	(musicdata), y
	sta	$4005
	iny
	lda	(musicdata), y
	sta	$4006
	iny
	lda	(musicdata), y
	sta	$4007
	iny
@channel1done:


	; Check channel 2 for data (three bytes)
	ror	localtempvar1
	bcc	@channel2done
	lda	(musicdata), y
	sta	$4008
	iny
	lda	(musicdata), y
	sta	$400a
	iny
	lda	(musicdata), y
	sta	$400b
	iny
@channel2done:


	; Check channel 3 for data (three bytes)
	ror	localtempvar1
	bcc	@channel3done
	lda	(musicdata), y
	sta	$400c
	iny
	lda	(musicdata), y
	sta	$400e
	iny
	lda	(musicdata), y
	sta	$400f
	iny
@channel3done:


	; Check channel 4 for data (four bytes)
	ror	localtempvar1
	bcc	@channel4done
	lda	(musicdata), y
	sta	$4010
	iny
	lda	(musicdata), y
	sta	$4011
	iny
	lda	(musicdata), y
	sta	$4012
	iny
	lda	(musicdata), y
	sta	$4013
	iny
@channel4done:
	
	; Add Y to musicdata 16 bit pointer!
	tya
	clc
	adc	musicdata
	sta	musicdata
	lda	#0
	adc	musicdata+1
	sta	musicdata+1
	rts

	.segment "RODATA"

init_apu_regs:
        .byte	$30,$08,$00,$00
        .byte	$30,$08,$00,$00
        .byte	$80,$00,$00,$00
        .byte	$30,$00,$00,$00
        .byte	$00,$00,$00,$00

