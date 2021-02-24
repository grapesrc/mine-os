TOOLPATH = ../z_tools/
MAKE     = $(TOOLPATH)make.exe -r
NASM    = $(TOOLPATH)nasm.exe
EDIMG    = $(TOOLPATH)edimg.exe
IMGTOL   = $(TOOLPATH)imgtol.com
COPY     = copy
DEL      = del

# �f�t�H���g����

default :
	$(MAKE) img

# �t�@�C�������K��

ipl : ipl.asm Makefile
	$(NASM) ipl.asm

boot : boot.asm Makefile
	$(NASM) boot.asm
main: main.asm Makefile
	$(NASM) main.asm

boot.img : ipl boot main  Makefile
	$(EDIMG)   imgin:../z_tools/fdimg0at.tek \
		wbinimg src:ipl len:512 from:0 to:0 \
		copy from:boot to:@: \
		copy from:main to:@: \
		imgout:boot.img

# �R�}���h

img :
	$(MAKE) boot.img

run :
	$(MAKE) img
	$(COPY) boot.img ..\z_tools\qemu\fdimage0.bin
	$(MAKE) -C ../z_tools/qemu

install :
	$(MAKE) img
	$(IMGTOL) w a: boot.img

src_only :
	$(MAKE) clean
	-$(DEL) boot.img
