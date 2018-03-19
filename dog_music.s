dog_appears_music:
	.if (REGION = NTSC)
	; G-3 6 A0 0      | G-4 6 A0 1      |                
	.byte	$23
	.byte	$16, $04, $1c, $41, $56, $04, $8e, $40
	; C-4 9 A0 0      | C-5 9 A0 1      |                
	.byte	$23
	.byte	$19, $04, $d5, $40, $59, $04, $69, $40
	; D-4 C A0 0      | D-5 C A0 1      |                
	.byte	$23
	.byte	$1c, $04, $bd, $40, $5c, $04, $5d, $40
	; G-4 V A0 0      | G-5 V A0 1      |                
	.byte	$03
	.byte	$0f, $04, $8e, $40, $4f, $04, $46, $40
	.byte	$ff, $00
	.else
	; G-3 6 A0 0      | G-4 6 A0 1      |                
	.byte	$23
	.byte	$16, $04, $08, $41, $56, $04, $84, $40
	; C-4 9 A0 0      | C-5 9 A0 1      |                
	.byte	$23
	.byte	$19, $04, $c6, $40, $59, $04, $62, $40
	; D-4 C A0 0      | D-5 C A0 1      |                
	.byte	$23
	.byte	$1c, $04, $b0, $40, $5c, $04, $57, $40
	; G-4 V A0 0      | G-5 V A0 1      |                
	.byte	$03
	.byte	$0f, $04, $84, $40, $4f, $04, $41, $40
	.byte	$ff, $00
	.endif
text1_appears_music:
	.if (REGION = NTSC)
	; G-2 6 A0 1      | G-3 6 A0 2      |                
	.byte	$23
	.byte	$56, $04, $39, $42, $96, $04, $1c, $41
	; C-3 9 A0 1      | C-4 9 A0 2      |                
	.byte	$23
	.byte	$59, $04, $aa, $41, $99, $04, $d5, $40
	; D-3 C A0 1      | D-4 C A0 2      |                
	.byte	$23
	.byte	$5c, $04, $7c, $41, $9c, $04, $bd, $40
	; G-3 V A0 1      | G-4 V A0 2      |                
	.byte	$03
	.byte	$4f, $04, $1c, $41, $8f, $04, $8e, $40
	.byte	$ff, $00
	.else
	; G-2 6 A0 1      | G-3 6 A0 2      |                
	.byte	$23
	.byte	$56, $04, $11, $42, $96, $04, $08, $41
	; C-3 9 A0 1      | C-4 9 A0 2      |                
	.byte	$23
	.byte	$59, $04, $8c, $41, $99, $04, $c6, $40
	; D-3 C A0 1      | D-4 C A0 2      |                
	.byte	$23
	.byte	$5c, $04, $61, $41, $9c, $04, $b0, $40
	; G-3 V A0 1      | G-4 V A0 2      |                
	.byte	$03
	.byte	$4f, $04, $08, $41, $8f, $04, $84, $40
	.byte	$ff, $00
	.endif
text2_appears_music:
	.if (REGION = NTSC)
	; G-1 6 A0 2      | G-2 6 A0 3      |                
	.byte	$23
	.byte	$96, $04, $74, $44, $d6, $04, $39, $42
	; C-2 9 A0 2      | C-3 9 A0 3      |                
	.byte	$23
	.byte	$99, $04, $55, $43, $d9, $04, $aa, $41
	; D-2 C A0 2      | D-3 C A0 3      |                
	.byte	$23
	.byte	$9c, $04, $f9, $42, $dc, $04, $7c, $41
	; G-2 V A0 2      | G-3 V A0 3      |                
	.byte	$03
	.byte	$8f, $04, $39, $42, $cf, $04, $1c, $41
	.byte	$ff, $00
	.else
	; G-1 6 A0 2      | G-2 6 A0 3      |                
	.byte	$23
	.byte	$96, $04, $23, $44, $d6, $04, $11, $42
	; C-2 9 A0 2      | C-3 9 A0 3      |                
	.byte	$23
	.byte	$99, $04, $19, $43, $d9, $04, $8c, $41
	; D-2 C A0 2      | D-3 C A0 3      |                
	.byte	$23
	.byte	$9c, $04, $c3, $42, $dc, $04, $61, $41
	; G-2 V A0 2      | G-3 V A0 3      |                
	.byte	$03
	.byte	$8f, $04, $11, $42, $cf, $04, $08, $41
	.byte	$ff, $00
	.endif
main_menu_music:
	.if (REGION = NTSC)
	; A-1 B 08 0      | A-2 V 16 2 1+False | A-2 - 08       
	.byte	$67
	.byte	$1b, $04, $f8, $4b, $8f, $91, $fb, $b9, $7f, $fd, $48
	; A-1 B 08 0      |                 | A-2 - 08       
	.byte	$25
	.byte	$1b, $04, $f8, $4b, $7f, $fd, $48
	; A-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $f8, $3b
	; G-1 B 08 0      | A-4 V 16 1 0+False | G-2 - 08       
	.byte	$27
	.byte	$1b, $04, $74, $4c, $4f, $81, $7e, $b8, $7f, $1c, $49
	; A-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $f8, $3b
	; A-1 B 08 0      |                 | A-2 - 08       
	.byte	$25
	.byte	$1b, $04, $f8, $4b, $7f, $fd, $48
	; G-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $74, $3c
	;                 | A-2 V 16 2 1+False |                
	.byte	$22
	.byte	$8f, $91, $fb, $b9
	; A-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $f8, $3b
	; G-1 B 08 0      | A-2 V 16 2 1+False | G-2 - 08       
	.byte	$67
	.byte	$1b, $04, $74, $4c, $8f, $91, $fb, $b9, $7f, $1c, $49
	;                 | A-4 V 16 1 0+False |                
	.byte	$22
	.byte	$4f, $81, $7e, $b8
	; G-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $74, $3c
	; E-1 B 08 0      |                 | E-2 - 08       
	.byte	$65
	.byte	$1b, $04, $4c, $4d, $7f, $52, $49
	;                 | A-2 V 16 2 1+False |                
	.byte	$22
	.byte	$8f, $91, $fb, $b9
	; E-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $4c, $3d
	; E-1 B 08 0      |                 | E-2 - 08       
	.byte	$65
	.byte	$1b, $04, $4c, $4d, $7f, $52, $49
	;                 | A-4 V 16 1 0+False |                
	.byte	$22
	.byte	$4f, $81, $7e, $b8
	; E-1 7 0C 0      |                 |                
	.byte	$21
	.byte	$17, $04, $4c, $6d
	; D-1 B 08 0      |                 | D-2 - 08       
	.byte	$65
	.byte	$1b, $04, $f2, $4d, $7f, $7c, $49
	; E-1 B 08 0      |                 | E-2 - 08       
	.byte	$25
	.byte	$1b, $04, $4c, $4d, $7f, $52, $49
	; D-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $f2, $3d
	;                 | A-2 V 16 2 1+False |                
	.byte	$22
	.byte	$8f, $91, $fb, $b9
	; E-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $4c, $3d
	; G-1 B 08 0      | A-4 V 16 1 0+False | G-2 - 08       
	.byte	$a7
	.byte	$1b, $04, $74, $4c, $4f, $81, $7e, $b8, $7f, $1c, $49
	; G-1 7 0C 0      |                 |                
	.byte	$21
	.byte	$17, $04, $74, $6c
	.else
	; A-1 B 08 0      | A-2 V 16 2 1+False | A-2 - 08       
	.byte	$67
	.byte	$1b, $04, $b0, $4b, $8f, $91, $d7, $b9, $7f, $eb, $48
	; A-1 B 08 0      |                 | A-2 - 08       
	.byte	$25
	.byte	$1b, $04, $b0, $4b, $7f, $eb, $48
	; A-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $b0, $3b
	; G-1 B 08 0      | A-4 V 16 1 0+False | G-2 - 08       
	.byte	$27
	.byte	$1b, $04, $23, $4c, $4f, $81, $75, $b8, $7f, $08, $49
	; A-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $b0, $3b
	; A-1 B 08 0      |                 | A-2 - 08       
	.byte	$25
	.byte	$1b, $04, $b0, $4b, $7f, $eb, $48
	; G-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $23, $3c
	;                 | A-2 V 16 2 1+False |                
	.byte	$22
	.byte	$8f, $91, $d7, $b9
	; A-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $b0, $3b
	; G-1 B 08 0      | A-2 V 16 2 1+False | G-2 - 08       
	.byte	$67
	.byte	$1b, $04, $23, $4c, $8f, $91, $d7, $b9, $7f, $08, $49
	;                 | A-4 V 16 1 0+False |                
	.byte	$22
	.byte	$4f, $81, $75, $b8
	; G-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $23, $3c
	; E-1 B 08 0      |                 | E-2 - 08       
	.byte	$65
	.byte	$1b, $04, $ec, $4c, $7f, $3a, $49
	;                 | A-2 V 16 2 1+False |                
	.byte	$22
	.byte	$8f, $91, $d7, $b9
	; E-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $ec, $3c
	; E-1 B 08 0      |                 | E-2 - 08       
	.byte	$65
	.byte	$1b, $04, $ec, $4c, $7f, $3a, $49
	;                 | A-4 V 16 1 0+False |                
	.byte	$22
	.byte	$4f, $81, $75, $b8
	; E-1 7 0C 0      |                 |                
	.byte	$21
	.byte	$17, $04, $ec, $6c
	; D-1 B 08 0      |                 | D-2 - 08       
	.byte	$65
	.byte	$1b, $04, $86, $4d, $7f, $61, $49
	; E-1 B 08 0      |                 | E-2 - 08       
	.byte	$25
	.byte	$1b, $04, $ec, $4c, $7f, $3a, $49
	; D-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $86, $3d
	;                 | A-2 V 16 2 1+False |                
	.byte	$22
	.byte	$8f, $91, $d7, $b9
	; E-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $ec, $3c
	; G-1 B 08 0      | A-4 V 16 1 0+False | G-2 - 08       
	.byte	$a7
	.byte	$1b, $04, $23, $4c, $4f, $81, $75, $b8, $7f, $08, $49
	; G-1 7 0C 0      |                 |                
	.byte	$21
	.byte	$17, $04, $23, $6c
	.endif
	.if (REGION = NTSC)
	; A-1 B 08 0      | A-2 V 16 2 1+False | A-2 - 08       
	.byte	$67
	.byte	$1b, $04, $f8, $4b, $8f, $91, $fb, $b9, $7f, $fd, $48
	; A-1 B 08 0      |                 | A-2 - 08       
	.byte	$25
	.byte	$1b, $04, $f8, $4b, $7f, $fd, $48
	; A-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $f8, $3b
	; G-1 B 08 0      | A-4 V 16 1 0+False | G-2 - 08       
	.byte	$27
	.byte	$1b, $04, $74, $4c, $4f, $81, $7e, $b8, $7f, $1c, $49
	; A-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $f8, $3b
	; A-1 B 08 0      |                 | A-2 - 08       
	.byte	$25
	.byte	$1b, $04, $f8, $4b, $7f, $fd, $48
	; G-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $74, $3c
	;                 | A-2 V 16 2 1+False |                
	.byte	$22
	.byte	$8f, $91, $fb, $b9
	; A-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $f8, $3b
	; G-1 B 08 0      | A-2 V 16 2 1+False | G-2 - 08       
	.byte	$67
	.byte	$1b, $04, $74, $4c, $8f, $91, $fb, $b9, $7f, $1c, $49
	;                 | A-4 V 16 1 0+False |                
	.byte	$22
	.byte	$4f, $81, $7e, $b8
	; G-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $74, $3c
	; E-1 B 08 0      |                 | E-2 - 08       
	.byte	$65
	.byte	$1b, $04, $4c, $4d, $7f, $52, $49
	;                 | A-2 V 16 2 1+False |                
	.byte	$22
	.byte	$8f, $91, $fb, $b9
	; E-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $4c, $3d
	; E-1 B 08 0      |                 | E-2 - 08       
	.byte	$65
	.byte	$1b, $04, $4c, $4d, $7f, $52, $49
	;                 | A-4 V 16 1 0+False |                
	.byte	$22
	.byte	$4f, $81, $7e, $b8
	; E-1 7 0C 0      |                 |                
	.byte	$21
	.byte	$17, $04, $4c, $6d
	; D-1 B 08 0      |                 | D-2 - 08       
	.byte	$65
	.byte	$1b, $04, $f2, $4d, $7f, $7c, $49
	; E-1 B 08 0      |                 | E-2 - 08       
	.byte	$25
	.byte	$1b, $04, $4c, $4d, $7f, $52, $49
	; D-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $f2, $3d
	;                 | A-2 V 16 2 1+False |                
	.byte	$22
	.byte	$8f, $91, $fb, $b9
	; E-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $4c, $3d
	;                 | A-4 V 16 1 0+False |                
	.byte	$62
	.byte	$4f, $81, $7e, $b8
	;                 | A-4 V 16 1 0+False |                
	.byte	$22
	.byte	$4f, $81, $7e, $b8
	;                 | A-4 V 16 1 0+False |                
	.byte	$22
	.byte	$4f, $81, $7e, $b8
	.byte	$ff, >main_menu_music, <main_menu_music
	.else
	; A-1 B 08 0      | A-2 V 16 2 1+False | A-2 - 08       
	.byte	$67
	.byte	$1b, $04, $b0, $4b, $8f, $91, $d7, $b9, $7f, $eb, $48
	; A-1 B 08 0      |                 | A-2 - 08       
	.byte	$25
	.byte	$1b, $04, $b0, $4b, $7f, $eb, $48
	; A-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $b0, $3b
	; G-1 B 08 0      | A-4 V 16 1 0+False | G-2 - 08       
	.byte	$27
	.byte	$1b, $04, $23, $4c, $4f, $81, $75, $b8, $7f, $08, $49
	; A-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $b0, $3b
	; A-1 B 08 0      |                 | A-2 - 08       
	.byte	$25
	.byte	$1b, $04, $b0, $4b, $7f, $eb, $48
	; G-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $23, $3c
	;                 | A-2 V 16 2 1+False |                
	.byte	$22
	.byte	$8f, $91, $d7, $b9
	; A-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $b0, $3b
	; G-1 B 08 0      | A-2 V 16 2 1+False | G-2 - 08       
	.byte	$67
	.byte	$1b, $04, $23, $4c, $8f, $91, $d7, $b9, $7f, $08, $49
	;                 | A-4 V 16 1 0+False |                
	.byte	$22
	.byte	$4f, $81, $75, $b8
	; G-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $23, $3c
	; E-1 B 08 0      |                 | E-2 - 08       
	.byte	$65
	.byte	$1b, $04, $ec, $4c, $7f, $3a, $49
	;                 | A-2 V 16 2 1+False |                
	.byte	$22
	.byte	$8f, $91, $d7, $b9
	; E-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $ec, $3c
	; E-1 B 08 0      |                 | E-2 - 08       
	.byte	$65
	.byte	$1b, $04, $ec, $4c, $7f, $3a, $49
	;                 | A-4 V 16 1 0+False |                
	.byte	$22
	.byte	$4f, $81, $75, $b8
	; E-1 7 0C 0      |                 |                
	.byte	$21
	.byte	$17, $04, $ec, $6c
	; D-1 B 08 0      |                 | D-2 - 08       
	.byte	$65
	.byte	$1b, $04, $86, $4d, $7f, $61, $49
	; E-1 B 08 0      |                 | E-2 - 08       
	.byte	$25
	.byte	$1b, $04, $ec, $4c, $7f, $3a, $49
	; D-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $86, $3d
	;                 | A-2 V 16 2 1+False |                
	.byte	$22
	.byte	$8f, $91, $d7, $b9
	; E-1 7 06 0      |                 |                
	.byte	$21
	.byte	$17, $04, $ec, $3c
	;                 | A-4 V 16 1 0+False |                
	.byte	$62
	.byte	$4f, $81, $75, $b8
	;                 | A-4 V 16 1 0+False |                
	.byte	$22
	.byte	$4f, $81, $75, $b8
	;                 | A-4 V 16 1 0+False |                
	.byte	$22
	.byte	$4f, $81, $75, $b8
	.byte	$ff, >main_menu_music, <main_menu_music
	.endif
main_menu_startbutton_music:
	; Silence everything first
	.byte	$1f
	.byte	$30,$08,$00,$00,$30,$08,$00,$00,$80,$00,$00,$30,$00,$00,$00,$00,$00,$00
	.if (REGION = NTSC)
	; C-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $d5, $38
	; G-3 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $1c, $39
	; C-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $d5, $38
	; E-3 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $52, $39
	; C-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $d5, $38
	; G-3 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $1c, $39
	; C-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $d5, $38
	; E-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $a9, $38
	; G-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $8e, $38
	; E-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $a9, $38
	; G-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $8e, $38
	; C-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $69, $38
	; G-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $8e, $38
	; E-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $a9, $38
	; G-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $8e, $38
	; C-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $69, $38
	; E-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $54, $38
	; C-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $69, $38
	; E-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $54, $38
	; G-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $46, $38
	; E-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $54, $38
	; C-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $69, $38
	; E-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $54, $38
	; G-5 F 04 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $46, $28
	.byte	$ff, $00
	.else
	; C-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $c6, $38
	; G-3 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $08, $39
	; C-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $c6, $38
	; E-3 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $3a, $39
	; C-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $c6, $38
	; G-3 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $08, $39
	; C-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $c6, $38
	; E-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $9d, $38
	; G-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $84, $38
	; E-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $9d, $38
	; G-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $84, $38
	; C-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $62, $38
	; G-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $84, $38
	; E-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $9d, $38
	; G-4 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $84, $38
	; C-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $62, $38
	; E-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $4e, $38
	; C-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $62, $38
	; E-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $4e, $38
	; G-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $41, $38
	; E-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $4e, $38
	; C-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $62, $38
	; E-5 F 06 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $4e, $38
	; G-5 F 04 0      |                 |                
	.byte	$01
	.byte	$1f, $04, $41, $28
	.byte	$ff, $00
	.endif
