; https://wiki.nesdev.com/w/index.php/Random_number_generator
; 
; prng
; 
; Returns a random 8-bit number in A (0-255), clobbers X (0).
; 
; Requires a 2-byte value on the zero page called "seed".
; Initialize seed to any value except 0 before the first call to prng.
; (A seed value of 0 will cause prng to always return 0.)
; 
; This is a 16-bit Galois linear feedback shift register with polynomial $002D.
; The sequence of numbers it generates will repeat after 65535 calls.
; 
; Execution time is an average of 125 cycles (excluding jsr and rts)

;.zeropage
;seed: .res 2       ; initialize 16-bit seed to any value except 0

	.segment "CODE"
prng:
	ldx	#8		; iteration count (generates 8 bits)
	lda	randomseed+0
@loop:
	asl			; shift the register
	rol	randomseed+1
	bcc	@skipeor
	eor	#$2D   ; apply XOR feedback whenever a 1 bit is shifted out
@skipeor:
	dex
	bne	@loop
	sta	randomseed+0
	cmp	#0     ; reload flags
	rts

