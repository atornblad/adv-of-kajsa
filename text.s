	.segment	"CODE"

printxy:
	stx	printxyaddr
	sty	printxyaddr+1
	ldy	#0
	
@loop:	lda	(printxyaddr), y		; high byte of screen address
	beq	@done
	bmi	@clear
	sta	$2006
	iny
	
	lda	(printxyaddr), y		; low byte of screen address
	sta	$2006
	iny
	
	lda	(printxyaddr), y		; byte count
	tax
	iny
@charloop:
	lda	(printxyaddr), y
	sta	$2007
	iny
	
	dex
	bne	@charloop			; inner loop until x is zero
	
	beq	@loop				; outer loop (this is a BRA because x is zero here)
	
@done:	rts

@clear:	and	#$7f
	sta	$2006
	iny
	lda	(printxyaddr), y
	sta	$2006
	iny
	lda	(printxyaddr), y
	iny
	tax
	lda	#0
@clearloop:
	sta	$2007
	dex
	bne	@clearloop
	beq	@loop