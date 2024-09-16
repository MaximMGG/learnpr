org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

;
;FAT12 header
;

jmp short start
nop

bdb_oem:                    db  "MSWIN4.1"  ; 8 bytes
bdb_bytes_per_sector:       dw  512
bdb_sectors_per_clusters:   db 1
bdb_reserved_sectors:       dw 1
bdb_fat_count:              db 2
bdb_dir_enteries_count:     dw 0E0h
bdb_total_secots:           dw 2880
bdb_media_descriptor_type:  db 0F0h
bdb_sector_per_fat:         dw 9
bdb_sectors_per_track:      dw 18
bdb_heads:                  dw 2
bdb_hidden_sector:          dd 0
bdb_large_sector_count:     dd 0

; extended boot record
ebr_drive_number:           db 0
                            db 0
ebr_signature:              db 29h
ebr_volume_id:              db 12h, 34h, 56h, 78h
ebr_volume_label:           db 'MY SYPER OS'
ebr_system_ed               db 'FAT12   '

start:
    jmp main


;Prints a string to the screen
;Params:
;   -ds:si points to string
;
puts:
    push si
    push ax
.loop:
    lodsb   ;loads next character in al
    or  al, al ;verify if next character is null?
    jz .done
    mov ah, 0x0e ;call bios interrupt
    mov bh, 0
    int 0x10

    jmp .loop
.done:
    pop ax
    pop si
    ret

main:

    ;setup data segments
    mov ax, 0
    mov ds, ax
    mov ax, ds

    mov ss, ax
    mov sp, 0x7C00


    ;read somithing from floppy disk
    ;BIOS should set DL to drive number
    mov [ebr_drive_number], dl

    mov ax, 1               ; LBA=1, second sector from disk
    mov cx, 1               ; 1 sector to read
    mov bx, 0x7E00          ; data should be after the bootloader
    call    disk_read

    ;print hello world message
    mov si, msg_hello
    call puts

    hlt

;
; Error handlers
;


floppy_error:
    mov     si, msg_read_failed
    call    puts
    jmp     wait_key_and_rebote
    hlt

wait_key_and_rebote:
    mov     ah, 0
    int     16h             ;wait for keypress
    jmp     0FFFFh:0        ;jump to beginning of BIOS, should reboot


.halt:
    cli                     ;desable interrupts, this way CPU can't get out of "halt" state
    jmp .halt


;
; Disk routines
;

;
; Converts an LBA address to a CHS address
; Parameters:
    ;  - ax: LBA address
;   Returns:
    ;       - cx [bits 0-5]: sector number
    ;       - cs [bits 6-15]: cylinder
    ;       - dh: head

lba_to_chs:


    push ax
    push dx

    xor dx, dx                          ;dx = 9
    div word [bdb_sectors_per_track]    ;ax = LBA / SectorsPerTrack
                                        ;dx = LBA % SextorsPerTrack
    inc dx                              ;dx = (LBA % SectorsPerTrack + 1) = sector
    mov cx, dx                          ;cx = sector

    xor dx, dx                          ;dx = 0
    div word [bdb_heads]                ;ax = (LBA / SectorsPerTrack) / Heads = cylinder
                                        ;dx = (LBA / SectorsPerTrack) % Heads = head
    mov dh, dl                          ;dh = head
    mov ch, al                          ;ch = cylinder (lower 8 bits)
    shl ah, 6
    or  cl, ah                          ;put upper 2 bits of cylinder in CL

    pop ax
    mov dl, al
    pop ax
    ret

; Reads sectors from a disk
; Parameters:
;  - ax: LBA address
;  - cl: number of secotrs to read (up to 128)
;  - dl: driver number
;  - es:bx: memory address where to strore read data

disk_read:

    push ax
    push bx
    push cx
    push dx
    push di


    ;push    cx              ;temporarily sav CL (number of secotrs to read)
    call    lba_to_chs      ;compute CHS
    pop     ax              ;AL = number of secotrs to read

    mov     ah, 02h
    mov     di, 3           ;retry count

.retry:
    pusha                   ;save all registers, we don't know what bios modifies
    stc                     ;set carry flag, some BIOS'es don't set it
    int     13h             ;carry flag cleared = success
    jnc     .done

    ;read failed
    popa
    call    disk_reset

    dec di
    test    di, di
    jnz     .retry

.fail:
    ; all attempts are exhausted
    

.done:
    popa

    pop di
    pop dx
    pop cx
    pop bx                  ;resetore registers modified
    pop ax
    ret


;
; Resets disk controller
; Paremters:
    ;   - dl: drive number

disk_reset:
    pusha
    mov     ah, 0
    stc
    int     13h
    jc      floppy_error
    popa
    ret

msg_hello:              db 'Hello world!', ENDL, 0
msg_read_failed:        db  'Read from disk failed!', ENDL, 0


times 510-($-$$) db 0
dw 0AA55h

