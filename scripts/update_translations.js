const fs = require('fs');
const path = require('path');

const questionsPath = path.join(__dirname, '../src/data/questionsMY.json');
const questions = require(questionsPath);

const translations = {
  "my_int_004": {
    "text_ms": "Anda menghampiri pintu masuk pelanggan dari jalan awam. Lorong akses di hadapan sempit dan separa terhalang, dengan kenderaan keluar dan masuk tapak. Apa yang perlu anda lakukan sekarang?",
    "options_ms": [
      "Kekalkan kelajuan pendekatan anda untuk mengelak daripada menghalang lalu lintas di belakang",
      "Perlahan awal dan teruskan hanya apabila laluan akses jelas selamat",
      "Bergerak lebih dekat untuk menilai ruang sebelum memutuskan sama ada hendak berhenti",
      "Masuk ke lorong akses dan laraskan kedudukan setelah masuk"
    ],
    "explanation_ms": "Menjangkakan kekangan akses lebih awal membolehkan kemasukan lebih selamat dan mengurangkan pelarasan saat akhir di ruang yang sempit."
  },
  "my_int_005": {
    "text_ms": "Anda sedang memandu di dalam lorong terminal kontena. RTG sedang mengangkat kontena di sebelah lorong, dan kenderaan limbungan sedang bergerak keluar masuk di hadapan. Jarak penglihatan adalah jelas, tetapi pergerakan di sekitar lorong adalah aktif. Apa yang perlu anda lakukan sekarang?",
    "options_ms": [
      "Kekalkan kelajuan yang stabil dan lalu sambil memastikan RTG dalam pemandangan",
      "Kurangkan kelajuan awal dan lalu kawasan dengan berhati-hati",
      "Teruskan pada kelajuan sederhana dan laraskan hanya jika peralatan bergerak lebih dekat",
      "Perlahan sedikit tetapi terus bergerak untuk mengelakkan kelewatan trafik terminal"
    ],
    "explanation_ms": "Mengurangkan kelajuan awal berhampiran peralatan mengangkat yang aktif memberi masa dan ruang untuk mengurus pergerakan mengejut dengan selamat."
  },
  "my_int_006": {
    "text_ms": "Anda memandu dalam kesesakan lalu lintas yang stabil di jalan berbilang lorong. Motosikal sedang mencelah di antara lorong di hadapan, dan kenderaan lebih jauh di hadapan perlahan seketika berhampiran susur keluar. Apa yang perlu anda lakukan sekarang?",
    "options_ms": [
      "Kekalkan kedudukan lorong anda dan bersedia untuk pergerakan mengejut di sekeliling anda",
      "Tukar lorong awal untuk mengelakkan kemungkinan perlahan di hadapan",
      "Kekalkan lorong anda tetapi bergerak sedikit ke arah penanda lorong untuk penglihatan",
      "Teruskan seperti biasa dan bertindak balas hanya jika trafik perlahan dengan ketara"
    ],
    "explanation_ms": "Kedudukan lorong yang stabil digabungkan dengan jangkaan awal membantu mengurus pergerakan yang tidak dapat diramalkan dengan selamat."
  },
  "my_int_007": {
    "text_ms": "Anda mengikuti lalu lintas pada kelajuan persiaran. Lampu brek muncul sekejap-sekejap beberapa kenderaan di hadapan, dan motosikal bergerak di antara lorong. Aliran trafik kekal stabil buat masa ini. Apa yang perlu anda lakukan sekarang?",
    "options_ms": [
      "Tingkatkan jarak ikut untuk membolehkan perlahan mengejut di hadapan",
      "Kekalkan jarak dan bergantung pada brek jika trafik perlahan",
      "Bergerak lebih dekat untuk memadankan rentak kenderaan di hadapan",
      "Tukar lorong untuk mengelakkan pergerakan yang tidak dapat diramalkan"
    ],
    "explanation_ms": "Ruang tambahan memberi anda lebih banyak masa untuk bertindak balas apabila bahaya timbul di hadapan."
  },
  "my_int_008": {
    "text_ms": "Anda sedang bersedia untuk menukar lorong dalam trafik yang stabil. Motosikal sedang mencelah di antara lorong, dan kenderaan di hadapan perlahan seketika berhampiran susur keluar. Apa yang perlu anda lakukan sekarang?",
    "options_ms": [
      "Beri isyarat awal dan selesaikan pemeriksaan cermin sepenuhnya sebelum bergerak",
      "Beri isyarat semasa anda mula bergerak dan bergantung pada pemandu di sekeliling anda untuk menyesuaikan diri",
      "Periksa cermin dengan cepat dan bergerak sebaik sahaja lorong bersebelahan kelihatan jelas",
      "Tunggu lalu lintas stabil sebelum memutuskan sama ada untuk memberi isyarat"
    ],
    "explanation_ms": "Pemberian isyarat awal dan pemeriksaan penuh membantu pengguna jalan raya lain menjangkakan pergerakan anda dengan selamat."
  },
  "my_int_009": {
    "text_ms": "Anda sedang bergabung dari jalan susur ke lebuh raya yang sibuk. Trafik bergerak, tetapi kenderaan di hadapan brek tidak sekata, dan motosikal lalu di antara lorong. Apa yang perlu anda lakukan sekarang?",
    "options_ms": [
      "Tunggu ruang yang jelas selamat sebelum bergabung",
      "Gabung ke dalam aliran dan laraskan kelajuan sebaik sahaja berada sepenuhnya di lebuh raya",
      "Gunakan ruang yang ada dengan pantas sebelum trafik menghampiri",
      "Bergerak ke hadapan untuk memberi isyarat niat dan bergabung apabila kenderaan perlahan"
    ],
    "explanation_ms": "Memilih ruang yang selamat mengurangkan brek mengejut dan konflik semasa bergabung."
  },
  "my_int_010": {
    "text_ms": "Anda menghampiri simpang yang sibuk di mana kenderaan masuk dari pelbagai arah. Trafik di hadapan perlahan, dan penglihatan sebahagiannya terhad oleh kenderaan sekeliling. Apa yang perlu anda lakukan sekarang?",
    "options_ms": [
      "Kurangkan kelajuan awal dan bersedia untuk berhenti jika perlu",
      "Kekalkan kelajuan dan brek dengan kuat hanya jika kenderaan lain masuk",
      "Perlahan sedikit dan teruskan sebaik sahaja kenderaan di hadapan bergerak",
      "Terus bergerak untuk membersihkan simpang dengan cepat apabila ruang muncul"
    ],
    "explanation_ms": "Kelajuan yang lebih rendah sebelum simpang memberi anda masa untuk bertindak balas dengan selamat terhadap pergerakan yang tidak dijangka."
  },
  "my_int_011": {
    "text_ms": "Anda menghampiri simpang sibuk dengan berbilang lorong masuk. Trafik perlahan tidak sekata, dan kenderaan dari sisi mula bergerak ke hadapan sedikit. Apa yang perlu anda lakukan sekarang?",
    "options_ms": [
      "Pegang lorong anda dengan jelas dan dekati simpang pada kelajuan yang dikurangkan",
      "Alih sedikit dalam lorong anda untuk meningkatkan penglihatan sebelum membuat keputusan",
      "Bergerak lebih dekat ke simpang untuk menghalang kenderaan lain daripada bergerak",
      "Teruskan pada rentak yang sama dan bertindak balas hanya jika kenderaan lain masuk"
    ],
    "explanation_ms": "Kedudukan lorong yang jelas dan kawalan kelajuan awal membantu mengurangkan konflik di simpang."
  },
  "my_int_012": {
    "text_ms": "Anda memandu pada waktu malam dalam hujan lebat di jalan menurun bukit. Jarak penglihatan berkurangan, dan kenderaan di hadapan perlahan secara tidak dapat diramalkan. Apakah tindakan terbaik?",
    "options_ms": [
      "Kurangkan kelajuan awal untuk memadankan keadaan risiko yang lebih tinggi",
      "Kekalkan kelajuan dan bergantung pada lampu depan serta brek jika perlu",
      "Perlahan sedikit dan laraskan hanya jika penglihatan bertambah buruk",
      "Ikut rentak kenderaan di hadapan untuk mengelakkan gangguan lalu lintas"
    ],
    "explanation_ms": "Kelajuan yang lebih rendah dalam keadaan berisiko tinggi memberikan masa dan kawalan apabila penglihatan berkurangan."
  },
  "my_int_013": {
    "text_ms": "Anda sedang memandu dalam trafik perlahan apabila pemandu lain tiba-tiba memotong masuk dan brek mengejut. Trafik terus bergerak, tetapi anda rasa tertekan dengan situasi itu. Apa yang perlu anda lakukan sekarang?",
    "options_ms": [
      "Kurangkan kelajuan dengan lancar dan kekalkan rentak yang selamat",
      "Kekalkan kelajuan untuk mengelak daripada ditolak ke belakang oleh kenderaan lain",
      "Perlahan seketika, kemudian lajukan untuk mewujudkan ruang di hadapan",
      "Laraskan kelajuan hanya selepas trafik kembali tenang"
    ],
    "explanation_ms": "Kawalan kelajuan yang tenang membantu mencegah reaksi impulsif apabila tingkah laku trafik mengecewakan."
  },
  "my_int_014": {
    "text_ms": "Anda sedang mengikuti kenderaan yang bergerak perlahan di jalan yang sibuk. Trafik mengalir di lorong bersebelahan, dan anda berasa terganggu dengan kelewatan itu. Apa yang perlu anda lakukan sekarang?",
    "options_ms": [
      "Tunggu ruang yang jelas selamat sebelum memotong",
      "Potong dengan cepat untuk mengelakkan terus terperangkap di belakang kenderaan",
      "Bergerak lebih dekat untuk memberi isyarat niat anda dan menggalakkan pemandu di hadapan",
      "Mula memotong dan laraskan kedudukan anda semasa trafik bertindak balas"
    ],
    "explanation_ms": "Menguruskan kekecewaan membantu memastikan keputusan memotong selamat dan dinilai dengan baik."
  },
  "my_int_015": {
    "text_ms": "Anda sedang memandu dalam hujan lebat pada waktu malam. Percikan air daripada kenderaan di hadapan mengurangkan penglihatan, dan aliran trafik kekal stabil. Apa yang perlu anda lakukan sekarang?",
    "options_ms": [
      "Tingkatkan jarak ikut untuk membolehkan lebih banyak masa tindak balas",
      "Kekalkan jarak memandangkan kelajuan trafik konsisten",
      "Rapatkan jurang sedikit untuk mengekalkan hubungan visual dengan kenderaan di hadapan",
      "Kekal pada jarak yang sama dan bertindak balas hanya jika trafik perlahan"
    ],
    "explanation_ms": "Jarak tambahan dalam penglihatan yang lemah membantu menguruskan perlahan mengejut dengan selamat."
  },
  "my_int_016": {
    "text_ms": "Anda sedang memandu di dalam depot dengan lorong bertanda dan peraturan tapak yang dipaparkan. Peralatan mudah alih beroperasi berhampiran, dan penglihatan sebahagiannya terhad oleh muatan yang disusun. Trafik di dalam limbungan tidak sekata. Apakah tindakan paling selamat?",
    "options_ms": [
      "Kekal di lorong bertanda dan perlahan sehingga pergerakan peralatan jelas selamat",
      "Laraskan kedudukan anda sedikit untuk melihat melepasi peralatan sebelum memutuskan cara untuk meneruskan",
      "Teruskan bergerak dengan stabil supaya anda tidak menghalang peralatan bekerja di belakang anda",
      "Teruskan seperti biasa dan bergantung pada pengendali peralatan untuk mengekalkan jarak selamat"
    ],
    "explanation_ms": "Disiplin lorong yang jelas dan pengurangan kelajuan awal membantu mencegah konflik dengan peralatan yang beroperasi di persekitaran tapak."
  },
  "my_int_017": {
    "text_ms": "Anda perlu mengundur ke dalam petak bertanda di dalam limbungan gudang. Peraturan tapak terpakai, ruang sempit, dan kenderaan lain bergerak berhampiran. Penglihatan terhad. Apa yang perlu anda lakukan sekarang?",
    "options_ms": [
      "Berhenti dan tunggu sehingga anda mempunyai penglihatan yang jelas dan pelepasan yang disahkan sebelum mengundur",
      "Mula mengundur perlahan-lahan sambil memeriksa cermin dan melaras mengikut ruang yang ada",
      "Teruskan manuver untuk mengelakkan kelewatan orang lain di belakang anda",
      "Undur dengan berhati-hati dan bergantung pada orang lain berhampiran untuk menjauhkan diri"
    ],
    "explanation_ms": "Penglihatan yang jelas dan pematuhan peraturan tapak mengurangkan risiko semasa mengundur kelajuan rendah di kawasan terkurung."
  },
  "my_int_018": {
    "text_ms": "Anda berjalan kaki berhampiran kenderaan anda di kawasan pemuatan yang aktif. Forklift sedang memindahkan palet, garis penglihatan sebahagiannya terhalang oleh barangan yang disusun, dan tahap aktiviti berubah dengan cepat. Apa yang perlu anda lakukan sekarang?",
    "options_ms": [
      "Jauhi laluan pemuatan aktif dan tunggu sehingga pergerakan di sekeliling anda reda",
      "Bergerak lebih dekat ke aktiviti pemuatan untuk menjejaki pergerakan peralatan",
      "Berjalan melalui kawasan itu dengan langkah yang stabil untuk meminimumkan masa yang dihabiskan dalam zon",
      "Tempatkan diri anda di mana pengendali boleh melihat anda dan terus bergerak"
    ],
    "explanation_ms": "Mengekalkan pemisahan yang jelas daripada aktiviti pemuatan mengurangkan pendedahan kepada pergerakan peralatan mengejut dan titik buta."
  },
  "my_int_019": {
    "text_ms": "Anda menghampiri pusat pemeriksaan di dalam kemudahan besar. Kenderaan beratur tidak sekata, dan lorong dalaman bercabang ke arah titik pemeriksaan yang berbeza. Sesetengah pemandu sedang mengubah kedudukan untuk bergerak lebih pantas. Apakah tindakan paling selamat?",
    "options_ms": [
      "Kekal di lorong yang ditetapkan dan tunggu arahan pusat pemeriksaan sebelum mengubah kedudukan",
      "Beralih awal ke lorong yang kurang sesak untuk mengurangkan masa menunggu",
      "Bergerak ke hadapan secara beransur-ansur dan laraskan kedudukan anda apabila lebih dekat dengan pusat pemeriksaan",
      "Ikut kenderaan di hadapan jika lorongnya kelihatan lebih cepat bersih"
    ],
    "explanation_ms": "Pergerakan yang teratur dan menunggu arahan pusat pemeriksaan mengurangkan kekeliruan dan konflik di zon terkawal."
  },
  "my_int_020": {
    "text_ms": "Anda tiba di tapak pelanggan di mana lorong akses adalah sempit dan aktiviti pemuatan sedang berjalan. Forklift bergerak berhampiran, dan ruang di sekitar kawasan pemuatan adalah terhad. Apakah tindakan paling selamat?",
    "options_ms": [
      "Tunggu di luar kawasan pemuatan sehingga akses jelas tersedia",
      "Bergerak ke hadapan perlahan-lahan untuk mendapatkan kedudukan berhampiran titik pemuatan",
      "Hampiri kawasan itu sambil memastikan diri anda kelihatan kepada kakitangan tapak",
      "Teruskan mara dengan berhati-hati untuk mengelakkan kelewatan operasi pemuatan"
    ],
    "explanation_ms": "Menjaga jarak dari titik akses terhad dan kawasan pemuatan aktif mengurangkan pendedahan kepada pergerakan mengejut."
  },
  "my_int_021": {
    "text_ms": "Anda berada di tapak pelanggan di mana pemuatan sedang berjalan semasa hujan lebat. Permukaan tanah basah, penglihatan berkurangan, dan pergerakan peralatan berterusan berhampiran kawasan pemuatan. Apa yang harus anda lakukan sekarang?",
    "options_ms": [
      "Jauhi kawasan pemuatan sehingga keadaan stabil dan pergerakan perlahan",
      "Teruskan dengan berhati-hati ke kawasan itu sambil melaraskan langkah anda untuk cuaca",
      "Posisikan diri anda lebih dekat untuk memantau pergerakan peralatan walaupun penglihatan berkurangan",
      "Teruskan menghampiri perlahan-lahan supaya pemuatan boleh diteruskan tanpa gangguan"
    ],
    "explanation_ms": "Menyesuaikan diri dengan keadaan persekitaran dan menjauhi kawasan pemuatan aktif mengurangkan risiko apabila bahaya meningkat."
  },
  "my_int_022": {
    "text_ms": "Di dalam limbungan terminal, peralatan mudah alih beroperasi berhampiran. Seorang marsyal tapak memberi isyarat kepada anda untuk menahan kedudukan sementara peralatan melengkapkan pergerakan di laluan anda. Apakah tindakan terbaik?",
    "options_ms": [
      "Kekal pegun di titik yang diarahkan sehingga marsyal memberi isyarat untuk meneruskan",
      "Maju ke hadapan sedikit untuk meningkatkan penglihatan pergerakan peralatan",
      "Tahan kedudukan sebentar, kemudian maju setelah peralatan kelihatan jelas",
      "Ikut kenderaan di hadapan jika ia mula bergerak melepasi peralatan"
    ],
    "explanation_ms": "Mengikut arahan pihak berkuasa tapak dan mengekalkan jarak dari peralatan operasi membantu mencegah konflik di limbungan terkawal."
  },
  "my_int_023": {
    "text_ms": "Anda berada di dalam terminal kontena di mana RTG beroperasi merentasi lorong bertanda. Peraturan terminal menetapkan zon jelas di sekitar operasi mengangkat, dan pergerakan peralatan adalah berterusan. Apa yang perlu anda lakukan sekarang?",
    "options_ms": [
      "Kekal di luar zon jelas bertanda sehingga operasi mengangkat berhenti dan akses diberikan",
      "Bergerak di sepanjang tepi lorong untuk mengekalkan kemajuan sambil tetap waspada terhadap peralatan",
      "Maju perlahan-lahan melalui kawasan itu apabila RTG kelihatan sedang mengubah kedudukan",
      "Ikut kenderaan di hadapan sebaik sahaja ia mula bergerak melepasi RTG"
    ],
    "explanation_ms": "Menghormati zon jelas terminal dan menunggu akses selamat mengurangkan pendedahan kepada bahaya peralatan mengangkat."
  },
  "my_int_024": {
    "text_ms": "Di terminal kontena, kren sedang mengangkat kontena sementara kenderaan dan kakitangan bergerak berhampiran. Anda perlu berada di kawasan itu untuk bersedia bagi langkah seterusnya setelah pengangkatan selesai. Apakah tindakan terbaik?",
    "options_ms": [
      "Jauhi zon mengangkat sehingga operasi selesai dan kawasan itu dilepaskan",
      "Posisikan diri anda lebih dekat untuk memerhati lif dan bersedia untuk bergerak apabila ia berakhir",
      "Tunggu berdekatan dan hampiri sebaik sahaja kontena hampir diletakkan",
      "Bergerak ke hadapan dengan berhati-hati dan waspada untuk mengelakkan kelewatan trak yang beratur di belakang anda"
    ],
    "explanation_ms": "Menjauhi zon mengangkat melindungi daripada pergerakan mengejut dan risiko objek jatuh semasa operasi."
  },
  "my_int_025": {
    "text_ms": "Anda menghampiri pintu pagar terminal di mana dokumen diperiksa sebelum masuk. Kenderaan sedang beratur, dan sesetengah pemandu sedang mengubah kedudukan untuk sejajar dengan lorong yang bergerak lebih pantas semasa proses pintu pagar diteruskan. Apakah tindakan paling selamat?",
    "options_ms": [
      "Kekal di lorong yang ditetapkan dan ikut proses pintu pagar sehingga pelepasan diberikan",
      "Beralih ke arah lorong yang lebih pantas sebaik sahaja anda melihat kenderaan lain diproses",
      "Bergerak ke hadapan secara beransur-ansur untuk bersedia bagi pemeriksaan apabila ruang terbuka di hadapan",
      "Ikut kenderaan di hadapan jika ia mula maju melalui pintu pagar, dengan anggapan proses itu sudah jelas"
    ],
    "explanation_ms": "Kekal dalam lorong yang ditetapkan dan mengikut arahan pintu pagar membantu memastikan kemasukan terminal teratur dan selamat."
  },
  "my_int_026": {
    "text_ms": "Anda sedang memandu dalam tapak perindustrian di mana peralatan mudah alih beroperasi berhampiran jalan dalaman. Jarak penglihatan jelas, tetapi pergerakan peralatan kerap berubah semasa kerja berjalan. Apa yang perlu anda lakukan sekarang?",
    "options_ms": [
      "Kurangkan kelajuan awal dan kekalkan jarak tambahan dari peralatan operasi",
      "Kekalkan rentak yang stabil dan laraskan hanya jika peralatan bergerak ke laluah anda",
      "Teruskan pada kelajuan rendah untuk melepasi dengan cepat sebelum peralatan mengubah kedudukan",
      "Ikut kenderaan di hadapan jika ia kelihatan bergerak dengan selamat melepasi peralatan"
    ],
    "explanation_ms": "Pengurangan kelajuan awal dan peningkatan jarak membantu mencegah konflik mengejut dengan peralatan bergerak di dalam tapak."
  },
  "my_int_027": {
    "text_ms": "Di dalam limbungan tapak, anda perlu mengundur ke ruang yang sempit sementara kenderaan dan peralatan lain beroperasi berhampiran. Pergerakan di sekitar kawasan itu perlahan tetapi berterusan. Apakah tindakan paling selamat?",
    "options_ms": [
      "Perlahan sepenuhnya dan mula mengundur hanya apabila ruang dan penglihatan jelas",
      "Undur perlahan-lahan sambil melaraskan kelajuan apabila keadaan di sekeliling anda berubah",
      "Selesaikan manuver dengan lancar untuk meminimumkan gangguan kepada orang lain",
      "Ikut pergerakan kenderaan berdekatan untuk memandu kelajuan mengundur anda"
    ],
    "explanation_ms": "Kawalan kelajuan yang jelas dan pergerakan berkelajuan rendah yang disengajakan mengurangkan risiko semasa mengundur dalam persekitaran tapak yang sibuk."
  },
  "my_int_028": {
    "text_ms": "Anda sedang memandu di dalam kemudahan besar di mana trafik dalaman bergerak perlahan. Kenderaan beratur di hadapan sementara forklift beroperasi berhampiran jalan dalaman, kadang-kadang melintasi antara lorong. Apakah tindakan paling selamat?",
    "options_ms": [
      "Tingkatkan jarak ikut anda dan kekalkan garis penglihatan yang jelas di sekitar peralatan bergerak",
      "Kekalkan jarak biasa dan rapatkan jurang sebaik sahaja kenderaan di hadapan perlahan",
      "Kurangkan jurang sedikit untuk mengelakkan menghalang kenderaan lain di belakang anda",
      "Padankan jarak yang digunakan oleh kenderaan sekeliling dan laraskan jika perlu"
    ],
    "explanation_ms": "Mengekalkan jarak tambahan dan garis penglihatan yang jelas membantu menguruskan pergerakan mengejut di kawasan operasi berkongsi."
  },
  "my_int_029": {
    "text_ms": "Anda bergerak dari jalan dalaman ke arah kawasan pemuatan. Pejalan kaki, kenderaan diletakkan, dan peralatan mewujudkan halangan separa, dan corak pergerakan berubah dengan cepat. Apa yang perlu anda lakukan?",
    "options_ms": [
      "Perlahan awal dan laraskan laluan anda berdasarkan kemungkinan pergerakan di sekeliling anda",
      "Teruskan pada rentak yang stabil dan bertindak balas sebaik sahaja bahaya yang jelas muncul",
      "Fokus pada laluan serta-merta di hadapan dan nilai semula selepas memasuki kawasan itu",
      "Ikut laluan yang diambil oleh kenderaan di hadapan yang kelihatan lalu dengan lancar"
    ],
    "explanation_ms": "Jangkaan awal dan pelarasan spatial mengurangkan keperluan untuk tindak balas mengejut di kawasan aktiviti bercampur."
  },
  "my_int_030": {
    "text_ms": "Anda menghampiri simpang di dalam tapak perindustrian di mana lorong trafik dalaman bersilang. Peraturan tapak memerlukan kenderaan memberi laluan di simpang, tetapi sesetengah pemandu bergerak melaluinya apabila ruang muncul. Apakah tindakan yang betul?",
    "options_ms": [
      "Perlahan dan ikut peraturan simpang tapak sebelum memasuki persimpangan",
      "Maju perlahan-lahan dengan berhati-hati dan teruskan sebaik sahaja laluan segera kelihatan jelas",
      "Bergerak ke simpang untuk memberi isyarat niat anda kepada pemandu lain",
      "Masuk ke simpang jika kenderaan berdekatan kelihatan bergerak melaluinya dengan selamat"
    ],
    "explanation_ms": "Menggunakan pertimbangan simpang bersama dengan peraturan tapak membantu mencegah konflik di persimpangan dalaman."
  },
  "my_int_031": {
    "text_ms": "Di dalam limbungan tapak, anda perlu bergabung ke lorong dalaman sementara peralatan mudah alih beroperasi berhampiran. Ruang terbuka sekejap-sekejap apabila kenderaan dan peralatan mengubah kedudukan. Apakah tindakan terbaik?",
    "options_ms": [
      "Tunggu ruang yang jelas yang mengekalkan jarak selamat dari peralatan berdekatan",
      "Gabung dengan lancar apabila ruang kecil muncul untuk mengekalkan aliran trafik",
      "Bergerak ke hadapan secara beransur-ansur untuk mendapatkan ruang sebelum peralatan bergerak lebih dekat",
      "Ikut kenderaan di hadapan ke dalam lorong jika ia kelihatan bergabung dengan selamat"
    ],
    "explanation_ms": "Pertimbangan ruang yang tepat digabungkan dengan pelepasan peralatan mengurangkan risiko semasa penggabungan peringkat tapak."
  },
  "my_int_032": {
    "text_ms": "Anda menghampiri jalan akses perindustrian dengan permukaan tidak rata dan halangan struktur berhampiran jalan. Jarak penglihatan berkurangan, dan trafik tapak bergerak sekejap-sekejap di sekitar kawasan itu. Apakah tindakan paling selamat?",
    "options_ms": [
      "Kurangkan kelajuan awal dan laraskan laluan anda untuk mengambil kira bahaya permukaan dan struktur",
      "Kekalkan rentak berhati-hati dan bertindak balas jika keadaan jalan bertambah buruk di hadapan",
      "Teruskan dengan stabil sambil mengekalkan fokus pada laluan akses utama",
      "Ikut kenderaan di hadapan jika ia kelihatan menavigasi kawasan itu dengan lancar"
    ],
    "explanation_ms": "Pelarasan awal terhadap risiko persekitaran dan struktur membantu mencegah kehilangan kawalan secara tiba-tiba di kawasan akses yang kompleks."
  },
  "my_int_033": {
    "text_ms": "Di dalam limbungan tapak, seorang marsyal memberi isyarat kepada anda untuk menahan kedudukan sementara kenderaan berdekatan mengubah kedudukan. Pemandu lain memberi isyarat dan melaraskan kedudukan mereka semasa kawasan itu bersih. Apa yang perlu anda lakukan?",
    "options_ms": [
      "Tahan kedudukan seperti yang diarahkan dan teruskan memantau cermin dan titik buta",
      "Beri isyarat niat anda dan maju sedikit ke hadapan untuk bersedia bergerak",
      "Laraskan kedudukan anda secara beransur-ansur sambil memerhatikan marsyal",
      "Ikut pergerakan kenderaan berdekatan sebaik sahaja mereka mula meneruskan"
    ],
    "explanation_ms": "Menghormati arahan pihak berkuasa tapak sambil mengekalkan kesedaran situasi menyokong pergerakan selamat di limbungan terkawal."
  },
  "my_int_034": {
    "text_ms": "Di dalam limbungan tapak, peralatan mudah alih beroperasi berhampiran laluan anda. Kenderaan lain memotong laluan anda, menyebabkan kelewatan ringkas sementara peralatan terus bergerak berhampiran. Apakah cara terbaik untuk bertindak balas?",
    "options_ms": [
      "Perlahan, kekalkan jarak dari peralatan, dan teruskan tanpa bertindak balas",
      "Laraskan kedudukan anda untuk mendapatkan semula kemajuan sambil memantau peralatan",
      "Teruskan dengan stabil dan fokus pada membersihkan kawasan itu secepat mungkin",
      "Ikut kenderaan di hadapan dengan rapat untuk mengelakkan kelewatan lanjut dalam situasi ini"
    ],
    "explanation_ms": "Mengekalkan ketenangan dan jarak di sekeliling peralatan operasi membantu mencegah peningkatan dan risiko sekunder."
  },
  "my_int_035": {
    "text_ms": "Anda menghampiri titik akses sempit di dalam kemudahan. Jarak penglihatan terhad, dan kenderaan lain mungkin masuk dari arah bertentangan tanpa amaran. Apakah tindakan yang betul?",
    "options_ms": [
      "Perlahan awal dan tunggu sehingga laluan akses jelas tersedia",
      "Teruskan ke hadapan dengan berhati-hati dan laraskan jika kenderaan lain muncul",
      "Masuk ke titik akses untuk menahan kedudukan anda sebelum orang lain tiba",
      "Ikut kenderaan di hadapan sebaik sahaja ia mula bergerak melalui akses"
    ],
    "explanation_ms": "Jangkaan awal dan kemasukan terkawal mengurangkan risiko di kawasan akses terhad."
  },
  "my_int_036": {
    "text_ms": "Anda menghampiri pintu keluar tapak yang sibuk yang menyertai jalan awam. Ruang adalah sempit, dan anda mungkin perlu mengundur sedikit untuk meluruskan semula sebelum memasuki lalu lintas. Apakah tindakan terbaik?",
    "options_ms": [
      "Maju ke hadapan untuk mendapatkan kedudukan, kemudian laraskan jika perlu",
      "Berhenti, nilai, dan undur perlahan-lahan di bawah kawalan jika perlu",
      "Gunakan hon dan terus bergerak untuk mengelakkan kelewatan",
      "Undur dengan cepat sebelum kenderaan tiba untuk menjimatkan masa"
    ],
    "explanation_ms": "Mengekalkan kawalan penuh sebelum manuver mengurangkan risiko di titik konflik simpang."
  },
  "my_int_037": {
    "text_ms": "Di pusat pemeriksaan keselamatan, kenderaan di hadapan masih sedang dibersihkan. Pengawal memberi isyarat kepada anda untuk bergerak lebih dekat. Apa yang perlu anda lakukan?",
    "options_ms": [
      "Rapatkan jurang untuk mempercepatkan pelepasan",
      "Kekalkan jarak ikut yang selamat",
      "Berhenti terus di belakang kenderaan untuk menunjukkan kerjasama",
      "Bergerak perlahan-lahan dan bergantung pada pengawal untuk menguruskan jarak"
    ],
    "explanation_ms": "Prosedur pusat pemeriksaan tidak mengatasi disiplin jarak asas."
  },
  "my_int_038": {
    "text_ms": "Anda sedang memandu di dalam terminal kontena di mana RTG dan penumpuk jangkau beroperasi berhampiran. Penglihatan sebahagiannya terhalang oleh kontena. Apa yang perlu anda lakukan?",
    "options_ms": [
      "Kurangkan kelajuan awal dan teruskan dengan berhati-hati melalui kawasan itu",
      "Kekalkan kelajuan biasa dan bergantung pada pengendali peralatan untuk memberi laluan",
      "Pecut sebentar untuk membersihkan zon dengan cepat",
      "Padankan kelajuan kenderaan terminal berdekatan"
    ],
    "explanation_ms": "Pengurangan kelajuan berhampiran peralatan terminal aktif menyokong interaksi selamat di zon operasi berkongsi."
  },
  "my_int_039": {
    "text_ms": "Anda menghampiri kawasan di mana kontena sedang diangkat dan diletakkan semula. Pergerakan peralatan sedang berjalan, dan laluan mengangkat mungkin berubah. Apakah tindakan yang betul?",
    "options_ms": [
      "Berhenti di luar zon mengangkat sehingga operasi jelas selesai",
      "Teruskan perlahan-lahan sambil memantau aktiviti mengangkat",
      "Teruskan bergerak dan laraskan jika peralatan datang lebih dekat",
      "Ikut kenderaan lain yang telah memasuki zon"
    ],
    "explanation_ms": "Menjangkakan bahaya mengangkat memerlukan pemisahan yang jelas daripada zon mengangkat aktif."
  },
  "my_int_040": {
    "text_ms": "Anda sedang bersedia untuk meletak kenderaan dan menggunakan kaki pendaratan treler di kawasan tapak (sama ada di premis pelanggan atau limbungan sendiri). Permukaan tanah kelihatan tidak rata dan baru diganggu oleh peralatan berat. Apakah tindakan paling selamat?",
    "options_ms": [
      "Berhenti dan nilai kestabilan tanah sebelum menggunakan kaki pendaratan",
      "Gunakan kaki pendaratan perlahan-lahan dan pantau sebarang tenggelam",
      "Teruskan seperti biasa kerana kawasan itu biasa digunakan untuk meletak kenderaan",
      "Bergantung pada pemeriksaan visual sahaja dan laraskan jika pergerakan dikesan"
    ],
    "explanation_ms": "Mengenali keadaan tanah berisiko tinggi memerlukan penilaian sebelum meletakkan berat pada kaki pendaratan."
  },
  "my_int_041": {
    "text_ms": "Anda sedang beratur untuk memasang kontena ke treler anda. Kenderaan di hadapan masih melengkapkan penjajaran, dan kawasan itu sesak. Apa yang perlu anda lakukan?",
    "options_ms": [
      "Kekalkan jarak dan tunggu sehingga kawasan pemasangan jelas sepenuhnya",
      "Bergerak lebih dekat untuk bersedia sebaik sahaja kenderaan di hadapan selesai",
      "Rapatkan jurang perlahan-lahan untuk mengurangkan masa menunggu",
      "Ikut isyarat kakitangan darat untuk menghampiri sedekat mungkin"
    ],
    "explanation_ms": "Mengekalkan jarak menyokong operasi pemasangan kontena yang selamat dan tepat."
  }
};

const updatedQuestions = questions.map(q => {
  if (translations[q.id]) {
    return {
      ...q,
      ...translations[q.id]
    };
  }
  return q;
});

fs.writeFileSync(questionsPath, JSON.stringify(updatedQuestions, null, 2));
console.log('Translations updated successfully');
