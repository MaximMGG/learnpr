
./a.out:     file format elf64-x86-64


Disassembly of section .init:

0000000000401000 <_init>:
  401000:	f3 0f 1e fa          	endbr64
  401004:	48 83 ec 08          	sub    $0x8,%rsp
  401008:	48 8b 05 d1 2f 00 00 	mov    0x2fd1(%rip),%rax        # 403fe0 <__gmon_start__@Base>
  40100f:	48 85 c0             	test   %rax,%rax
  401012:	74 02                	je     401016 <_init+0x16>
  401014:	ff d0                	call   *%rax
  401016:	48 83 c4 08          	add    $0x8,%rsp
  40101a:	c3                   	ret

Disassembly of section .plt:

0000000000401020 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@plt-0x10>:
  401020:	ff 35 ca 2f 00 00    	push   0x2fca(%rip)        # 403ff0 <_GLOBAL_OFFSET_TABLE_+0x8>
  401026:	ff 25 cc 2f 00 00    	jmp    *0x2fcc(%rip)        # 403ff8 <_GLOBAL_OFFSET_TABLE_+0x10>
  40102c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401030 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@plt>:
  401030:	ff 25 ca 2f 00 00    	jmp    *0x2fca(%rip)        # 404000 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@GLIBCXX_3.4>
  401036:	68 00 00 00 00       	push   $0x0
  40103b:	e9 e0 ff ff ff       	jmp    401020 <_init+0x20>

0000000000401040 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c@plt>:
  401040:	ff 25 c2 2f 00 00    	jmp    *0x2fc2(%rip)        # 404008 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c@GLIBCXX_3.4>
  401046:	68 01 00 00 00       	push   $0x1
  40104b:	e9 d0 ff ff ff       	jmp    401020 <_init+0x20>

0000000000401050 <_ZNSolsEi@plt>:
  401050:	ff 25 ba 2f 00 00    	jmp    *0x2fba(%rip)        # 404010 <_ZNSolsEi@GLIBCXX_3.4>
  401056:	68 02 00 00 00       	push   $0x2
  40105b:	e9 c0 ff ff ff       	jmp    401020 <_init+0x20>

Disassembly of section .text:

0000000000401060 <_start>:
  401060:	f3 0f 1e fa          	endbr64
  401064:	31 ed                	xor    %ebp,%ebp
  401066:	49 89 d1             	mov    %rdx,%r9
  401069:	5e                   	pop    %rsi
  40106a:	48 89 e2             	mov    %rsp,%rdx
  40106d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  401071:	50                   	push   %rax
  401072:	54                   	push   %rsp
  401073:	45 31 c0             	xor    %r8d,%r8d
  401076:	31 c9                	xor    %ecx,%ecx
  401078:	48 c7 c7 46 11 40 00 	mov    $0x401146,%rdi
  40107f:	ff 15 53 2f 00 00    	call   *0x2f53(%rip)        # 403fd8 <__libc_start_main@GLIBC_2.34>
  401085:	f4                   	hlt
  401086:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40108d:	00 00 00 

0000000000401090 <_dl_relocate_static_pie>:
  401090:	f3 0f 1e fa          	endbr64
  401094:	c3                   	ret
  401095:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40109c:	00 00 00 
  40109f:	90                   	nop

00000000004010a0 <deregister_tm_clones>:
  4010a0:	b8 20 40 40 00       	mov    $0x404020,%eax
  4010a5:	48 3d 20 40 40 00    	cmp    $0x404020,%rax
  4010ab:	74 13                	je     4010c0 <deregister_tm_clones+0x20>
  4010ad:	b8 00 00 00 00       	mov    $0x0,%eax
  4010b2:	48 85 c0             	test   %rax,%rax
  4010b5:	74 09                	je     4010c0 <deregister_tm_clones+0x20>
  4010b7:	bf 20 40 40 00       	mov    $0x404020,%edi
  4010bc:	ff e0                	jmp    *%rax
  4010be:	66 90                	xchg   %ax,%ax
  4010c0:	c3                   	ret
  4010c1:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4010c8:	00 00 00 00 
  4010cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004010d0 <register_tm_clones>:
  4010d0:	be 20 40 40 00       	mov    $0x404020,%esi
  4010d5:	48 81 ee 20 40 40 00 	sub    $0x404020,%rsi
  4010dc:	48 89 f0             	mov    %rsi,%rax
  4010df:	48 c1 ee 3f          	shr    $0x3f,%rsi
  4010e3:	48 c1 f8 03          	sar    $0x3,%rax
  4010e7:	48 01 c6             	add    %rax,%rsi
  4010ea:	48 d1 fe             	sar    %rsi
  4010ed:	74 11                	je     401100 <register_tm_clones+0x30>
  4010ef:	b8 00 00 00 00       	mov    $0x0,%eax
  4010f4:	48 85 c0             	test   %rax,%rax
  4010f7:	74 07                	je     401100 <register_tm_clones+0x30>
  4010f9:	bf 20 40 40 00       	mov    $0x404020,%edi
  4010fe:	ff e0                	jmp    *%rax
  401100:	c3                   	ret
  401101:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  401108:	00 00 00 00 
  40110c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401110 <__do_global_dtors_aux>:
  401110:	f3 0f 1e fa          	endbr64
  401114:	80 3d 35 30 00 00 00 	cmpb   $0x0,0x3035(%rip)        # 404150 <completed.0>
  40111b:	75 13                	jne    401130 <__do_global_dtors_aux+0x20>
  40111d:	55                   	push   %rbp
  40111e:	48 89 e5             	mov    %rsp,%rbp
  401121:	e8 7a ff ff ff       	call   4010a0 <deregister_tm_clones>
  401126:	c6 05 23 30 00 00 01 	movb   $0x1,0x3023(%rip)        # 404150 <completed.0>
  40112d:	5d                   	pop    %rbp
  40112e:	c3                   	ret
  40112f:	90                   	nop
  401130:	c3                   	ret
  401131:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  401138:	00 00 00 00 
  40113c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401140 <frame_dummy>:
  401140:	f3 0f 1e fa          	endbr64
  401144:	eb 8a                	jmp    4010d0 <register_tm_clones>

0000000000401146 <main>:
  401146:	55                   	push   %rbp
  401147:	48 89 e5             	mov    %rsp,%rbp
  40114a:	53                   	push   %rbx
  40114b:	48 83 ec 18          	sub    $0x18,%rsp
  40114f:	c7 45 ec 5d 41 03 00 	movl   $0x3415d,-0x14(%rbp)
  401156:	c7 45 e8 0a 0a 0c 02 	movl   $0x20c0a0a,-0x18(%rbp)
  40115d:	be 10 20 40 00       	mov    $0x402010,%esi
  401162:	bf 40 40 40 00       	mov    $0x404040,%edi
  401167:	e8 c4 fe ff ff       	call   401030 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@plt>
  40116c:	48 89 c3             	mov    %rax,%rbx
  40116f:	be 0a 0a 0c 02       	mov    $0x20c0a0a,%esi
  401174:	bf 5d 41 03 00       	mov    $0x3415d,%edi
  401179:	e8 22 00 00 00       	call   4011a0 <_Z3fooii>
  40117e:	89 c6                	mov    %eax,%esi
  401180:	48 89 df             	mov    %rbx,%rdi
  401183:	e8 c8 fe ff ff       	call   401050 <_ZNSolsEi@plt>
  401188:	be 0a 00 00 00       	mov    $0xa,%esi
  40118d:	48 89 c7             	mov    %rax,%rdi
  401190:	e8 ab fe ff ff       	call   401040 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c@plt>
  401195:	b8 00 00 00 00       	mov    $0x0,%eax
  40119a:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  40119e:	c9                   	leave
  40119f:	c3                   	ret

00000000004011a0 <_Z3fooii>:
  4011a0:	55                   	push   %rbp
  4011a1:	48 89 e5             	mov    %rsp,%rbp
  4011a4:	89 7d fc             	mov    %edi,-0x4(%rbp)
  4011a7:	89 75 f8             	mov    %esi,-0x8(%rbp)
  4011aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  4011ad:	0f af 45 f8          	imul   -0x8(%rbp),%eax
  4011b1:	89 c2                	mov    %eax,%edx
  4011b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  4011b6:	01 d0                	add    %edx,%eax
  4011b8:	2b 45 f8             	sub    -0x8(%rbp),%eax
  4011bb:	89 c1                	mov    %eax,%ecx
  4011bd:	8b 45 f8             	mov    -0x8(%rbp),%eax
  4011c0:	99                   	cltd
  4011c1:	f7 7d fc             	idivl  -0x4(%rbp)
  4011c4:	01 c8                	add    %ecx,%eax
  4011c6:	5d                   	pop    %rbp
  4011c7:	c3                   	ret

Disassembly of section .fini:

00000000004011c8 <_fini>:
  4011c8:	f3 0f 1e fa          	endbr64
  4011cc:	48 83 ec 08          	sub    $0x8,%rsp
  4011d0:	48 83 c4 08          	add    $0x8,%rsp
  4011d4:	c3                   	ret
