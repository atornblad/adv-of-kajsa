	.segment	"CODE"
	
	JOYPAD1 = $4016
	JOYPAD2 = $4017
	
	; https://wiki.nesdev.com/w/index.php/Controller_Reading
read_controller:
	; At the same time that we strobe bit 0, we initialize the ring counter
	; so we're hitting two birds with one stone here
	lda	#$01
	; While the strobe bit is set, buttons will be continuously reloaded.
	; This means that reading from JOYPAD1 will only return the state of the
	; first button: button A.
	sta	JOYPAD1
	sta	controller1
	lsr	a        ; now A is 0
	; By storing 0 into JOYPAD1, the strobe bit is cleared and the reloading stops.
	; This allows all 8 buttons (newly reloaded) to be read from JOYPAD1.
	sta	JOYPAD1
@loop:
	lda	JOYPAD1
	lsr	a	       ; bit0 -> Carry
	rol	controller1  ; Carry -> bit0; bit 7 -> Carry
	bcc	@loop
	rts
