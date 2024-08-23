
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find>:
	#include "kernel/types.h"
	#include "kernel/stat.h"
	#include "user/user.h"
	#include "kernel/fs.h"
	
	void find(const char *path, const char *target) {
   0:	d8010113          	addi	sp,sp,-640
   4:	26113c23          	sd	ra,632(sp)
   8:	26813823          	sd	s0,624(sp)
   c:	26913423          	sd	s1,616(sp)
  10:	27213023          	sd	s2,608(sp)
  14:	25313c23          	sd	s3,600(sp)
  18:	25413823          	sd	s4,592(sp)
  1c:	25513423          	sd	s5,584(sp)
  20:	25613023          	sd	s6,576(sp)
  24:	23713c23          	sd	s7,568(sp)
  28:	0500                	addi	s0,sp,640
  2a:	892a                	mv	s2,a0
  2c:	89ae                	mv	s3,a1
		char buf[512], *p;
		int fd;
		struct dirent de;
		struct stat st;
		
		if ((fd = open(path, 0)) < 0) {
  2e:	4581                	li	a1,0
  30:	00000097          	auipc	ra,0x0
  34:	4bc080e7          	jalr	1212(ra) # 4ec <open>
  38:	04054a63          	bltz	a0,8c <find+0x8c>
  3c:	84aa                	mv	s1,a0
			printf("find: cannot open %s\n", path);
			return;
		}
		
		if (fstat(fd, &st) < 0) {
  3e:	d8840593          	addi	a1,s0,-632
  42:	00000097          	auipc	ra,0x0
  46:	4c2080e7          	jalr	1218(ra) # 504 <fstat>
  4a:	04054b63          	bltz	a0,a0 <find+0xa0>
			printf("find: cannot stat %s\n", path);
			close(fd);
			return;
		}
		
		if (st.type != T_DIR) {
  4e:	d9041703          	lh	a4,-624(s0)
  52:	4785                	li	a5,1
  54:	06f70563          	beq	a4,a5,be <find+0xbe>
			close(fd);
  58:	8526                	mv	a0,s1
  5a:	00000097          	auipc	ra,0x0
  5e:	47a080e7          	jalr	1146(ra) # 4d4 <close>
			if (st.type == T_DIR) {
				find(buf, target);
			}
		}
		close(fd);
	}
  62:	27813083          	ld	ra,632(sp)
  66:	27013403          	ld	s0,624(sp)
  6a:	26813483          	ld	s1,616(sp)
  6e:	26013903          	ld	s2,608(sp)
  72:	25813983          	ld	s3,600(sp)
  76:	25013a03          	ld	s4,592(sp)
  7a:	24813a83          	ld	s5,584(sp)
  7e:	24013b03          	ld	s6,576(sp)
  82:	23813b83          	ld	s7,568(sp)
  86:	28010113          	addi	sp,sp,640
  8a:	8082                	ret
			printf("find: cannot open %s\n", path);
  8c:	85ca                	mv	a1,s2
  8e:	00001517          	auipc	a0,0x1
  92:	93a50513          	addi	a0,a0,-1734 # 9c8 <malloc+0xe6>
  96:	00000097          	auipc	ra,0x0
  9a:	78e080e7          	jalr	1934(ra) # 824 <printf>
			return;
  9e:	b7d1                	j	62 <find+0x62>
			printf("find: cannot stat %s\n", path);
  a0:	85ca                	mv	a1,s2
  a2:	00001517          	auipc	a0,0x1
  a6:	93e50513          	addi	a0,a0,-1730 # 9e0 <malloc+0xfe>
  aa:	00000097          	auipc	ra,0x0
  ae:	77a080e7          	jalr	1914(ra) # 824 <printf>
			close(fd);
  b2:	8526                	mv	a0,s1
  b4:	00000097          	auipc	ra,0x0
  b8:	420080e7          	jalr	1056(ra) # 4d4 <close>
			return;
  bc:	b75d                	j	62 <find+0x62>
		if (strlen(path) + 1 + DIRSIZ + 1 > sizeof(buf)) {
  be:	854a                	mv	a0,s2
  c0:	00000097          	auipc	ra,0x0
  c4:	1be080e7          	jalr	446(ra) # 27e <strlen>
  c8:	2541                	addiw	a0,a0,16
  ca:	20000793          	li	a5,512
  ce:	0ca7ea63          	bltu	a5,a0,1a2 <find+0x1a2>
		strcpy(buf, path);
  d2:	85ca                	mv	a1,s2
  d4:	db040513          	addi	a0,s0,-592
  d8:	00000097          	auipc	ra,0x0
  dc:	15e080e7          	jalr	350(ra) # 236 <strcpy>
		p = buf + strlen(buf);
  e0:	db040513          	addi	a0,s0,-592
  e4:	00000097          	auipc	ra,0x0
  e8:	19a080e7          	jalr	410(ra) # 27e <strlen>
  ec:	02051913          	slli	s2,a0,0x20
  f0:	02095913          	srli	s2,s2,0x20
  f4:	db040793          	addi	a5,s0,-592
  f8:	993e                	add	s2,s2,a5
		*p++ = '/';
  fa:	00190b13          	addi	s6,s2,1
  fe:	02f00793          	li	a5,47
 102:	00f90023          	sb	a5,0(s2)
			if (strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
 106:	00001a97          	auipc	s5,0x1
 10a:	90aa8a93          	addi	s5,s5,-1782 # a10 <malloc+0x12e>
 10e:	00001b97          	auipc	s7,0x1
 112:	90ab8b93          	addi	s7,s7,-1782 # a18 <malloc+0x136>
			memmove(p, de.name, DIRSIZ);
 116:	da240a13          	addi	s4,s0,-606
		while (read(fd, &de, sizeof(de)) == sizeof(de)) {
 11a:	4641                	li	a2,16
 11c:	da040593          	addi	a1,s0,-608
 120:	8526                	mv	a0,s1
 122:	00000097          	auipc	ra,0x0
 126:	3a2080e7          	jalr	930(ra) # 4c4 <read>
 12a:	47c1                	li	a5,16
 12c:	0af51f63          	bne	a0,a5,1ea <find+0x1ea>
			if (de.inum == 0)
 130:	da045783          	lhu	a5,-608(s0)
 134:	d3fd                	beqz	a5,11a <find+0x11a>
			memmove(p, de.name, DIRSIZ);
 136:	4639                	li	a2,14
 138:	85d2                	mv	a1,s4
 13a:	855a                	mv	a0,s6
 13c:	00000097          	auipc	ra,0x0
 140:	2ba080e7          	jalr	698(ra) # 3f6 <memmove>
			p[DIRSIZ] = 0;
 144:	000907a3          	sb	zero,15(s2)
			if (strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
 148:	85d6                	mv	a1,s5
 14a:	8552                	mv	a0,s4
 14c:	00000097          	auipc	ra,0x0
 150:	106080e7          	jalr	262(ra) # 252 <strcmp>
 154:	d179                	beqz	a0,11a <find+0x11a>
 156:	85de                	mv	a1,s7
 158:	8552                	mv	a0,s4
 15a:	00000097          	auipc	ra,0x0
 15e:	0f8080e7          	jalr	248(ra) # 252 <strcmp>
 162:	dd45                	beqz	a0,11a <find+0x11a>
			if (stat(buf, &st) < 0) {
 164:	d8840593          	addi	a1,s0,-632
 168:	db040513          	addi	a0,s0,-592
 16c:	00000097          	auipc	ra,0x0
 170:	1fa080e7          	jalr	506(ra) # 366 <stat>
 174:	04054563          	bltz	a0,1be <find+0x1be>
			if (strcmp(de.name, target) == 0) {
 178:	85ce                	mv	a1,s3
 17a:	da240513          	addi	a0,s0,-606
 17e:	00000097          	auipc	ra,0x0
 182:	0d4080e7          	jalr	212(ra) # 252 <strcmp>
 186:	c539                	beqz	a0,1d4 <find+0x1d4>
			if (st.type == T_DIR) {
 188:	d9041703          	lh	a4,-624(s0)
 18c:	4785                	li	a5,1
 18e:	f8f716e3          	bne	a4,a5,11a <find+0x11a>
				find(buf, target);
 192:	85ce                	mv	a1,s3
 194:	db040513          	addi	a0,s0,-592
 198:	00000097          	auipc	ra,0x0
 19c:	e68080e7          	jalr	-408(ra) # 0 <find>
 1a0:	bfad                	j	11a <find+0x11a>
			printf("find: path too long\n");
 1a2:	00001517          	auipc	a0,0x1
 1a6:	85650513          	addi	a0,a0,-1962 # 9f8 <malloc+0x116>
 1aa:	00000097          	auipc	ra,0x0
 1ae:	67a080e7          	jalr	1658(ra) # 824 <printf>
			close(fd);
 1b2:	8526                	mv	a0,s1
 1b4:	00000097          	auipc	ra,0x0
 1b8:	320080e7          	jalr	800(ra) # 4d4 <close>
			return;
 1bc:	b55d                	j	62 <find+0x62>
				printf("find: cannot stat %s\n", buf);
 1be:	db040593          	addi	a1,s0,-592
 1c2:	00001517          	auipc	a0,0x1
 1c6:	81e50513          	addi	a0,a0,-2018 # 9e0 <malloc+0xfe>
 1ca:	00000097          	auipc	ra,0x0
 1ce:	65a080e7          	jalr	1626(ra) # 824 <printf>
				continue;
 1d2:	b7a1                	j	11a <find+0x11a>
				printf("%s\n", buf);
 1d4:	db040593          	addi	a1,s0,-592
 1d8:	00001517          	auipc	a0,0x1
 1dc:	84850513          	addi	a0,a0,-1976 # a20 <malloc+0x13e>
 1e0:	00000097          	auipc	ra,0x0
 1e4:	644080e7          	jalr	1604(ra) # 824 <printf>
 1e8:	b745                	j	188 <find+0x188>
		close(fd);
 1ea:	8526                	mv	a0,s1
 1ec:	00000097          	auipc	ra,0x0
 1f0:	2e8080e7          	jalr	744(ra) # 4d4 <close>
 1f4:	b5bd                	j	62 <find+0x62>

00000000000001f6 <main>:
	
	int main(int argc, char *argv[]) {
 1f6:	1141                	addi	sp,sp,-16
 1f8:	e406                	sd	ra,8(sp)
 1fa:	e022                	sd	s0,0(sp)
 1fc:	0800                	addi	s0,sp,16
		if (argc < 3) {
 1fe:	4709                	li	a4,2
 200:	00a74f63          	blt	a4,a0,21e <main+0x28>
			printf("Usage: find <path> <name>\n");
 204:	00001517          	auipc	a0,0x1
 208:	82450513          	addi	a0,a0,-2012 # a28 <malloc+0x146>
 20c:	00000097          	auipc	ra,0x0
 210:	618080e7          	jalr	1560(ra) # 824 <printf>
			exit(1);
 214:	4505                	li	a0,1
 216:	00000097          	auipc	ra,0x0
 21a:	296080e7          	jalr	662(ra) # 4ac <exit>
 21e:	87ae                	mv	a5,a1
		}
		find(argv[1], argv[2]);
 220:	698c                	ld	a1,16(a1)
 222:	6788                	ld	a0,8(a5)
 224:	00000097          	auipc	ra,0x0
 228:	ddc080e7          	jalr	-548(ra) # 0 <find>
		exit(0);
 22c:	4501                	li	a0,0
 22e:	00000097          	auipc	ra,0x0
 232:	27e080e7          	jalr	638(ra) # 4ac <exit>

0000000000000236 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 236:	1141                	addi	sp,sp,-16
 238:	e422                	sd	s0,8(sp)
 23a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 23c:	87aa                	mv	a5,a0
 23e:	0585                	addi	a1,a1,1
 240:	0785                	addi	a5,a5,1
 242:	fff5c703          	lbu	a4,-1(a1)
 246:	fee78fa3          	sb	a4,-1(a5)
 24a:	fb75                	bnez	a4,23e <strcpy+0x8>
    ;
  return os;
}
 24c:	6422                	ld	s0,8(sp)
 24e:	0141                	addi	sp,sp,16
 250:	8082                	ret

0000000000000252 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 252:	1141                	addi	sp,sp,-16
 254:	e422                	sd	s0,8(sp)
 256:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 258:	00054783          	lbu	a5,0(a0)
 25c:	cb91                	beqz	a5,270 <strcmp+0x1e>
 25e:	0005c703          	lbu	a4,0(a1)
 262:	00f71763          	bne	a4,a5,270 <strcmp+0x1e>
    p++, q++;
 266:	0505                	addi	a0,a0,1
 268:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 26a:	00054783          	lbu	a5,0(a0)
 26e:	fbe5                	bnez	a5,25e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 270:	0005c503          	lbu	a0,0(a1)
}
 274:	40a7853b          	subw	a0,a5,a0
 278:	6422                	ld	s0,8(sp)
 27a:	0141                	addi	sp,sp,16
 27c:	8082                	ret

000000000000027e <strlen>:

uint
strlen(const char *s)
{
 27e:	1141                	addi	sp,sp,-16
 280:	e422                	sd	s0,8(sp)
 282:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 284:	00054783          	lbu	a5,0(a0)
 288:	cf91                	beqz	a5,2a4 <strlen+0x26>
 28a:	0505                	addi	a0,a0,1
 28c:	87aa                	mv	a5,a0
 28e:	4685                	li	a3,1
 290:	9e89                	subw	a3,a3,a0
 292:	00f6853b          	addw	a0,a3,a5
 296:	0785                	addi	a5,a5,1
 298:	fff7c703          	lbu	a4,-1(a5)
 29c:	fb7d                	bnez	a4,292 <strlen+0x14>
    ;
  return n;
}
 29e:	6422                	ld	s0,8(sp)
 2a0:	0141                	addi	sp,sp,16
 2a2:	8082                	ret
  for(n = 0; s[n]; n++)
 2a4:	4501                	li	a0,0
 2a6:	bfe5                	j	29e <strlen+0x20>

00000000000002a8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2a8:	1141                	addi	sp,sp,-16
 2aa:	e422                	sd	s0,8(sp)
 2ac:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2ae:	ce09                	beqz	a2,2c8 <memset+0x20>
 2b0:	87aa                	mv	a5,a0
 2b2:	fff6071b          	addiw	a4,a2,-1
 2b6:	1702                	slli	a4,a4,0x20
 2b8:	9301                	srli	a4,a4,0x20
 2ba:	0705                	addi	a4,a4,1
 2bc:	972a                	add	a4,a4,a0
    cdst[i] = c;
 2be:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2c2:	0785                	addi	a5,a5,1
 2c4:	fee79de3          	bne	a5,a4,2be <memset+0x16>
  }
  return dst;
}
 2c8:	6422                	ld	s0,8(sp)
 2ca:	0141                	addi	sp,sp,16
 2cc:	8082                	ret

00000000000002ce <strchr>:

char*
strchr(const char *s, char c)
{
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e422                	sd	s0,8(sp)
 2d2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2d4:	00054783          	lbu	a5,0(a0)
 2d8:	cb99                	beqz	a5,2ee <strchr+0x20>
    if(*s == c)
 2da:	00f58763          	beq	a1,a5,2e8 <strchr+0x1a>
  for(; *s; s++)
 2de:	0505                	addi	a0,a0,1
 2e0:	00054783          	lbu	a5,0(a0)
 2e4:	fbfd                	bnez	a5,2da <strchr+0xc>
      return (char*)s;
  return 0;
 2e6:	4501                	li	a0,0
}
 2e8:	6422                	ld	s0,8(sp)
 2ea:	0141                	addi	sp,sp,16
 2ec:	8082                	ret
  return 0;
 2ee:	4501                	li	a0,0
 2f0:	bfe5                	j	2e8 <strchr+0x1a>

00000000000002f2 <gets>:

char*
gets(char *buf, int max)
{
 2f2:	711d                	addi	sp,sp,-96
 2f4:	ec86                	sd	ra,88(sp)
 2f6:	e8a2                	sd	s0,80(sp)
 2f8:	e4a6                	sd	s1,72(sp)
 2fa:	e0ca                	sd	s2,64(sp)
 2fc:	fc4e                	sd	s3,56(sp)
 2fe:	f852                	sd	s4,48(sp)
 300:	f456                	sd	s5,40(sp)
 302:	f05a                	sd	s6,32(sp)
 304:	ec5e                	sd	s7,24(sp)
 306:	1080                	addi	s0,sp,96
 308:	8baa                	mv	s7,a0
 30a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 30c:	892a                	mv	s2,a0
 30e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 310:	4aa9                	li	s5,10
 312:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 314:	89a6                	mv	s3,s1
 316:	2485                	addiw	s1,s1,1
 318:	0344d863          	bge	s1,s4,348 <gets+0x56>
    cc = read(0, &c, 1);
 31c:	4605                	li	a2,1
 31e:	faf40593          	addi	a1,s0,-81
 322:	4501                	li	a0,0
 324:	00000097          	auipc	ra,0x0
 328:	1a0080e7          	jalr	416(ra) # 4c4 <read>
    if(cc < 1)
 32c:	00a05e63          	blez	a0,348 <gets+0x56>
    buf[i++] = c;
 330:	faf44783          	lbu	a5,-81(s0)
 334:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 338:	01578763          	beq	a5,s5,346 <gets+0x54>
 33c:	0905                	addi	s2,s2,1
 33e:	fd679be3          	bne	a5,s6,314 <gets+0x22>
  for(i=0; i+1 < max; ){
 342:	89a6                	mv	s3,s1
 344:	a011                	j	348 <gets+0x56>
 346:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 348:	99de                	add	s3,s3,s7
 34a:	00098023          	sb	zero,0(s3)
  return buf;
}
 34e:	855e                	mv	a0,s7
 350:	60e6                	ld	ra,88(sp)
 352:	6446                	ld	s0,80(sp)
 354:	64a6                	ld	s1,72(sp)
 356:	6906                	ld	s2,64(sp)
 358:	79e2                	ld	s3,56(sp)
 35a:	7a42                	ld	s4,48(sp)
 35c:	7aa2                	ld	s5,40(sp)
 35e:	7b02                	ld	s6,32(sp)
 360:	6be2                	ld	s7,24(sp)
 362:	6125                	addi	sp,sp,96
 364:	8082                	ret

0000000000000366 <stat>:

int
stat(const char *n, struct stat *st)
{
 366:	1101                	addi	sp,sp,-32
 368:	ec06                	sd	ra,24(sp)
 36a:	e822                	sd	s0,16(sp)
 36c:	e426                	sd	s1,8(sp)
 36e:	e04a                	sd	s2,0(sp)
 370:	1000                	addi	s0,sp,32
 372:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 374:	4581                	li	a1,0
 376:	00000097          	auipc	ra,0x0
 37a:	176080e7          	jalr	374(ra) # 4ec <open>
  if(fd < 0)
 37e:	02054563          	bltz	a0,3a8 <stat+0x42>
 382:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 384:	85ca                	mv	a1,s2
 386:	00000097          	auipc	ra,0x0
 38a:	17e080e7          	jalr	382(ra) # 504 <fstat>
 38e:	892a                	mv	s2,a0
  close(fd);
 390:	8526                	mv	a0,s1
 392:	00000097          	auipc	ra,0x0
 396:	142080e7          	jalr	322(ra) # 4d4 <close>
  return r;
}
 39a:	854a                	mv	a0,s2
 39c:	60e2                	ld	ra,24(sp)
 39e:	6442                	ld	s0,16(sp)
 3a0:	64a2                	ld	s1,8(sp)
 3a2:	6902                	ld	s2,0(sp)
 3a4:	6105                	addi	sp,sp,32
 3a6:	8082                	ret
    return -1;
 3a8:	597d                	li	s2,-1
 3aa:	bfc5                	j	39a <stat+0x34>

00000000000003ac <atoi>:

int
atoi(const char *s)
{
 3ac:	1141                	addi	sp,sp,-16
 3ae:	e422                	sd	s0,8(sp)
 3b0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3b2:	00054603          	lbu	a2,0(a0)
 3b6:	fd06079b          	addiw	a5,a2,-48
 3ba:	0ff7f793          	andi	a5,a5,255
 3be:	4725                	li	a4,9
 3c0:	02f76963          	bltu	a4,a5,3f2 <atoi+0x46>
 3c4:	86aa                	mv	a3,a0
  n = 0;
 3c6:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 3c8:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3ca:	0685                	addi	a3,a3,1
 3cc:	0025179b          	slliw	a5,a0,0x2
 3d0:	9fa9                	addw	a5,a5,a0
 3d2:	0017979b          	slliw	a5,a5,0x1
 3d6:	9fb1                	addw	a5,a5,a2
 3d8:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3dc:	0006c603          	lbu	a2,0(a3)
 3e0:	fd06071b          	addiw	a4,a2,-48
 3e4:	0ff77713          	andi	a4,a4,255
 3e8:	fee5f1e3          	bgeu	a1,a4,3ca <atoi+0x1e>
  return n;
}
 3ec:	6422                	ld	s0,8(sp)
 3ee:	0141                	addi	sp,sp,16
 3f0:	8082                	ret
  n = 0;
 3f2:	4501                	li	a0,0
 3f4:	bfe5                	j	3ec <atoi+0x40>

00000000000003f6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3f6:	1141                	addi	sp,sp,-16
 3f8:	e422                	sd	s0,8(sp)
 3fa:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3fc:	02b57663          	bgeu	a0,a1,428 <memmove+0x32>
    while(n-- > 0)
 400:	02c05163          	blez	a2,422 <memmove+0x2c>
 404:	fff6079b          	addiw	a5,a2,-1
 408:	1782                	slli	a5,a5,0x20
 40a:	9381                	srli	a5,a5,0x20
 40c:	0785                	addi	a5,a5,1
 40e:	97aa                	add	a5,a5,a0
  dst = vdst;
 410:	872a                	mv	a4,a0
      *dst++ = *src++;
 412:	0585                	addi	a1,a1,1
 414:	0705                	addi	a4,a4,1
 416:	fff5c683          	lbu	a3,-1(a1)
 41a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 41e:	fee79ae3          	bne	a5,a4,412 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 422:	6422                	ld	s0,8(sp)
 424:	0141                	addi	sp,sp,16
 426:	8082                	ret
    dst += n;
 428:	00c50733          	add	a4,a0,a2
    src += n;
 42c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 42e:	fec05ae3          	blez	a2,422 <memmove+0x2c>
 432:	fff6079b          	addiw	a5,a2,-1
 436:	1782                	slli	a5,a5,0x20
 438:	9381                	srli	a5,a5,0x20
 43a:	fff7c793          	not	a5,a5
 43e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 440:	15fd                	addi	a1,a1,-1
 442:	177d                	addi	a4,a4,-1
 444:	0005c683          	lbu	a3,0(a1)
 448:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 44c:	fee79ae3          	bne	a5,a4,440 <memmove+0x4a>
 450:	bfc9                	j	422 <memmove+0x2c>

0000000000000452 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 452:	1141                	addi	sp,sp,-16
 454:	e422                	sd	s0,8(sp)
 456:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 458:	ca05                	beqz	a2,488 <memcmp+0x36>
 45a:	fff6069b          	addiw	a3,a2,-1
 45e:	1682                	slli	a3,a3,0x20
 460:	9281                	srli	a3,a3,0x20
 462:	0685                	addi	a3,a3,1
 464:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 466:	00054783          	lbu	a5,0(a0)
 46a:	0005c703          	lbu	a4,0(a1)
 46e:	00e79863          	bne	a5,a4,47e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 472:	0505                	addi	a0,a0,1
    p2++;
 474:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 476:	fed518e3          	bne	a0,a3,466 <memcmp+0x14>
  }
  return 0;
 47a:	4501                	li	a0,0
 47c:	a019                	j	482 <memcmp+0x30>
      return *p1 - *p2;
 47e:	40e7853b          	subw	a0,a5,a4
}
 482:	6422                	ld	s0,8(sp)
 484:	0141                	addi	sp,sp,16
 486:	8082                	ret
  return 0;
 488:	4501                	li	a0,0
 48a:	bfe5                	j	482 <memcmp+0x30>

000000000000048c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 48c:	1141                	addi	sp,sp,-16
 48e:	e406                	sd	ra,8(sp)
 490:	e022                	sd	s0,0(sp)
 492:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 494:	00000097          	auipc	ra,0x0
 498:	f62080e7          	jalr	-158(ra) # 3f6 <memmove>
}
 49c:	60a2                	ld	ra,8(sp)
 49e:	6402                	ld	s0,0(sp)
 4a0:	0141                	addi	sp,sp,16
 4a2:	8082                	ret

00000000000004a4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4a4:	4885                	li	a7,1
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <exit>:
.global exit
exit:
 li a7, SYS_exit
 4ac:	4889                	li	a7,2
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4b4:	488d                	li	a7,3
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4bc:	4891                	li	a7,4
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <read>:
.global read
read:
 li a7, SYS_read
 4c4:	4895                	li	a7,5
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <write>:
.global write
write:
 li a7, SYS_write
 4cc:	48c1                	li	a7,16
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <close>:
.global close
close:
 li a7, SYS_close
 4d4:	48d5                	li	a7,21
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <kill>:
.global kill
kill:
 li a7, SYS_kill
 4dc:	4899                	li	a7,6
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4e4:	489d                	li	a7,7
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <open>:
.global open
open:
 li a7, SYS_open
 4ec:	48bd                	li	a7,15
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4f4:	48c5                	li	a7,17
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4fc:	48c9                	li	a7,18
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 504:	48a1                	li	a7,8
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <link>:
.global link
link:
 li a7, SYS_link
 50c:	48cd                	li	a7,19
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 514:	48d1                	li	a7,20
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 51c:	48a5                	li	a7,9
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <dup>:
.global dup
dup:
 li a7, SYS_dup
 524:	48a9                	li	a7,10
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 52c:	48ad                	li	a7,11
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 534:	48b1                	li	a7,12
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 53c:	48b5                	li	a7,13
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 544:	48b9                	li	a7,14
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 54c:	1101                	addi	sp,sp,-32
 54e:	ec06                	sd	ra,24(sp)
 550:	e822                	sd	s0,16(sp)
 552:	1000                	addi	s0,sp,32
 554:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 558:	4605                	li	a2,1
 55a:	fef40593          	addi	a1,s0,-17
 55e:	00000097          	auipc	ra,0x0
 562:	f6e080e7          	jalr	-146(ra) # 4cc <write>
}
 566:	60e2                	ld	ra,24(sp)
 568:	6442                	ld	s0,16(sp)
 56a:	6105                	addi	sp,sp,32
 56c:	8082                	ret

000000000000056e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 56e:	7139                	addi	sp,sp,-64
 570:	fc06                	sd	ra,56(sp)
 572:	f822                	sd	s0,48(sp)
 574:	f426                	sd	s1,40(sp)
 576:	f04a                	sd	s2,32(sp)
 578:	ec4e                	sd	s3,24(sp)
 57a:	0080                	addi	s0,sp,64
 57c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 57e:	c299                	beqz	a3,584 <printint+0x16>
 580:	0805c863          	bltz	a1,610 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 584:	2581                	sext.w	a1,a1
  neg = 0;
 586:	4881                	li	a7,0
 588:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 58c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 58e:	2601                	sext.w	a2,a2
 590:	00000517          	auipc	a0,0x0
 594:	4c050513          	addi	a0,a0,1216 # a50 <digits>
 598:	883a                	mv	a6,a4
 59a:	2705                	addiw	a4,a4,1
 59c:	02c5f7bb          	remuw	a5,a1,a2
 5a0:	1782                	slli	a5,a5,0x20
 5a2:	9381                	srli	a5,a5,0x20
 5a4:	97aa                	add	a5,a5,a0
 5a6:	0007c783          	lbu	a5,0(a5)
 5aa:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5ae:	0005879b          	sext.w	a5,a1
 5b2:	02c5d5bb          	divuw	a1,a1,a2
 5b6:	0685                	addi	a3,a3,1
 5b8:	fec7f0e3          	bgeu	a5,a2,598 <printint+0x2a>
  if(neg)
 5bc:	00088b63          	beqz	a7,5d2 <printint+0x64>
    buf[i++] = '-';
 5c0:	fd040793          	addi	a5,s0,-48
 5c4:	973e                	add	a4,a4,a5
 5c6:	02d00793          	li	a5,45
 5ca:	fef70823          	sb	a5,-16(a4)
 5ce:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5d2:	02e05863          	blez	a4,602 <printint+0x94>
 5d6:	fc040793          	addi	a5,s0,-64
 5da:	00e78933          	add	s2,a5,a4
 5de:	fff78993          	addi	s3,a5,-1
 5e2:	99ba                	add	s3,s3,a4
 5e4:	377d                	addiw	a4,a4,-1
 5e6:	1702                	slli	a4,a4,0x20
 5e8:	9301                	srli	a4,a4,0x20
 5ea:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5ee:	fff94583          	lbu	a1,-1(s2)
 5f2:	8526                	mv	a0,s1
 5f4:	00000097          	auipc	ra,0x0
 5f8:	f58080e7          	jalr	-168(ra) # 54c <putc>
  while(--i >= 0)
 5fc:	197d                	addi	s2,s2,-1
 5fe:	ff3918e3          	bne	s2,s3,5ee <printint+0x80>
}
 602:	70e2                	ld	ra,56(sp)
 604:	7442                	ld	s0,48(sp)
 606:	74a2                	ld	s1,40(sp)
 608:	7902                	ld	s2,32(sp)
 60a:	69e2                	ld	s3,24(sp)
 60c:	6121                	addi	sp,sp,64
 60e:	8082                	ret
    x = -xx;
 610:	40b005bb          	negw	a1,a1
    neg = 1;
 614:	4885                	li	a7,1
    x = -xx;
 616:	bf8d                	j	588 <printint+0x1a>

0000000000000618 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 618:	7119                	addi	sp,sp,-128
 61a:	fc86                	sd	ra,120(sp)
 61c:	f8a2                	sd	s0,112(sp)
 61e:	f4a6                	sd	s1,104(sp)
 620:	f0ca                	sd	s2,96(sp)
 622:	ecce                	sd	s3,88(sp)
 624:	e8d2                	sd	s4,80(sp)
 626:	e4d6                	sd	s5,72(sp)
 628:	e0da                	sd	s6,64(sp)
 62a:	fc5e                	sd	s7,56(sp)
 62c:	f862                	sd	s8,48(sp)
 62e:	f466                	sd	s9,40(sp)
 630:	f06a                	sd	s10,32(sp)
 632:	ec6e                	sd	s11,24(sp)
 634:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 636:	0005c903          	lbu	s2,0(a1)
 63a:	18090f63          	beqz	s2,7d8 <vprintf+0x1c0>
 63e:	8aaa                	mv	s5,a0
 640:	8b32                	mv	s6,a2
 642:	00158493          	addi	s1,a1,1
  state = 0;
 646:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 648:	02500a13          	li	s4,37
      if(c == 'd'){
 64c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 650:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 654:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 658:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 65c:	00000b97          	auipc	s7,0x0
 660:	3f4b8b93          	addi	s7,s7,1012 # a50 <digits>
 664:	a839                	j	682 <vprintf+0x6a>
        putc(fd, c);
 666:	85ca                	mv	a1,s2
 668:	8556                	mv	a0,s5
 66a:	00000097          	auipc	ra,0x0
 66e:	ee2080e7          	jalr	-286(ra) # 54c <putc>
 672:	a019                	j	678 <vprintf+0x60>
    } else if(state == '%'){
 674:	01498f63          	beq	s3,s4,692 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 678:	0485                	addi	s1,s1,1
 67a:	fff4c903          	lbu	s2,-1(s1)
 67e:	14090d63          	beqz	s2,7d8 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 682:	0009079b          	sext.w	a5,s2
    if(state == 0){
 686:	fe0997e3          	bnez	s3,674 <vprintf+0x5c>
      if(c == '%'){
 68a:	fd479ee3          	bne	a5,s4,666 <vprintf+0x4e>
        state = '%';
 68e:	89be                	mv	s3,a5
 690:	b7e5                	j	678 <vprintf+0x60>
      if(c == 'd'){
 692:	05878063          	beq	a5,s8,6d2 <vprintf+0xba>
      } else if(c == 'l') {
 696:	05978c63          	beq	a5,s9,6ee <vprintf+0xd6>
      } else if(c == 'x') {
 69a:	07a78863          	beq	a5,s10,70a <vprintf+0xf2>
      } else if(c == 'p') {
 69e:	09b78463          	beq	a5,s11,726 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6a2:	07300713          	li	a4,115
 6a6:	0ce78663          	beq	a5,a4,772 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6aa:	06300713          	li	a4,99
 6ae:	0ee78e63          	beq	a5,a4,7aa <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6b2:	11478863          	beq	a5,s4,7c2 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6b6:	85d2                	mv	a1,s4
 6b8:	8556                	mv	a0,s5
 6ba:	00000097          	auipc	ra,0x0
 6be:	e92080e7          	jalr	-366(ra) # 54c <putc>
        putc(fd, c);
 6c2:	85ca                	mv	a1,s2
 6c4:	8556                	mv	a0,s5
 6c6:	00000097          	auipc	ra,0x0
 6ca:	e86080e7          	jalr	-378(ra) # 54c <putc>
      }
      state = 0;
 6ce:	4981                	li	s3,0
 6d0:	b765                	j	678 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6d2:	008b0913          	addi	s2,s6,8
 6d6:	4685                	li	a3,1
 6d8:	4629                	li	a2,10
 6da:	000b2583          	lw	a1,0(s6)
 6de:	8556                	mv	a0,s5
 6e0:	00000097          	auipc	ra,0x0
 6e4:	e8e080e7          	jalr	-370(ra) # 56e <printint>
 6e8:	8b4a                	mv	s6,s2
      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	b771                	j	678 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ee:	008b0913          	addi	s2,s6,8
 6f2:	4681                	li	a3,0
 6f4:	4629                	li	a2,10
 6f6:	000b2583          	lw	a1,0(s6)
 6fa:	8556                	mv	a0,s5
 6fc:	00000097          	auipc	ra,0x0
 700:	e72080e7          	jalr	-398(ra) # 56e <printint>
 704:	8b4a                	mv	s6,s2
      state = 0;
 706:	4981                	li	s3,0
 708:	bf85                	j	678 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 70a:	008b0913          	addi	s2,s6,8
 70e:	4681                	li	a3,0
 710:	4641                	li	a2,16
 712:	000b2583          	lw	a1,0(s6)
 716:	8556                	mv	a0,s5
 718:	00000097          	auipc	ra,0x0
 71c:	e56080e7          	jalr	-426(ra) # 56e <printint>
 720:	8b4a                	mv	s6,s2
      state = 0;
 722:	4981                	li	s3,0
 724:	bf91                	j	678 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 726:	008b0793          	addi	a5,s6,8
 72a:	f8f43423          	sd	a5,-120(s0)
 72e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 732:	03000593          	li	a1,48
 736:	8556                	mv	a0,s5
 738:	00000097          	auipc	ra,0x0
 73c:	e14080e7          	jalr	-492(ra) # 54c <putc>
  putc(fd, 'x');
 740:	85ea                	mv	a1,s10
 742:	8556                	mv	a0,s5
 744:	00000097          	auipc	ra,0x0
 748:	e08080e7          	jalr	-504(ra) # 54c <putc>
 74c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 74e:	03c9d793          	srli	a5,s3,0x3c
 752:	97de                	add	a5,a5,s7
 754:	0007c583          	lbu	a1,0(a5)
 758:	8556                	mv	a0,s5
 75a:	00000097          	auipc	ra,0x0
 75e:	df2080e7          	jalr	-526(ra) # 54c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 762:	0992                	slli	s3,s3,0x4
 764:	397d                	addiw	s2,s2,-1
 766:	fe0914e3          	bnez	s2,74e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 76a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 76e:	4981                	li	s3,0
 770:	b721                	j	678 <vprintf+0x60>
        s = va_arg(ap, char*);
 772:	008b0993          	addi	s3,s6,8
 776:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 77a:	02090163          	beqz	s2,79c <vprintf+0x184>
        while(*s != 0){
 77e:	00094583          	lbu	a1,0(s2)
 782:	c9a1                	beqz	a1,7d2 <vprintf+0x1ba>
          putc(fd, *s);
 784:	8556                	mv	a0,s5
 786:	00000097          	auipc	ra,0x0
 78a:	dc6080e7          	jalr	-570(ra) # 54c <putc>
          s++;
 78e:	0905                	addi	s2,s2,1
        while(*s != 0){
 790:	00094583          	lbu	a1,0(s2)
 794:	f9e5                	bnez	a1,784 <vprintf+0x16c>
        s = va_arg(ap, char*);
 796:	8b4e                	mv	s6,s3
      state = 0;
 798:	4981                	li	s3,0
 79a:	bdf9                	j	678 <vprintf+0x60>
          s = "(null)";
 79c:	00000917          	auipc	s2,0x0
 7a0:	2ac90913          	addi	s2,s2,684 # a48 <malloc+0x166>
        while(*s != 0){
 7a4:	02800593          	li	a1,40
 7a8:	bff1                	j	784 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7aa:	008b0913          	addi	s2,s6,8
 7ae:	000b4583          	lbu	a1,0(s6)
 7b2:	8556                	mv	a0,s5
 7b4:	00000097          	auipc	ra,0x0
 7b8:	d98080e7          	jalr	-616(ra) # 54c <putc>
 7bc:	8b4a                	mv	s6,s2
      state = 0;
 7be:	4981                	li	s3,0
 7c0:	bd65                	j	678 <vprintf+0x60>
        putc(fd, c);
 7c2:	85d2                	mv	a1,s4
 7c4:	8556                	mv	a0,s5
 7c6:	00000097          	auipc	ra,0x0
 7ca:	d86080e7          	jalr	-634(ra) # 54c <putc>
      state = 0;
 7ce:	4981                	li	s3,0
 7d0:	b565                	j	678 <vprintf+0x60>
        s = va_arg(ap, char*);
 7d2:	8b4e                	mv	s6,s3
      state = 0;
 7d4:	4981                	li	s3,0
 7d6:	b54d                	j	678 <vprintf+0x60>
    }
  }
}
 7d8:	70e6                	ld	ra,120(sp)
 7da:	7446                	ld	s0,112(sp)
 7dc:	74a6                	ld	s1,104(sp)
 7de:	7906                	ld	s2,96(sp)
 7e0:	69e6                	ld	s3,88(sp)
 7e2:	6a46                	ld	s4,80(sp)
 7e4:	6aa6                	ld	s5,72(sp)
 7e6:	6b06                	ld	s6,64(sp)
 7e8:	7be2                	ld	s7,56(sp)
 7ea:	7c42                	ld	s8,48(sp)
 7ec:	7ca2                	ld	s9,40(sp)
 7ee:	7d02                	ld	s10,32(sp)
 7f0:	6de2                	ld	s11,24(sp)
 7f2:	6109                	addi	sp,sp,128
 7f4:	8082                	ret

00000000000007f6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7f6:	715d                	addi	sp,sp,-80
 7f8:	ec06                	sd	ra,24(sp)
 7fa:	e822                	sd	s0,16(sp)
 7fc:	1000                	addi	s0,sp,32
 7fe:	e010                	sd	a2,0(s0)
 800:	e414                	sd	a3,8(s0)
 802:	e818                	sd	a4,16(s0)
 804:	ec1c                	sd	a5,24(s0)
 806:	03043023          	sd	a6,32(s0)
 80a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 80e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 812:	8622                	mv	a2,s0
 814:	00000097          	auipc	ra,0x0
 818:	e04080e7          	jalr	-508(ra) # 618 <vprintf>
}
 81c:	60e2                	ld	ra,24(sp)
 81e:	6442                	ld	s0,16(sp)
 820:	6161                	addi	sp,sp,80
 822:	8082                	ret

0000000000000824 <printf>:

void
printf(const char *fmt, ...)
{
 824:	711d                	addi	sp,sp,-96
 826:	ec06                	sd	ra,24(sp)
 828:	e822                	sd	s0,16(sp)
 82a:	1000                	addi	s0,sp,32
 82c:	e40c                	sd	a1,8(s0)
 82e:	e810                	sd	a2,16(s0)
 830:	ec14                	sd	a3,24(s0)
 832:	f018                	sd	a4,32(s0)
 834:	f41c                	sd	a5,40(s0)
 836:	03043823          	sd	a6,48(s0)
 83a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 83e:	00840613          	addi	a2,s0,8
 842:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 846:	85aa                	mv	a1,a0
 848:	4505                	li	a0,1
 84a:	00000097          	auipc	ra,0x0
 84e:	dce080e7          	jalr	-562(ra) # 618 <vprintf>
}
 852:	60e2                	ld	ra,24(sp)
 854:	6442                	ld	s0,16(sp)
 856:	6125                	addi	sp,sp,96
 858:	8082                	ret

000000000000085a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 85a:	1141                	addi	sp,sp,-16
 85c:	e422                	sd	s0,8(sp)
 85e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 860:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 864:	00000797          	auipc	a5,0x0
 868:	2047b783          	ld	a5,516(a5) # a68 <freep>
 86c:	a805                	j	89c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 86e:	4618                	lw	a4,8(a2)
 870:	9db9                	addw	a1,a1,a4
 872:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 876:	6398                	ld	a4,0(a5)
 878:	6318                	ld	a4,0(a4)
 87a:	fee53823          	sd	a4,-16(a0)
 87e:	a091                	j	8c2 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 880:	ff852703          	lw	a4,-8(a0)
 884:	9e39                	addw	a2,a2,a4
 886:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 888:	ff053703          	ld	a4,-16(a0)
 88c:	e398                	sd	a4,0(a5)
 88e:	a099                	j	8d4 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 890:	6398                	ld	a4,0(a5)
 892:	00e7e463          	bltu	a5,a4,89a <free+0x40>
 896:	00e6ea63          	bltu	a3,a4,8aa <free+0x50>
{
 89a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89c:	fed7fae3          	bgeu	a5,a3,890 <free+0x36>
 8a0:	6398                	ld	a4,0(a5)
 8a2:	00e6e463          	bltu	a3,a4,8aa <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a6:	fee7eae3          	bltu	a5,a4,89a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8aa:	ff852583          	lw	a1,-8(a0)
 8ae:	6390                	ld	a2,0(a5)
 8b0:	02059713          	slli	a4,a1,0x20
 8b4:	9301                	srli	a4,a4,0x20
 8b6:	0712                	slli	a4,a4,0x4
 8b8:	9736                	add	a4,a4,a3
 8ba:	fae60ae3          	beq	a2,a4,86e <free+0x14>
    bp->s.ptr = p->s.ptr;
 8be:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8c2:	4790                	lw	a2,8(a5)
 8c4:	02061713          	slli	a4,a2,0x20
 8c8:	9301                	srli	a4,a4,0x20
 8ca:	0712                	slli	a4,a4,0x4
 8cc:	973e                	add	a4,a4,a5
 8ce:	fae689e3          	beq	a3,a4,880 <free+0x26>
  } else
    p->s.ptr = bp;
 8d2:	e394                	sd	a3,0(a5)
  freep = p;
 8d4:	00000717          	auipc	a4,0x0
 8d8:	18f73a23          	sd	a5,404(a4) # a68 <freep>
}
 8dc:	6422                	ld	s0,8(sp)
 8de:	0141                	addi	sp,sp,16
 8e0:	8082                	ret

00000000000008e2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8e2:	7139                	addi	sp,sp,-64
 8e4:	fc06                	sd	ra,56(sp)
 8e6:	f822                	sd	s0,48(sp)
 8e8:	f426                	sd	s1,40(sp)
 8ea:	f04a                	sd	s2,32(sp)
 8ec:	ec4e                	sd	s3,24(sp)
 8ee:	e852                	sd	s4,16(sp)
 8f0:	e456                	sd	s5,8(sp)
 8f2:	e05a                	sd	s6,0(sp)
 8f4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8f6:	02051493          	slli	s1,a0,0x20
 8fa:	9081                	srli	s1,s1,0x20
 8fc:	04bd                	addi	s1,s1,15
 8fe:	8091                	srli	s1,s1,0x4
 900:	0014899b          	addiw	s3,s1,1
 904:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 906:	00000517          	auipc	a0,0x0
 90a:	16253503          	ld	a0,354(a0) # a68 <freep>
 90e:	c515                	beqz	a0,93a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 910:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 912:	4798                	lw	a4,8(a5)
 914:	02977f63          	bgeu	a4,s1,952 <malloc+0x70>
 918:	8a4e                	mv	s4,s3
 91a:	0009871b          	sext.w	a4,s3
 91e:	6685                	lui	a3,0x1
 920:	00d77363          	bgeu	a4,a3,926 <malloc+0x44>
 924:	6a05                	lui	s4,0x1
 926:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 92a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 92e:	00000917          	auipc	s2,0x0
 932:	13a90913          	addi	s2,s2,314 # a68 <freep>
  if(p == (char*)-1)
 936:	5afd                	li	s5,-1
 938:	a88d                	j	9aa <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 93a:	00000797          	auipc	a5,0x0
 93e:	13678793          	addi	a5,a5,310 # a70 <base>
 942:	00000717          	auipc	a4,0x0
 946:	12f73323          	sd	a5,294(a4) # a68 <freep>
 94a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 94c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 950:	b7e1                	j	918 <malloc+0x36>
      if(p->s.size == nunits)
 952:	02e48b63          	beq	s1,a4,988 <malloc+0xa6>
        p->s.size -= nunits;
 956:	4137073b          	subw	a4,a4,s3
 95a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 95c:	1702                	slli	a4,a4,0x20
 95e:	9301                	srli	a4,a4,0x20
 960:	0712                	slli	a4,a4,0x4
 962:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 964:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 968:	00000717          	auipc	a4,0x0
 96c:	10a73023          	sd	a0,256(a4) # a68 <freep>
      return (void*)(p + 1);
 970:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 974:	70e2                	ld	ra,56(sp)
 976:	7442                	ld	s0,48(sp)
 978:	74a2                	ld	s1,40(sp)
 97a:	7902                	ld	s2,32(sp)
 97c:	69e2                	ld	s3,24(sp)
 97e:	6a42                	ld	s4,16(sp)
 980:	6aa2                	ld	s5,8(sp)
 982:	6b02                	ld	s6,0(sp)
 984:	6121                	addi	sp,sp,64
 986:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 988:	6398                	ld	a4,0(a5)
 98a:	e118                	sd	a4,0(a0)
 98c:	bff1                	j	968 <malloc+0x86>
  hp->s.size = nu;
 98e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 992:	0541                	addi	a0,a0,16
 994:	00000097          	auipc	ra,0x0
 998:	ec6080e7          	jalr	-314(ra) # 85a <free>
  return freep;
 99c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9a0:	d971                	beqz	a0,974 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9a4:	4798                	lw	a4,8(a5)
 9a6:	fa9776e3          	bgeu	a4,s1,952 <malloc+0x70>
    if(p == freep)
 9aa:	00093703          	ld	a4,0(s2)
 9ae:	853e                	mv	a0,a5
 9b0:	fef719e3          	bne	a4,a5,9a2 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 9b4:	8552                	mv	a0,s4
 9b6:	00000097          	auipc	ra,0x0
 9ba:	b7e080e7          	jalr	-1154(ra) # 534 <sbrk>
  if(p == (char*)-1)
 9be:	fd5518e3          	bne	a0,s5,98e <malloc+0xac>
        return 0;
 9c2:	4501                	li	a0,0
 9c4:	bf45                	j	974 <malloc+0x92>
