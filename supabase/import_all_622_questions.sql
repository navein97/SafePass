-- SafePass Full Questions Migration
-- Contains all 622 questions for Box Van, Container Haulage, and General Cargo across Batches 1 to 8

ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS driver_categories TEXT[];
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS reference_number INTEGER;

-- Delete old incomplete questions to replace with full clean dataset:
DELETE FROM public.questions;

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9dda22e2-f3d6-4789-9000-c2e9a83eb083',
    0,
    'While driving at the posted speed, you see motorcycles filtering between lanes and uneven braking ahead.',
    'Anda memandu pada kelajuan dibenarkan. Motosikal bergerak di antara lorong dan brek tidak sekata berlaku di hadapan.',
    '["Maintain speed and brake if traffic slows suddenly", "Reduce speed early and increase following distance", "Change lanes to avoid slower traffic ahead", "Maintain speed and focus on the vehicle ahead"]',
    '["Kekalkan kelajuan dan brek jika trafik perlahan secara tiba-tiba", "Kurangkan kelajuan lebih awal dan tambah jarak kenderaan", "Tukar lorong untuk mengelakkan trafik perlahan", "Kekalkan kelajuan dan fokus pada kenderaan di hadapan"]',
    1,
    'Reduce speed early to create time and space for sudden road changes.',
    'Kurangkan kelajuan lebih awal untuk memberi masa dan ruang apabila keadaan jalan berubah.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '593a67ce-c1de-442f-92d5-3227bc422765',
    0,
    'You merge from a slip road onto a busy highway. Vehicles ahead brake unevenly and motorcycles pass between lanes.',
    'Anda memasuki lebuh raya dari laluan masuk. Kenderaan di hadapan membrek tidak sekata dan motosikal bergerak di antara lorong.',
    '["Wait for a clearly safe gap before merging", "Merge and adjust speed once on the highway", "Use the gap quickly before traffic closes", "Move forward to signal intent and merge when traffic slows"]',
    '["Tunggu jarak/ruang yang benar-benar selamat sebelum masuk", "Masuk dahulu dan ubah kelajuan di lebuh raya", "Gunakan ruang dengan cepat sebelum trafik menjadi padat/sesak", "Bergerak ke hadapan untuk beri isyarat niat dan masuk apabila trafik perlahan"]',
    0,
    'Choose a safe gap to avoid sudden braking and conflict during merging.',
    'Pilih jarak yang selamat untuk mengelakkan brek mengejut dan konflik semasa masuk ke lebuh raya.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '07ddd949-e317-4f88-a7af-dd5c68b9c089',
    0,
    'You need to reverse into a marked bay inside a site. Space is tight, visibility is limited, and vehicles move nearby.',
    'Anda perlu mengundur ke petak bertanda di dalam tapak. Ruang sempit, pandangan terhad, dan kenderaan bergerak berhampiran.',
    '["Stop and reverse only when visibility and clearance are confirmed", "Reverse slowly while checking mirrors and adjusting position", "Continue reversing to avoid delaying vehicles behind", "Reverse carefully and rely on others to keep clear"]',
    '["Berhenti dan undur hanya apabila pandangan dan ruang selamat dipastikan", "Undur perlahan sambil periksa cermin dan sesuaikan kedudukan", "Terus undur untuk elakkan melambatkan kenderaan di belakang", "Undur dengan berhati-hati dan harap orang lain menjauh"]',
    0,
    'Confirm visibility and clearance before reversing in confined areas.',
    'Pastikan pandangan dan ruang selamat sebelum mengundur di kawasan sempit.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6943ccd3-dafd-4369-a877-eecb59dea78f',
    0,
    'Inside a site yard, a marshal instructs you to hold while vehicles reposition nearby.',
    'Di kawasan tapak, seorang marshal mengarahkan anda supaya berhenti sementara kenderaan berhampiran sedang mengubah kedudukan.',
    '["Hold position and continue checking mirrors and blind spots", "Signal and edge forward slightly to prepare to move", "Adjust position gradually while watching the marshal", "Follow nearby vehicles once they begin moving"]',
    '["Kekal berhenti dan terus periksa cermin serta titik buta", "Beri isyarat dan bergerak sedikit ke hadapan sebagai persediaan bergerak", "Sesuaikan kedudukan secara beransur sambil memerhati marshal", "Ikut pergerakan kenderaan berhampiran apabila ia mula bergerak"]',
    0,
    'Follow marshal instructions while maintaining situational awareness.',
    'Patuhi arahan marshal sambil kekalkan kesedaran persekitaran.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '349c82f8-5dab-4cee-913e-e06679522406',
    0,
    'At a checkpoint, you are asked to present documents and notice the delivery time was recorded inaccurately.',
    'Di tempat pemeriksaan, anda diminta menunjukkan dokumen dan menyedari masa penghantaran direkod tidak tepat.',
    '["Present the document and clarify the timing if asked", "Hand over the document without mentioning the timing", "Explain verbally that the details are correct", "Ask for time to update the document before presenting it"]',
    '["Serahkan dokumen dan jelaskan masa jika ditanya", "Serahkan dokumen tanpa menyebut tentang masa", "Jelaskan secara lisan bahawa butiran adalah betul", "Minta masa untuk mengemas kini dokumen sebelum menyerahkannya"]',
    0,
    'Accurate documents and cooperation support smooth inspections.',
    'Dokumen yang tepat dan kerjasama membantu pemeriksaan berjalan lancar.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'eca4cf6b-9ee0-433c-ab7f-d025bfbb985b',
    0,
    'While driving, the engine feels strained during acceleration though no warning lights appear.',
    'Semasa memandu, enjin terasa kurang responsive semasa memecut walaupun tiada lampu amaran menyala.',
    '["Ease acceleration and monitor the condition", "Maintain normal acceleration since no lights show", "Increase engine output to test the response", "Continue driving and act only if it worsens"]',
    '["Kurangkan pecutan dan pantau keadaan", "Kekalkan pecutan kerana tiada lampu amaran", "Tingkatkan kuasa enjin untuk menguji tindak balas", "Terus memandu dan bertindak hanya jika keadaan bertambah teruk"]',
    0,
    'Respond early to unusual vehicle performance.',
    'Bertindak awal apabila prestasi kenderaan tidak biasa.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '614bb08d-e93f-4194-b757-6a3573941e11',
    0,
    'During pre-trip inspection, you discover a brake defect before departure.',
    'Semasa pemeriksaan pra-perjalanan, anda menemui masalah pada brek sebelum berlepas.',
    '["Proceed carefully and monitor the defect during the journey", "Delay reporting until after completing the delivery", "Report the defect immediately and follow required procedures", "Ignore the defect to avoid operational delays"]',
    '["Teruskan dengan berhati-hati dan pantau masalah sepanjang perjalanan", "Tangguhkan laporan sehingga penghantaran selesai", "Laporkan masalah segera dan ikut prosedur yang ditetapkan", "Abaikan masalah untuk elakkan kelewatan operasi"]',
    2,
    'Defects must be reported before departure to ensure safety and integrity.',
    'Masalah mesti dilaporkan sebelum berlepas untuk memastikan keselamatan dan integriti.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e98575db-5bbd-4e4b-aca8-594b676aabae',
    0,
    'While waiting in an active loading zone, you notice cargo movement that may affect load stability.',
    'Semasa menunggu di zon pemuatan aktif, anda melihat pergerakan muatan yang boleh menjejaskan kestabilan muatan.',
    '["Remain in position and allow loading to continue", "Stop the process and alert site staff to address the cargo risk", "Move the vehicle slightly to reduce exposure", "Monitor the situation and proceed once loading appears stable"]',
    '["Kekal di tempat dan biarkan proses pemuatan diteruskan", "Hentikan proses dan maklumkan kakitangan tapak tentang risiko muatan", "Gerakkan kenderaan sedikit untuk mengurangkan pendedahan", "Pantau keadaan dan teruskan apabila pemuatan kelihatan stabil"]',
    1,
    'Address cargo instability promptly to prevent incidents in loading areas.',
    'Tangani ketidakstabilan muatan dengan segera untuk mengelakkan insiden di kawasan pemuatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '336ac730-508f-4fde-a4ce-a3cd733df20d',
    0,
    'A customer questions a delivery delay and speaks to you in a frustrated tone.',
    'Seorang pelanggan mempersoalkan kelewatan penghantaran dan bercakap dengan nada tidak puas hati.',
    '["Respond briefly and focus on completing the delivery", "Explain the situation calmly and confirm the next steps", "Defend your actions and point out factors beyond your control", "Avoid discussion and direct the customer to the office"]',
    '["Jawab secara ringkas dan fokus untuk selesaikan penghantaran", "Terangkan keadaan dengan tenang dan sahkan langkah seterusnya", "Pertahankan tindakan anda dan jelaskan faktor di luar kawalan", "Elakkan perbincangan dan arahkan pelanggan ke pejabat"]',
    1,
    'Calm, clear explanation helps reduce frustration and keeps the interaction professional.',
    'Penjelasan yang tenang dan jelas membantu kurangkan ketegangan dan kekalkan profesionalisme.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b7878769-4f7f-497a-8a77-cc095492a337',
    0,
    'A colleague suggests you keep quiet about a major issue to avoid attention from management.',
    'Seorang rakan sekerja mencadangkan supaya anda berdiam diri tentang satu isu besar untuk elakkan perhatian pihak pengurusan.',
    '["Explain clearly why the issue should be reported", "Agree to stay quiet to keep things smooth", "Avoid responding and let the matter pass", "Say little and continue with your work"]',
    '["Jelaskan dengan terang mengapa isu itu perlu dilaporkan", "Setuju untuk berdiam diri supaya keadaan kekal tenang", "Elakkan memberi respons dan biarkan perkara itu berlalu", "Kurangkan bercakap dan teruskan kerja anda"]',
    0,
    'Clear communication and honesty help prevent larger problems later.',
    'Komunikasi yang jelas dan jujur membantu elakkan masalah menjadi lebih besar.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a471d699-c5f4-4aa9-8bbc-befa30737cd4',
    0,
    'While parked in a public area, a bystander hints that a small payment could allow special access.',
    'Semasa parkir di kawasan awam, seorang individu menyatakan bahawa bayaran kecil boleh membolehkan akses khas.',
    '["Decline politely and continue following normal procedures", "Consider the request since it may avoid inconvenience to others", "Delay responding and see if the situation resolves itself", "Suggest discussing the matter later to keep things moving"]',
    '["Tolak dengan sopan dan ikut prosedur biasa", "Pertimbangkan permintaan itu kerana mungkin elakkan kesulitan", "Tangguhkan respons dan lihat perkembangan keadaan", "Cadangkan bincang perkara itu kemudian supaya urusan dapat diteruskan"]',
    0,
    'Refusing improper offers protects integrity and maintains public trust.',
    'Menolak tawaran yang tidak sesuai membantu kekalkan integriti dan kepercayaan orang awam.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0c071d7f-27a7-4119-a5a1-3e4d16007c79',
    0,
    'During a delivery, a culturally sensitive interaction is happening while people nearby are watching or recording.',
    'Semasa penghantaran, berlaku interaksi sensitif berkaitan budaya dan orang sekeliling sedang melihat dan merakam.',
    '["Maintain respectful behaviour and continue professionally", "Explain your actions carefully so others do not misinterpret them", "Limit the interaction to avoid drawing further attention", "Adjust your response to match how others expect you to behave"]',
    '["Kekalkan tingkah laku yang hormat dan teruskan secara profesional", "Terangkan tindakan anda dengan teliti supaya tidak disalah tafsir", "Hadkan interaksi untuk elak menarik lebih perhatian", "Ubah respons anda mengikut jangkaan orang sekeliling"]',
    0,
    'Maintaining respectful, professional behaviour protects your image during visible interactions.',
    'Sikap hormat dan profesional membantu melindungi imej anda apabila situasi diperhatikan orang lain.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2baf0566-45dd-406d-8e72-40663539a630',
    0,
    'Traffic ahead is moving, but you keep extra distance. A customer messages asking why progress feels slow.',
    'Trafik di hadapan bergerak, namun anda mengekalkan jarak yang lebih selamat. Pelanggan menghantar mesej bertanya mengapa pergerakan agak lambat.',
    '["Maintain safe following distance and explain the situation calmly", "Close the gap slightly so movement appears faster", "Reassure the customer and focus on keeping pace", "Ignore the message and continue driving"]',
    '["Kekalkan jarak selamat dan jelaskan keadaan dengan tenang", "Rapatkan sedikit jarak supaya pergerakan nampak lebih cepat", "Yakinkan pelanggan dan cuba kekalkan kelajuan trafik", "Abaikan mesej dan teruskan pemanduan"]',
    0,
    'Keeping a safe following distance while explaining the reason supports safety and customer confidence.',
    'Mengekalkan jarak selamat sambil memberi penjelasan membantu menjaga keselamatan dan keyakinan pelanggan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3d19899e-81a6-45c1-817e-9de458297889',
    0,
    'You slow early after spotting a hazard ahead. The driver behind reacts angrily and closes in.',
    'Anda memperlahankan kenderaan lebih awal selepas melihat bahaya di hadapan. Pemandu di belakang bertindak marah dan merapat.',
    '["Keep your speed steady and avoid engaging", "Speed up slightly to reduce pressure from behind", "Brake again to show there is a hazard ahead", "Gesture briefly to discourage the tailgating"]',
    '["Kekalkan kelajuan yang stabil dan elakkan memberi respons", "Tambah sedikit kelajuan untuk mengurangkan tekanan dari belakang", "Tekan brek sekali lagi untuk menunjukkan terdapat bahaya di hadapan", "Buat isyarat ringkas untuk menghalang tingkah laku tersebut"]',
    0,
    'Maintaining steady driving and avoiding engagement helps manage hazards without escalating conflict.',
    'Mengekalkan pemanduan yang stabil dan tidak bertindak balas membantu mengurus risiko tanpa menambahkan ketegangan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '047bb08f-aafe-4048-8eb3-bc07831cc6d1',
    0,
    'You have worked six consecutive days and are scheduled for another duty.',
    'Anda telah bekerja selama enam hari berturut-turut dan dijadualkan untuk bertugas lagi.',
    '["Continue working if you feel fit.", "Take one rest day after six working days.", "Work half a day before taking leave.", "Swap shifts without taking a rest day."]',
    '["Terus bekerja jika anda berasa cergas.", "Ambil satu hari rehat selepas enam hari bekerja.", "Bekerja separuh hari sebelum mengambil cuti.", "Tukar syif tanpa mengambil hari rehat."]',
    1,
    'Take the required rest day after six consecutive working days.',
    'Ambil hari rehat yang ditetapkan selepas enam hari bekerja berturut-turut.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3a61bee5-bb52-4dc1-98c1-41afd7174dbd',
    0,
    'Before starting your shift, you notice dark tint film and stickers on part of the windscreen.',
    'Sebelum memulakan syif, anda mendapati terdapat filem gelap dan pelekat pada sebahagian cermin hadapan.',
    '["Leave them since they were already installed.", "Remove or report them because they may obstruct visibility.", "Start driving and adjust your seating position instead.", "Ignore them as long as the road ahead is visible."]',
    '["Biarkan kerana ia telah dipasang sebelum ini.", "Tanggalkan atau laporkan kerana ia boleh menghalang penglihatan.", "Mulakan pemanduan dan laraskan kedudukan tempat duduk.", "Abaikan selagi jalan di hadapan masih kelihatan."]',
    1,
    'Address unauthorised modifications to protect visibility and vehicle safety.',
    'Tangani pengubahsuaian tanpa kelulusan untuk menjaga penglihatan dan keselamatan kenderaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '70a81e5c-c99d-48ac-98f8-ed57d86d15f2',
    0,
    'A colleague asks to ride in your cabin as a second driver for convenience.',
    'Seorang rakan sekerja meminta untuk menaiki kabin anda sebagai pemandu kedua atas alasan kemudahan.',
    '["Allow the ride if the journey is short.", "Decline unless company authorisation is given.", "Allow the ride if the colleague is an employee.", "Permit the ride if no customers are affected."]',
    '["Benarkan jika perjalanan adalah singkat.", "Tolak kecuali terdapat kebenaran daripada syarikat.", "Benarkan jika rakan tersebut ialah pekerja syarikat.", "Benarkan jika tiada pelanggan yang terjejas."]',
    1,
    'Do not carry passengers without proper company authorisation.',
    'Jangan membawa penumpang tanpa kebenaran rasmi daripada syarikat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '20c957c8-8d2d-4e9d-af2e-82e0ef354070',
    0,
    'You notice only three safety cones are available in the vehicle.',
    'Anda mendapati hanya tiga kon keselamatan tersedia di dalam kenderaan.',
    '["Proceed since cones are rarely used.", "Ensure five compliant safety cones are available.", "Carry additional cones only for highway trips.", "Proceed since 3 cones is enough."]',
    '["Teruskan perjalanan kerana kon jarang digunakan.", "Pastikan lima kon keselamatan yang mematuhi spesifikasi tersedia.", "Bawa kon tambahan hanya untuk perjalanan di lebuh raya.", "Teruskan kerana 3 kon sudah mencukupi."]',
    1,
    'Ensure the required number of compliant safety cones is carried.',
    'Pastikan bilangan kon keselamatan yang mematuhi spesifikasi dibawa seperti yang ditetapkan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '536f0762-5479-42e9-9250-08223048fdb8',
    0,
    'You are verifying the vehicle before loading cargo.',
    'Anda sedang mengesahkan keadaan kenderaan sebelum memuatkan kargo.',
    '["Confirm the permitted load limit before loading.", "Load first and check weight later.", "Estimate weight based on experience.", "Accept the customer''s estimate without verification."]',
    '["Sahkan had muatan yang dibenarkan sebelum memuatkan kargo.", "Muatkan terlebih dahulu dan periksa berat kemudian.", "Anggarkan berat berdasarkan pengalaman.", "Terima anggaran pelanggan tanpa pengesahan."]',
    0,
    'Confirm the permitted load limit before carrying cargo.',
    'Sahkan had muatan yang dibenarkan sebelum membawa kargo.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '875e2291-b3f5-40ad-9a7a-d74523a69ef0',
    0,
    'You are preparing for duty.',
    'Anda sedang membuat persediaan untuk bertugas.',
    '["Wear a collared shirt before reporting for duty.", "Wear any casual T-shirt as long as it is clean.", "Wear a sleeveless shirt in hot weather.", "Change only if instructed by a supervisor."]',
    '["Pakai baju berkolar sebelum melapor diri untuk bertugas.", "Pakai mana-mana baju T kasual asalkan bersih.", "Pakai baju tanpa lengan ketika cuaca panas.", "Tukar pakaian hanya jika diarahkan oleh penyelia."]',
    0,
    'Wear proper collared attire as required for duty.',
    'Pakai pakaian berkolar yang sesuai seperti yang ditetapkan semasa bertugas.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '955d3396-479e-434f-88db-750d00dabab9',
    0,
    'After completing your task, you still have the prime mover key.',
    'Selepas menamatkan tugasan, anda masih memegang kunci kepala lori.',
    '["Take the key home for the next shift.", "Return the key to the company as required.", "Leave the key inside the vehicle.", "Keep the key until requested."]',
    '["Bawa pulang kunci untuk syif seterusnya.", "Pulangkan kunci kepada syarikat seperti yang ditetapkan.", "Tinggalkan kunci di dalam kenderaan.", "Simpan kunci sehingga diminta."]',
    1,
    'Return vehicle keys to the company after duty.',
    'Pulangkan kunci kenderaan kepada syarikat selepas bertugas.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4c3fd9c2-282e-4400-a861-d561dc913f57',
    0,
    'After a road collision, what should you record first?',
    'Selepas berlaku pelanggaran jalan raya, apakah yang perlu anda catat terlebih dahulu?',
    '["The exact accident location.", "The damages.", "The estimated repair cost.", "The traffic condition."]',
    '["Lokasi kemalangan yang tepat.", "Kerosakan yang berlaku.", "Anggaran kos pembaikan.", "Keadaan trafik."]',
    0,
    'Record the accident location accurately.',
    'Catat lokasi kemalangan dengan tepat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4574ad38-81c3-4d69-ad40-c027d1e8667e',
    0,
    'Your vehicle catches fire during transit.',
    'Kenderaan anda terbakar semasa dalam perjalanan.',
    '["Inform operations or the company safety team immediately.", "Attempt to control the fire fully before reporting.", "Inform the customer first.", "Report only if damage is severe."]',
    '["Maklumkan kepada bahagian operasi atau pasukan keselamatan syarikat dengan segera.", "Cuba kawal kebakaran sepenuhnya sebelum melaporkan.", "Maklumkan kepada pelanggan terlebih dahulu.", "Laporkan hanya jika kerosakan adalah serius."]',
    0,
    'Report fire incidents immediately for further instruction.',
    'Laporkan kejadian kebakaran dengan segera untuk arahan lanjut.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c5a418c7-5ca5-46c0-869c-849deb3e7c7f',
    0,
    'During initial reporting, what should you do if additional relevant details arise?',
    'Semasa laporan awal dibuat, apakah yang perlu anda lakukan jika terdapat maklumat tambahan yang berkaitan?',
    '["Share any information that supports the initial report.", "Limit information to basic facts only.", "Provide extra details only if requested later.", "Wait until writing a formal report."]',
    '["Kongsikan maklumat yang menyokong laporan awal.", "Hadkan maklumat kepada fakta asas sahaja.", "Berikan butiran tambahan hanya jika diminta kemudian.", "Tunggu sehingga menyediakan laporan rasmi."]',
    0,
    'Provide all relevant information for the initial response.',
    'Berikan semua maklumat yang berkaitan untuk tindakan awal yang tepat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1ef0068c-1a57-44da-8da6-36df8c5bee2f',
    0,
    'You position your vehicle in a loading area where forklifts are operating.',
    'Anda meletakkan kenderaan di kawasan memuat/memunggah barang di mana forklift sedang beroperasi.',
    '["Move forward quickly and stop near loading", "Stop at a safe distance and proceed when clear", "Continue moving and rely on forklift guidance", "Park as close as possible despite limited space"]',
    '["Bergerak cepat ke hadapan dan berhenti berhampiran kawasan memuat/memunggah barang", "Berhenti pada jarak selamat dan bergerak apabila laluan sudah jelas", "Terus bergerak dan bergantung pada panduan forklift", "Parkir sedekat mungkin walaupun ruang terhad"]',
    1,
    'Keep a safe distance from active loading zones to reduce collision risk.',
    'Kekalkan jarak selamat dari kawasan kawasan pemuatan aktif untuk mengurangkan risiko pelanggaran.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '182c3299-3472-436d-888d-2fa26ed3e14a',
    0,
    'You approach a busy junction. Traffic slows and visibility is partly blocked by surrounding vehicles.',
    'Anda menghampiri persimpangan yang sibuk. Trafik perlahan dan sebahagian pandangan terhalang oleh kenderaan sekeliling.',
    '["Reduce speed early and prepare to stop", "Maintain speed and brake only if needed", "Slow slightly and move when the vehicle ahead moves", "Keep moving to clear the junction quickly"]',
    '["Kurangkan kelajuan lebih awal dan bersedia untuk berhenti", "Kekalkan kelajuan dan brek hanya jika perlu", "Perlahankan sedikit dan bergerak apabila kenderaan di hadapan bergerak", "Terus bergerak untuk melepasi persimpangan dengan cepat"]',
    0,
    'Reduce speed before junctions to respond safely to unexpected movement.',
    'Kurangkan kelajuan sebelum persimpangan untuk bertindak balas dengan selamat terhadap pergerakan mengejut.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5afb84b4-307d-48d5-bb41-e3f4180de8cb',
    0,
    'You are on foot near your vehicle in an active loading area. Forklifts operate and stacked goods restrict visibility.',
    'Anda berjalan berhampiran kenderaan di kawasan pemunggahan aktif. Forklift beroperasi dan susunan barangan menghadkan pandangan.',
    '["Keep clear of loading paths and wait until movement settles", "Move closer to observe equipment movement", "Walk through quickly to minimise time in the area", "Stand where operators can see you and keep moving"]',
    '["Kekal jauh dari laluan pemunggahan dan tunggu sehingga pergerakan reda", "Bergerak lebih dekat untuk memerhati pergerakan jentera", "Berjalan cepat untuk kurangkan masa di kawasan itu", "Berdiri di tempat pengendali boleh nampak dan terus bergerak"]',
    0,
    'Keep clear of loading activity to avoid sudden equipment movement and blind spots.',
    'Kekalkan jarak dari aktiviti pemunggahan untuk elakkan pergerakan jentera mengejut dan kawasan titik buta.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bd6dd8a5-38a5-4c7b-be55-045f404ac221',
    0,
    'You drive inside an industrial site where equipment operates near the roadway.',
    'Anda memandu di dalam kawasan industri di mana jentera beroperasi berhampiran laluan.',
    '["Reduce speed early and keep extra clearance from equipment", "Maintain pace and adjust if equipment enters your path", "Continue slowly to pass before equipment repositions", "Follow the vehicle ahead past the equipment"]',
    '["Kurangkan kelajuan lebih awal dan kekalkan jarak daripada jentera", "Kekalkan kelajuan dan sesuaikan jika jentera memasuki laluan anda", "Terus bergerak perlahan untuk melepasi sebelum jentera beralih", "Ikut kenderaan di hadapan melepasi jentera"]',
    0,
    'Reduce speed early and keep clear of operating equipment.',
    'Kurangkan kelajuan lebih awal dan kekalkan jarak dari jentera beroperasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7cc11fc3-1034-4770-93bf-c447581cd72a',
    0,
    'Inside a site yard, equipment operates near your path when another vehicle cuts across.',
    'Di kawasan tapak, jentera beroperasi berhampiran laluan anda dan tiba-tiba sebuah kenderaan melintas di hadapan.',
    '["Slow down, keep distance from equipment, and continue calmly", "Adjust position to regain progress while watching equipment", "Proceed steadily to clear the area quickly", "Follow the vehicle ahead closely to avoid delay"]',
    '["Perlahankan, kekalkan jarak dari jentera, dan teruskan dengan tenang", "Laraskan kedudukan untuk meneruskan pergerakan sambil memerhati jentera", "Terus bergerak untuk melepasi kawasan itu dengan cepat", "Ikut kenderaan di hadapan dengan rapat untuk elakkan kelewatan"]',
    0,
    'Maintain composure and distance near operating equipment.',
    'Kekalkan ketenangan dan jarak selamat berhampiran jentera beroperasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0087bd5a-4b65-4043-a3b2-71b43f5814d5',
    0,
    'Before starting duty, you have not completed the required rest and are still under medication.',
    'Sebelum memulakan tugas, anda belum mendapat rehat yang cukup dan masih di bawah kesan ubat.',
    '["Delay starting duty and report the issue", "Start the trip carefully since the route is familiar", "Begin driving and stop later if you feel affected", "Proceed and take rest after your shift"]',
    '["Tangguhkan tugas dan laporkan keadaan tersebut", "Mulakan perjalanan dengan berhati-hati kerana laluan sudah biasa", "Mula memandu dan berhenti kemudian jika terasa terjejas", "Teruskan dan ambil rehat selepas tamat syif"]',
    0,
    'Confirm fitness for duty before driving.',
    'Pastikan kecergasan untuk bertugas sebelum memandu.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9b1a5bb5-eec0-4d06-b3e2-21895efb7c0e',
    0,
    'At a site entrance, valid driving credentials are required. One required credential has expired.',
    'Di pintu masuk tapak, kelayakan memandu yang sah diperlukan. Satu kelayakan telah tamat tempoh.',
    '["Stop the entry process and report the issue", "Complete the safety induction and resolve it later", "Proceed since rules will be explained during induction", "Wait to see if access is granted"]',
    '["Hentikan proses masuk dan laporkan masalah tersebut", "Selesaikan taklimat keselamatan dan uruskan kemudian", "Teruskan masuk kerana peraturan akan diterangkan semasa taklimat", "Tunggu untuk melihat sama ada akses dibenarkan"]',
    0,
    'Valid credentials are required before site entry.',
    'Kelayakan yang sah diperlukan sebelum memasuki tapak.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '340d4ea4-1a3c-4eac-a1f1-820aaa2beaf1',
    0,
    'After loading at a site, procedure requires using a designated exit route.',
    'Selepas selesai memunggah keluar di tapak, prosedur memerlukan anda menggunakan laluan keluar yang ditetapkan.',
    '["Follow the designated exit route and site rules", "Take a shorter route since no traffic is visible", "Adjust your exit path to save time", "Exit based on familiarity rather than instructions"]',
    '["Ikut laluan keluar dan peraturan pergerakan tapak", "Ambil laluan lebih pendek kerana tiada trafik kelihatan", "Laraskan laluan keluar untuk menjimatkan masa", "Keluar berdasarkan kebiasaan dan bukan arahan"]',
    0,
    'Follow site exit routes and movement rules.',
    'Ikut laluan keluar dan peraturan pergerakan tapak.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '551f739b-f53b-4375-8b50-9183168587bb',
    0,
    'While manoeuvring at low speed in a confined space, you notice resistance and a faint scraping sound.',
    'Semasa membuat manuver pada kelajuan rendah di ruang sempit, anda merasakan rintangan dan bunyi geseran ringan.',
    '["Stop and reassess clearance before continuing", "Proceed slowly and rely on steering to clear the space", "Apply more throttle to finish quickly", "Continue and inspect the vehicle after the manoeuvre"]',
    '["Berhenti dan semak semula ruang sebelum meneruskan", "Terus bergerak perlahan dan bergantung pada stereng", "Tekan minyak lebih untuk menyelesaikan manuver dengan cepat", "Teruskan dan periksa kenderaan selepas manuver selesai"]',
    0,
    'Stop when unusual resistance or sounds occur.',
    'Berhenti apabila terdapat rintangan atau bunyi tidak biasa.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '34f979d2-985a-474e-9fa4-ee21b0955761',
    0,
    'During a rest stop, you notice rubbish and food containers inside the truck cabin.',
    'Semasa berhenti rehat, anda melihat sampah dan bekas makanan di dalam kabin lori.',
    '["Leave the cabin unchanged since cleanliness does not affect vehicle operation", "Clean the cabin later when the schedule is less demanding", "Clean and tidy the cabin immediately", "Remove only items that may interfere with driving controls"]',
    '["Biarkan kabin seperti itu kerana kebersihan tidak menjejaskan operasi kenderaan", "Bersihkan kabin kemudian apabila jadual kurang sibuk", "Bersihkan dan kemaskan kabin segera", "Buang hanya barang yang boleh mengganggu kawalan pemanduan"]',
    2,
    'Maintaining cabin cleanliness supports safe operation and professional standards.',
    'Menjaga kebersihan kabin menyokong operasi selamat dan mencerminkan profesionalisme.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5645be71-a031-47c5-9bd6-508fd7e72441',
    0,
    'While reversing slowly in a tight site area, you lose clear sight of one rear corner.',
    'Semasa mengundur perlahan di kawasan tapak yang sempit, anda hilang pandangan jelas pada satu sudut belakang.',
    '["Continue reversing slowly using mirrors", "Stop the vehicle and reassess the situation", "Turn the steering slightly and keep moving", "Rely on previous experience and continue"]',
    '["Terus mengundur perlahan menggunakan cermin", "Berhenti dan nilai semula keadaan", "Pusing stereng sedikit dan terus bergerak", "Bergantung pada pengalaman lalu dan teruskan"]',
    1,
    'Stop when visibility is uncertain to prevent damage and protect people and property.',
    'Berhenti apabila pandangan tidak jelas untuk mengelakkan kerosakan dan melindungi orang serta harta benda.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '907bc734-03cd-4c99-a04d-50b5cfb9ef4b',
    0,
    'During unloading, site staff give instructions abruptly while you are positioning the vehicle.',
    'Semasa memunggah muatan, kakitangan tapak memberi arahan secara tiba-tiba ketika anda sedang memposisikan kenderaan.',
    '["Respond minimally and focus only on vehicle positioning", "Acknowledge the instructions and coordinate calmly", "Challenge the tone and clarify who is responsible", "Proceed without engaging further"]',
    '["Jawab secara minimum dan fokus pada posisi kenderaan sahaja", "Akui arahan tersebut dan bekerjasama dengan tenang", "Persoalkan nada arahan dan jelaskan siapa bertanggungjawab", "Teruskan tanpa melibatkan diri"]',
    1,
    'Calm coordination helps tasks run smoothly, even when instructions are delivered abruptly.',
    'Bekerjasama dengan tenang membantu kerja berjalan lancar walaupun arahan diberi secara tiba-tiba.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '33419e11-92fd-4c89-a204-7b8c9c580bbd',
    0,
    'A disagreement arises on site, and the discussion starts to become tense.',
    'Berlaku perbezaan pendapat di tapak dan perbincangan mula menjadi tegang.',
    '["Speak calmly, acknowledge concerns, and clarify next steps", "Restate your position firmly to end the discussion", "Reduce interaction and wait for the situation to pass", "Continue the task without engaging further"]',
    '["Bercakap dengan tenang dan jelaskan langkah seterusnya", "Tegaskan pendirian anda untuk tamatkan perbincangan", "Kurangkan interaksi dan tunggu keadaan reda", "Teruskan tugas tanpa melibatkan diri"]',
    0,
    'Calm acknowledgement and clear steps help prevent disagreements from escalating.',
    'Pendekatan yang tenang dan langkah yang jelas membantu elakkan keadaan menjadi lebih tegang.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c60bf05d-963e-4541-8c1d-e0e6bbc93000',
    0,
    'In a public area, a bystander becomes upset about where your vehicle is stopped.',
    'Di kawasan awam, seorang individu berasa tidak puas hati tentang lokasi kenderaan anda berhenti.',
    '["Respond calmly, acknowledge the concern, and explain briefly", "Explain in detail why the stop is necessary and allowed", "Avoid engagement and continue the task to prevent escalation", "Justify your position firmly so the complaint does not continue"]',
    '["Beri respons tenang, ambil maklum dan jelaskan secara ringkas", "Terangkan dengan terperinci mengapa berhenti di situ perlu dan dibenarkan", "Elakkan berinteraksi dan teruskan tugas", "Pertahankan posisi anda dengan tegas supaya aduan tidak berlanjutan"]',
    0,
    'Calm acknowledgement helps ease public tension and prevents situations from escalating.',
    'Respons yang tenang dan jelas membantu redakan ketegangan dan elakkan keadaan menjadi lebih serius.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fe84440d-6ac7-4eb3-9b57-03344e554be4',
    0,
    'A customer calls you during the trip and urges you to arrive faster due to a delay.',
    'Seorang pelanggan menelefon semasa perjalanan dan mendesak anda tiba lebih cepat kerana berlaku kelewatan.',
    '["Maintain a safe speed and explain your expected arrival time", "Increase speed slightly to show effort and responsiveness", "Reassure the customer and focus on reaching sooner", "Shorten the conversation and continue driving as planned"]',
    '["Kekalkan kelajuan selamat dan maklumkan anggaran masa ketibaan", "Tambah sedikit kelajuan untuk tunjuk usaha dan responsif", "Yakinkan pelanggan dan cuba sampai lebih awal", "Pendekkan perbualan dan teruskan perjalanan seperti biasa"]',
    0,
    'Maintaining safe speed while giving a clear update supports both safety and customer trust.',
    'Kekalkan kelajuan selamat sambil beri maklumat jelas bagi menjaga keselamatan dan kepercayaan pelanggan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'aa434eef-d4f9-4126-8349-cda208483598',
    0,
    'Traffic ahead slows sharply. You increase following distance while vehicles behind close in without warning.',
    'Trafik di hadapan menjadi perlahan secara mendadak. Anda menambah jarak hadapan sementara kenderaan di belakang semakin menghampiri tanpa amaran.',
    '["Ease off early and activate brake lights to signal slowing", "Maintain speed to avoid confusing drivers behind", "Close the gap to match traffic flow", "Brake later so others are forced to react"]',
    '["Lepaskan pedal awal dan hidupkan lampu brek untuk memberi isyarat memperlahankan kenderaan", "Kekalkan kelajuan supaya tidak mengelirukan pemandu di belakang", "Rapatkan jarak untuk mengikut aliran trafik", "Tekan brek secara mengejut supaya pemandu lain terpaksa bertindak balas"]',
    0,
    'Creating space early and signalling clearly helps others adjust safely to changing traffic conditions.',
    'Mewujudkan ruang lebih awal dan memberi isyarat dengan jelas membantu pemandu lain menyesuaikan diri dengan selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ea1079bf-c3c3-449b-a23f-180e05d744ed',
    0,
    'At a junction, you prepare to turn while another vehicle approaches from the side and appears unsure of your intention.',
    'Di simpang jalan, anda bersedia untuk membelok apabila sebuah kenderaan dari sisi kelihatan tidak pasti tentang niat anda.',
    '["Signal early and complete the turn when it is safe", "Roll forward slightly to indicate you intend to go", "Wait longer to see how the other driver reacts", "Turn once there is space to avoid delaying traffic behind"]',
    '["Beri isyarat awal dan belok apabila selamat", "Gerak sedikit ke hadapan untuk menunjukkan niat", "Tunggu lebih lama untuk melihat reaksi pemandu lain", "Belok apabila ada ruang untuk mengelakkan kelewatan di belakang"]',
    0,
    'Clear signalling at junctions helps other drivers understand your intention and reduces uncertainty.',
    'Isyarat yang jelas di simpang membantu pemandu lain memahami niat anda dan mengurangkan ketidakpastian.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '56d33eb5-61d0-41e8-a979-5cc3f942b508',
    0,
    'While driving, you notice the sun shade and stickers on the windscreen reduce your side visibility.',
    'Semasa memandu, anda mendapati pelindung matahari dan pelekat pada cermin hadapan mengurangkan penglihatan sisi.',
    '["Continue driving carefully despite reduced visibility.", "Stop at a safe location and remove or adjust the obstruction.", "Reduce speed and rely more on mirrors.", "Adjust your lane position to compensate for the blind area."]',
    '["Terus memandu dengan berhati-hati walaupun penglihatan berkurang.", "Berhenti di lokasi selamat dan tanggalkan/laraskan halangan tersebut.", "Kurangkan kelajuan dan lebih bergantung pada cermin sisi.", "Laraskan kedudukan lorong untuk mengimbangi kawasan yang terhalang."]',
    1,
    'Ensure full visibility before continuing to drive safely.',
    'Pastikan penglihatan jelas sepenuhnya sebelum meneruskan pemanduan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'aa4e4be2-48ad-4e4d-b527-636f471464fe',
    0,
    'You are preparing to start your trip and will return later the same day.',
    'Anda sedang bersedia untuk memulakan perjalanan dan akan kembali pada hari yang sama.',
    '["Conduct inspection only before starting the trip.", "Conduct inspection only after completing the trip.", "Conduct inspections both before and after the trip.", "Conduct inspection only if a defect is suspected."]',
    '["Lakukan pemeriksaan sebelum memulakan perjalanan sahaja.", "Lakukan pemeriksaan selepas menamatkan perjalanan sahaja.", "Lakukan pemeriksaan sebelum dan selepas perjalanan.", "Lakukan pemeriksaan hanya jika terdapat tanda kerosakan."]',
    2,
    'Perform required inspections before and after every trip.',
    'Lakukan pemeriksaan yang ditetapkan sebelum dan selepas setiap perjalanan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0e08b80a-f985-496a-b9ca-2b5ba25b1e8e',
    0,
    'The reflective string delineators are damaged and no longer reflective.',
    'Tali delineator reflektif rosak dan tidak lagi memantulkan cahaya.',
    '["Continue if cones are available.", "Replace them with compliant reflective delineators.", "Use hazard lights instead.", "Keep them until the next inspection cycle."]',
    '["Teruskan perjalanan jika kon keselamatan tersedia.", "Gantikan dengan delineator reflektif yang mematuhi spesifikasi.", "Gunakan lampu kecemasan sebagai ganti.", "Kekalkan penggunaannya sehingga pemeriksaan seterusnya."]',
    1,
    'Maintain compliant reflective equipment for roadside safety.',
    'Pastikan peralatan reflektif yang mematuhi spesifikasi sentiasa tersedia untuk keselamatan di tepi jalan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fc75f2a2-1ed0-45d5-b64f-5c443fb36801',
    0,
    'During inspection, you review emergency and fire equipment in the vehicle.',
    'Semasa pemeriksaan, anda menyemak peralatan kecemasan dan pemadam api di dalam kenderaan.',
    '["Check only for long-distance trips.", "Ensure emergency and fire equipment is complete and valid.", "Assume it is sufficient if previously used.", "Check after starting the trip."]',
    '["Periksa hanya untuk perjalanan jarak jauh.", "Pastikan peralatan kecemasan dan pemadam api lengkap dan masih sah untuk digunakan.", "Anggap mencukupi jika pernah digunakan sebelum ini.", "Periksa selepas memulakan perjalanan."]',
    1,
    'Ensure emergency and fire equipment is complete and valid before driving.',
    'Pastikan peralatan kecemasan dan pemadam api lengkap dan masih sah untuk digunakan sebelum memandu.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2521a934-9748-4d23-bc63-d399491675ef',
    0,
    'You are dressing for your driving shift.',
    'Anda sedang berpakaian untuk syif pemanduan.',
    '["Wear long trousers as required.", "Wear shorts if the weather is hot.", "Wear track pants for comfort.", "Wear any trousers only when visiting customer sites."]',
    '["Pakai seluar panjang seperti yang ditetapkan.", "Pakai seluar pendek jika cuaca panas.", "Pakai seluar trek untuk keselesaan.", "Pakai apa-apa seluar hanya apabila melawat tapak pelanggan."]',
    0,
    'Wear long trousers as part of required duty attire.',
    'Pakai seluar panjang seperti yang ditetapkan semasa bertugas.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f20dd724-6034-4288-ad6e-820e71f6b7cb',
    0,
    'As a driver, you must remain aware of the expiry and renewal dates of vehicle and operating documents.',
    'Sebagai seorang pemandu, anda perlu peka terhadap tarikh tamat tempoh dan pembaharuan dokumen kenderaan serta operasi.',
    '["Monitor the dates and arrange renewal before expiry.", "Wait for reminders from the office.", "Check the dates only during inspections.", "Rely on company personnel to identify expiry."]',
    '["Pantau tarikh tersebut dan uruskan pembaharuan sebelum tamat tempoh.", "Tunggu peringatan daripada pejabat.", "Semak tarikh hanya semasa pemeriksaan.", "Bergantung kepada pegawai syarikat untuk mengenal pasti tarikh tamat tempoh."]',
    0,
    'Be aware of expiry dates and renew documents before they lapse.',
    'Sentiasa peka terhadap tarikh tamat tempoh dan perbaharui dokumen sebelum tempoh sahnya berakhir.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '84e1d086-dc80-4858-8769-5c910f0f44f0',
    0,
    'You are involved in a road collision.',
    'Anda terlibat dalam pelanggaran jalan raya.',
    '["Record the third party''s vehicle type and registration number.", "Record only the third party''s phone number.", "Take photos of the damage without recording vehicle details.", "Ask someone help to record the information for you."]',
    '["Catat jenis kenderaan dan nombor pendaftaran pihak ketiga.", "Catat nombor telefon pihak ketiga sahaja.", "Ambil gambar kerosakan tanpa merekod butiran kenderaan.", "Minta pertolongan orang lain mencatat maklumat bagi pihak anda."]',
    0,
    'Record vehicle type and registration details.',
    'Catat jenis kenderaan dan nombor pendaftaran dengan tepat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '33b049ed-7f0a-4cc5-8d60-68b9e13e318a',
    0,
    'A small fire starts near the engine compartment while parked.',
    'Semasa parkir, kebakaran kecil bermula berhampiran ruang enjin.',
    '["Use the ABC fire extinguisher if safe.", "Wait for others to assist before acting.", "Pour available water to reduce flames.", "Observe briefly before deciding."]',
    '["Gunakan alat pemadam api jenis ABC jika keadaan selamat.", "Tunggu bantuan sebelum mengambil tindakan.", "Tuang air yang ada untuk mengurangkan api.", "Perhatikan keadaan seketika sebelum membuat keputusan."]',
    0,
    'Use the appropriate extinguisher if the fire is manageable.',
    'Gunakan alat pemadam api yang sesuai jika kebakaran masih boleh dikawal dan keadaan selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8129f4b7-aae4-4c23-8def-c7f16b8dbfff',
    0,
    'You position your vehicle in a loading area where forklifts and pedestrians are moving.',
    'Anda meletakkan kenderaan di kawasan pemunggahan di mana forklift dan pejalan kaki sedang bergerak.',
    '["Move forward quickly before equipment approaches", "Position only when the area is clear of movement", "Continue moving slowly and watch for operator signals", "Stop close to the loading area to reduce walking"]',
    '["Bergerak cepat ke hadapan sebelum peralatan menghampiri", "Letakkan kenderaan hanya apabila kawasan itu tiada pergerakan", "Terus bergerak perlahan sambil perhatikan isyarat pengendali", "Berhenti dekat kawasan pemunggahan untuk kurangkan berjalan"]',
    1,
    'Keep clear of active loading zones to reduce collision and injury risk.',
    'Kekalkan jarak dari kawasan pemunggahan aktif untuk mengurangkan risiko pelanggaran dan kecederaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a86b1ec6-2c4f-4de2-a73d-7b43de532ead',
    0,
    'You approach a busy junction. Traffic slows unevenly and vehicles from the side edge forward.',
    'Anda menghampiri persimpangan sibuk. Trafik perlahan secara tidak sekata dan kenderaan dari sisi bergerak ke hadapan.',
    '["Hold your lane and approach at reduced speed", "Shift slightly within your lane to improve visibility", "Edge closer to discourage other vehicles", "Maintain speed and react only if a vehicle enters"]',
    '["Kekalkan lorong dan hampiri pada kelajuan rendah", "Bergerak sedikit dalam lorong untuk tingkatkan pandangan", "Bergerak lebih dekat untuk menghalang kenderaan lain", "Kekalkan kelajuan dan bertindak hanya jika kenderaan masuk"]',
    0,
    'Clear lane position and early speed control reduce conflict at junctions.',
    'Kedudukan lorong yang jelas dan kawalan kelajuan awal mengurangkan konflik di persimpangan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3fa15b2a-b4aa-41e3-bc85-cb4db1cdb194',
    0,
    'You approach a checkpoint inside a facility. Vehicles queue unevenly and lanes split toward inspection points.',
    'Anda menghampiri pusat pemeriksaan di dalam fasiliti. Kenderaan beratur tidak sekata dan lorong berpecah ke beberapa laluan pemeriksaan.',
    '["Remain in your lane and wait for checkpoint direction", "Shift early to a less congested lane", "Move forward and adjust position near the checkpoint", "Follow the vehicle ahead if its lane clears faster"]',
    '["Kekalkan lorong dan tunggu arahan pusat pemeriksaan", "Tukar awal ke lorong yang kurang sesak", "Bergerak ke hadapan dan sesuaikan kedudukan berhampiran pusat pemeriksaan", "Ikut kenderaan di hadapan jika lorongnya bergerak lebih cepat"]',
    0,
    'Remain orderly and wait for checkpoint direction in controlled zones.',
    'Kekalkan pergerakan teratur dan tunggu arahan pusat pemeriksaan di kawasan kawalan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '96dddfc5-ecfa-4bdf-ab99-117b94eafeef',
    0,
    'You need to reverse into a tight space in a site yard. Vehicles and equipment move nearby.',
    'Anda perlu mengundur ke ruang sempit di kawasan tapak. Kenderaan dan jentera bergerak berhampiran.',
    '["Stop and reverse only when space and visibility are clear", "Reverse slowly and adjust speed as conditions change", "Complete the manoeuvre to minimise disruption", "Follow nearby vehicles to guide your reversing speed"]',
    '["Berhenti dan undur hanya apabila ruang dan pandangan jelas", "Undur perlahan dan sesuaikan kelajuan mengikut keadaan", "Selesaikan manuver untuk kurangkan gangguan kepada orang lain", "Ikut pergerakan kenderaan berhampiran untuk panduan kelajuan mengundur"]',
    0,
    'Confirm space and visibility before reversing in busy yards.',
    'Pastikan ruang dan pandangan jelas sebelum mengundur di kawasan tapak sibuk.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '759b2d55-a2a1-4562-8c4d-8b7a0761513c',
    0,
    'You approach a narrow access point inside a facility. Visibility is limited and vehicles may enter from the opposite direction.',
    'Anda menghampiri laluan masuk sempit di dalam fasiliti. Pandangan terhad dan kenderaan mungkin masuk dari arah bertentangan.',
    '["Slow early and wait until the access path is clear", "Continue forward cautiously and adjust if a vehicle appears", "Enter the access point to hold position", "Follow the vehicle ahead through the access"]',
    '["Perlahankan kenderaan lebih awal dan tunggu sehingga laluan benar-benar jelas", "Terus bergerak dengan berhati-hati dan sesuaikan jika kenderaan muncul", "Masuk ke laluan untuk menunggu", "Ikut kenderaan di hadapan melalui laluan"]',
    0,
    'Slow early and confirm the path is clear before entering.',
    'Perlahankan kenderaan lebih awal dan pastikan laluan jelas sebelum masuk.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8ec2647e-077e-4020-85a2-faee88e6dc0a',
    0,
    'While driving, your phone receives a message and you are slightly above the speed limit.',
    'Semasa memandu, telefon anda menerima mesej dan anda memandu sedikit melebihi had laju.',
    '["Slow to the legal speed and ignore the message", "Maintain speed and quickly check the message", "Reduce speed slightly and read when traffic allows", "Keep speed steady and reply briefly"]',
    '["Kurangkan kelajuan ke had yang dibenarkan dan abaikan mesej tersebut", "Kekalkan kelajuan dan periksa mesej dengan cepat", "Kurangkan sedikit kelajuan dan baca apabila keadaan sesuai", "Kekalkan kelajuan dan balas mesej secara ringkas"]',
    0,
    'Follow speed limits and avoid device use while driving.',
    'Patuhi had laju dan elakkan penggunaan telefon semasa memandu.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e987fe92-78a4-4f0f-baf2-05cdf049b678',
    0,
    'At a controlled checkpoint, valid credentials are required and one credential has expired.',
    'Di pusat pemeriksaan kawalan, kelayakan yang sah diperlukan dan satu kelayakan telah tamat tempoh.',
    '["Stop at the checkpoint and report the issue", "Proceed slowly and resolve it afterward", "Wait to see if access is granted without it", "Continue forward since monitoring appears light"]',
    '["Berhenti di pusat pemeriksaan dan laporkan masalah tersebut", "Terus bergerak perlahan dan selesaikan kemudian", "Tunggu untuk melihat sama ada akses dibenarkan tanpa kelayakan", "Terus bergerak kerana pemantauan kelihatan kurang ketat"]',
    0,
    'Stop and meet credential requirements before proceeding.',
    'Berhenti dan pastikan kelayakan dipenuhi sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c88a3253-0f32-48d8-b86e-a9074cb2d7ec',
    0,
    'At a site with active loading operations, you step out of your vehicle in the loading area without a safety helmet.',
    'Di tapak dengan operasi pemuatan aktif, anda keluar dari kenderaan di kawasan pemuatan tanpa topi keselamatan.',
    '["Put on the required PPE and keep clear of loading", "Remain where you are and rely on operators", "Move quickly through the area to reduce time", "Wait for instructions before addressing PPE"]',
    '["Pakai PPE yang diperlukan dan kekal jauh dari operasi pemuatan", "Kekal di tempat dan bergantung pada pengendali", "Bergerak cepat melalui kawasan itu untuk kurangkan masa", "Tunggu arahan dan kemudian pakai PPE"]',
    0,
    'Wear required PPE and keep clear of loading zones.',
    'Pakai PPE yang diperlukan dan kekalkan jarak dari kawasan pemuatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '93e7f22f-4c85-485c-9d42-be980bd50d1e',
    0,
    'While manoeuvring at low speed with a load, you feel the load shift and notice the vehicle is closer than expected to an obstacle.',
    'Semasa membuat manuver pada kelajuan rendah dengan muatan, anda merasakan muatan bergerak dan menyedari kenderaan lebih dekat daripada jangkaan kepada halangan.',
    '["Stop and assess if it is safe to proceed", "Proceed slowly and adjust steering to maintain clearance", "Complete the manoeuvre and check the load afterward", "Continue moving and secure the load once clear"]',
    '["Berhenti dan pastikan selamat sebelum meneruskan", "Terus bergerak perlahan dan laraskan stereng untuk kekalkan jarak", "Selesaikan manuver dan periksa muatan selepas itu", "Terus bergerak dan periksa di tempat perhentian"]',
    0,
    'Stop and reassess when load shift or clearance risk appears.',
    'Berhenti dan nilai semula apabila muatan bergerak atau jarak menjadi sempit.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '47c53658-26ea-4cb7-9a36-297fe3cd77cf',
    0,
    'While parked at a public roadside stop, your engine is running near pedestrians and nearby premises.',
    'Semasa parkir di tepi jalan awam, enjin kenderaan masih hidup berhampiran pejalan kaki dan premis berdekatan.',
    '["Keep the engine running to maintain cabin comfort", "Shut down the engine while parked", "Keep the engine running and remain inside the vehicle", "Leave the engine running briefly before moving off"]',
    '["Biarkan enjin hidup untuk keselesaan kabin", "Matikan enjin semasa parkir", "Biarkan enjin hidup dan kekal di dalam kenderaan", "Biarkan enjin hidup seketika sebelum bergerak"]',
    1,
    'Shutting down the engine when parked protects company assets and shows respect for the public.',
    'Mematikan enjin semasa parkir melindungi aset syarikat dan menunjukkan hormat kepada orang awam.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd8a42154-d768-400b-8b0e-ac382c30fac0',
    0,
    'Inside a site, you approach a junction where parked equipment limits turning space.',
    'Di dalam tapak, anda menghampiri simpang dan jentera parkir mengehadkan ruang membelok.',
    '["Continue forward and adjust steering during the turn", "Stop early and reposition for a wider, safer turn", "Follow the shortest path to clear the junction", "Move closer before deciding how to turn"]',
    '["Teruskan ke hadapan dan laras stereng semasa membelok", "Berhenti awal dan ubah posisi untuk belokan yang lebih luas dan selamat", "Ikut laluan paling pendek untuk lepasi simpang", "Bergerak lebih dekat sebelum tentukan cara membelok"]',
    1,
    'Early positioning inside sites prevents tight turns, damage, and unnecessary corrections.',
    'Posisi awal yang betul di dalam tapak membantu elakkan belokan sempit, kerosakan dan pembetulan yang tidak perlu.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6b9597c2-8881-4128-825a-aed0adab3bb4',
    0,
    'While making a delivery, members of the public are nearby and watching your interaction with the customer.',
    'Semasa membuat penghantaran, orang awam berada berdekatan dan memerhati interaksi anda dengan pelanggan.',
    '["Focus only on the customer and ignore the surroundings", "Maintain calm, respectful behaviour mindful of the public presence", "Keep the exchange short to avoid attention", "Let the customer lead the interaction tone"]',
    '["Fokus pada pelanggan sahaja dan abaikan keadaan sekeliling", "Kekalkan tingkah laku tenang dan hormat dengan mengambil kira kehadiran orang awam", "Pendekkan perbualan untuk elak perhatian", "Biarkan pelanggan tentukan nada interaksi"]',
    1,
    'Professional behaviour matters not only to the customer, but also to the public observing the interaction.',
    'Tingkah laku profesional penting bukan sahaja kepada pelanggan tetapi juga kepada orang awam yang memerhati.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '76aa3578-88a0-48e9-995f-1c1afd97a99b',
    0,
    'During a site discussion, you realise the conversation may be overheard or recorded.',
    'Semasa perbincangan di tapak, anda sedar perbualan mungkin didengar atau dirakam.',
    '["Speak carefully and keep the discussion professional", "Lower your voice and limit further discussion", "End the conversation and return to work", "Continue speaking as you normally would"]',
    '["Bercakap dengan berhati-hati dan kekalkan profesionalisme", "Rendahkan suara dan hadkan perbincangan", "Tamatkan perbualan dan kembali bekerja", "Terus bercakap seperti biasa"]',
    0,
    'Choosing words carefully helps protect your professional image in visible situations.',
    'Pilih kata dengan cermat untuk lindungi imej profesional di tempat umum.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ee491be4-f827-49ef-b504-f5466fa223f9',
    0,
    'In a public area, people nearby are watching and filming while you interact with others.',
    'Di kawasan awam, orang di sekeliling memerhati dan merakam semasa anda berinteraksi dengan orang lain.',
    '["Keep your behaviour calm and professional throughout", "Explain your actions clearly so observers understand your position", "Limit interaction and focus on finishing the task", "Respond firmly to avoid appearing uncertain"]',
    '["Kekalkan tingkah laku tenang dan profesional sepanjang masa", "Terangkan tindakan anda supaya orang yang memerhati faham", "Hadkan interaksi dan fokus selesaikan tugas", "Beri respons dengan tegas supaya tidak kelihatan ragu-ragu"]',
    0,
    'Professional behaviour matters most when actions are visible to the public.',
    'Tingkah laku profesional amat penting apabila tindakan anda dapat dilihat oleh orang awam.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5dfb23bd-bf68-43eb-8942-f7acc6930c11',
    0,
    'Traffic slows unexpectedly, and a supervisor asks if you can make up time on the road.',
    'Trafik tiba-tiba menjadi perlahan dan penyelia bertanya sama ada anda boleh mengejar semula masa di jalan raya.',
    '["Keep to a safe speed and give a clear, realistic update", "Say you will try to make up time where possible", "Reassure them and focus on pushing ahead", "Keep the call short and continue driving"]',
    '["Kekalkan kelajuan selamat dan beri maklumat yang jelas serta realistik", "Beritahu bahawa anda akan cuba mengejar masa jika boleh", "Yakinkan penyelia dan fokus untuk bergerak lebih laju", "Pendekkan panggilan dan teruskan perjalanan"]',
    0,
    'Clear updates and safe driving help manage expectations without increasing risk.',
    'Maklumat yang jelas dan pemanduan selamat membantu urus jangkaan tanpa menambah risiko.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c3c304db-ea27-4c24-a522-971078247b86',
    0,
    'You increase following distance in slow traffic. The driver behind closes in and flashes headlights repeatedly.',
    'Anda menambah jarak kenderaan dalam trafik perlahan. Pemandu di belakang merapat dan berulang kali memberi lampu tinggi.',
    '["Keep your distance and continue without responding", "Ease closer to avoid further confrontation behind you", "Acknowledge the other driver briefly so they know you noticed", "Adjust your driving to discourage the behaviour"]',
    '["Kekalkan jarak dan teruskan tanpa memberi respons", "Rapatkan sedikit jarak untuk mengelakkan ketegangan di belakang", "Beri isyarat ringkas supaya pemandu lain tahu anda sedar", "Sesuaikan cara pemanduan untuk menghalang tingkah laku tersebut"]',
    0,
    'Maintaining safe distance and not reacting helps prevent tension from escalating in traffic.',
    'Mengekalkan jarak selamat dan tidak bertindak balas membantu mengelakkan ketegangan di jalan raya.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8371608c-8ec3-4860-8f4c-98713fd746d1',
    0,
    'You enter a narrow roadworks zone with barriers while members of the public are standing nearby.',
    'Anda memasuki kawasan pembaikan jalan yang sempit dengan penghadang, sementara orang awam berada berhampiran.',
    '["Reduce speed early and proceed cautiously", "Maintain speed to clear the zone quickly", "Follow the vehicle ahead closely to avoid delay", "Focus on steering accuracy and ignore people nearby"]',
    '["Kurangkan kelajuan lebih awal dan lalui kawasan dengan berhati-hati", "Kekalkan kelajuan untuk melepasi kawasan dengan cepat", "Ikut rapat kenderaan di hadapan supaya tidak lewat", "Fokus pada kawalan stereng dan abaikan orang di sekitar"]',
    0,
    'Reducing speed early in high-risk areas helps protect the public and reduces potential harm.',
    'Mengurangkan kelajuan lebih awal di kawasan berisiko membantu melindungi orang awam dan mengurangkan potensi bahaya.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1f0be6e5-d855-4f6d-97f5-bcb6b4526577',
    0,
    'Before starting your shift, you notice dark tint film and stickers on part of the windscreen.',
    'Sebelum memulakan syif, anda mendapati terdapat filem gelap dan pelekat pada sebahagian cermin hadapan.',
    '["Leave them since they were already installed.", "Remove or report them because they may obstruct visibility.", "Start driving and adjust your seating position instead.", "Ignore them as long as the road ahead is visible."]',
    '["Biarkan kerana ia telah dipasang sebelum ini.", "Tanggalkan atau laporkan kerana ia boleh menghalang penglihatan.", "Mulakan pemanduan dan laraskan kedudukan tempat duduk.", "Abaikan selagi jalan di hadapan masih kelihatan."]',
    1,
    'Address unauthorised modifications to protect visibility and vehicle safety.',
    'Tangani pengubahsuaian tanpa kelulusan untuk menjaga penglihatan dan keselamatan kenderaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '91b59aff-843e-4230-8fe3-6d0fb85f8d7f',
    0,
    'Your goods vehicle is experiencing failure on a highway and there is no nearby exit.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan tiada susur keluar berhampiran.',
    '["Stop in the current lane and switch on hazard lights.", "Move the vehicle to the far left shoulder before stopping.", "Stop immediately and place warning devices behind the vehicle.", "Slow down and remain in the lane until assistance arrives."]',
    '["Berhenti di lorong semasa dan hidupkan lampu kecemasan.", "Gerakkan kenderaan ke bahu kiri paling luar sebelum berhenti.", "Berhenti serta-merta dan letakkan alat amaran di belakang kenderaan.", "Perlahankan kenderaan dan kekal di lorong sehingga bantuan tiba."]',
    1,
    'Move to a safer shoulder area to reduce exposure to traffic.',
    'Gerakkan kenderaan ke bahu jalan yang lebih selamat untuk mengurangkan risiko terdedah kepada trafik.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '25bb6bb2-6556-46db-8a4a-6cb6f3d1d94c',
    0,
    'You are loading cargo and the total weight is close to the vehicle''s permitted limit.',
    'Anda sedang memuatkan kargo dan jumlah beratnya hampir mencapai had yang dibenarkan untuk kenderaan.',
    '["Load slightly above the limit if the distance is short.", "Ensure the load remains within the permitted weight limit.", "Proceed since the excess weight is minimal.", "Accept the customer''s weight figure without verification."]',
    '["Muatkan sedikit melebihi had jika jarak adalah dekat.", "Pastikan muatan kekal dalam had berat yang dibenarkan.", "Teruskan perjalanan kerana lebihan berat adalah kecil.", "Terima angka berat pelanggan tanpa pengesahan."]',
    1,
    'Always operate within the approved weight limit.',
    'Sentiasa pastikan kenderaan beroperasi dalam had berat yang diluluskan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '739920db-91ca-4ca2-ba11-762e175cb56a',
    0,
    'You notice there is no compliant safety vest in the vehicle.',
    'Anda mendapati tiada vest keselamatan yang mematuhi spesifikasi di dalam kenderaan.',
    '["Proceed if you remain inside the vehicle.", "Ensure a compliant safety vest is available before departure.", "Wear any bright-coloured clothing instead.", "Borrow one only when entering a site."]',
    '["Teruskan perjalanan jika anda kekal berada di dalam kenderaan.", "Pastikan vest keselamatan yang mematuhi spesifikasi tersedia sebelum memulakan perjalanan.", "Pakai sebarang pakaian berwarna terang sebagai ganti.", "Pinjam vest hanya apabila memasuki tapak."]',
    1,
    'Carry the required safety vest before operating.',
    'Pastikan vest keselamatan yang diperlukan dibawa sebelum beroperasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f8ef4a4d-3a94-451c-abad-a13209bc6a79',
    0,
    'You arrive at a site and the nearest space is marked as a prohibited parking area.',
    'Anda tiba di tapak dan ruang terdekat ditanda sebagai kawasan larangan parkir.',
    '["Park there briefly if unloading is quick.", "Find a permitted parking space.", "Park there if other vehicles are doing the same.", "Stop there with hazard lights switched on."]',
    '["Parkir seketika jika proses menurunkan muatan adalah cepat.", "Cari ruang parkir yang dibenarkan.", "Parkir di situ jika kenderaan lain melakukan perkara yang sama.", "Berhenti di situ dengan lampu kecemasan dihidupkan."]',
    1,
    'Do not park in prohibited areas.',
    'Parkir hanya di kawasan yang dibenarkan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '82d4102e-b3ab-4429-b2b8-492b620c844b',
    0,
    'Before starting duty, you are choosing your footwear.',
    'Sebelum memulakan tugas, anda memilih kasut untuk dipakai.',
    '["Wear covered shoes for duty.", "Wear slippers for short-distance trips.", "Wear sandals if driving locally.", "Change into shoes only when entering a site."]',
    '["Pakai kasut bertutup semasa bertugas.", "Pakai selipar untuk perjalanan jarak dekat.", "Pakai sandal jika memandu di kawasan setempat.", "Tukar kepada kasut hanya apabila memasuki tapak."]',
    0,
    'Wear proper shoes while on duty.',
    'Pakai kasut yang sesuai semasa bertugas.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e3a7164a-5d4a-42be-a3d7-197894facd11',
    0,
    'You have completed a delivery at a customer site.',
    'Anda telah menyelesaikan penghantaran di tapak pelanggan.',
    '["Obtain the receiver''s signature only.", "Obtain signature, company stamp, time received, and receiver''s name.", "Take a photo of the unloaded goods as proof.", "Record the delivery details after returning to the office."]',
    '["Dapatkan tandatangan penerima sahaja.", "Dapatkan tandatangan, cap syarikat, masa terima dan nama penerima.", "Ambil gambar barang yang telah diturunkan sebagai bukti.", "Rekodkan butiran penghantaran selepas kembali ke pejabat."]',
    1,
    'Ensure full and proper customer confirmation for every delivery.',
    'Pastikan pengesahan penerimaan lengkap bagi setiap penghantaran.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '77a673b8-6917-41f4-9ec6-6aabb99ceb25',
    0,
    'After a collision, you are gathering information from the other driver.',
    'Selepas pelanggaran, anda mengumpul maklumat daripada pemandu lain.',
    '["Take the driver''s contact number and identification details.", "Record only the vehicle number.", "Ask them to contact your office directly.", "Leave once traffic clears."]',
    '["Ambil nombor telefon dan butiran pengenalan pemandu tersebut.", "Catat nombor pendaftaran kenderaan sahaja.", "Minta mereka hubungi pejabat anda secara terus.", "Beredar apabila trafik kembali lancar."]',
    0,
    'Obtain necessary contact and identification details.',
    'Dapatkan nombor telefon dan butiran pengenalan yang diperlukan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '34c8ab88-dfa1-475f-81c7-47761130ec0a',
    0,
    'A fire on your vehicle becomes large and difficult to control.',
    'Kebakaran pada kenderaan anda menjadi besar dan sukar dikawal.',
    '["Contact the fire brigade immediately.", "Continue using the extinguisher repeatedly.", "Wait for operations to arrive first.", "Move the vehicle slightly before deciding."]',
    '["Hubungi pasukan bomba dengan segera.", "Terus gunakan alat pemadam api berulang kali.", "Tunggu bahagian operasi tiba dahulu.", "Gerakkan kendaraan sedikit sebelum membuat keputusan."]',
    0,
    'Contact fire brigade when the fire escalates.',
    'Hubungi bomba apabila kebakaran menjadi besar dan tidak terkawal.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4cbed666-a5ab-4c01-b917-05bf0515a59c',
    0,
    'You approach a site entrance from a public road. The access lane is narrow and partially obstructed.',
    'Anda menghampiri pintu masuk tapak dari jalan awam. Laluan masuk sempit dan sebahagiannya terhalang.',
    '["Maintain speed to avoid blocking traffic behind", "Slow early and proceed when the path is clear", "Move closer to assess space before stopping", "Enter the access lane and adjust position inside"]',
    '["Kekalkan kelajuan untuk elakkan menghalang trafik di belakang", "Perlahankan awal dan masuk apabila laluan jelas", "Bergerak lebih dekat untuk menilai ruang sebelum berhenti", "Masuk ke laluan dan laraskan kedudukan di dalam"]',
    1,
    'Slow early and confirm the path is clear before entering a constrained access point.',
    'Perlahankan kenderaan lebih awal dan pastikan laluan jelas sebelum memasuki laluan sempit.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c08310b1-982a-48ce-bdf6-c465bb010e60',
    0,
    'You drive at night in heavy rain on a downhill road. Visibility is reduced and vehicles ahead slow unpredictably.',
    'Anda memandu pada waktu malam dalam hujan lebat di jalan menurun. Pandangan terhad dan kenderaan di hadapan memperlahankan secara tidak menentu.',
    '["Reduce speed early for higher risk conditions", "Maintain speed and rely on headlights and braking", "Slow slightly and adjust if visibility worsens", "Keep pace with the vehicle ahead"]',
    '["Kurangkan kelajuan lebih awal kerana keadaan berisiko tinggi", "Kekalkan kelajuan dan bergantung pada lampu serta brek", "Perlahankan sedikit dan sesuaikan kelajuan jika pandangan semakin terhad", "Ikut kelajuan kenderaan di hadapan"]',
    0,
    'Reduce speed in poor visibility to maintain control.',
    'Kurangkan kelajuan apabila pandangan terhad untuk kekalkan kawalan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '92f82873-b955-4930-be0a-4bd6aa2d2671',
    0,
    'You arrive at a customer site. Access lanes are narrow and forklifts operate near the loading area.',
    'Anda tiba di tapak pelanggan. Laluan masuk sempit dan forklift beroperasi berhampiran kawasan pemuatan.',
    '["Hold back until access is clearly available", "Move forward slowly to secure a position near loading", "Approach while keeping visible to site staff", "Continue advancing to avoid delaying loading"]',
    '["Tunggu di luar sehingga laluan benar-benar jelas", "Bergerak perlahan untuk mendapatkan kedudukan berhampiran kawasan pemuatan", "Hampiri kawasan tersebut dengan memastikan anda kelihatan oleh pekerja tapak", "Terus bergerak untuk elakkan kelewatan proses pemuatan."]',
    0,
    'Keep distance from constrained access and active loading areas.',
    'Kekalkan jarak dari laluan sempit dan kawasan loading aktif.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '88adebf3-0894-44f8-bd9f-71cb87440802',
    0,
    'You drive inside a facility. Vehicles queue ahead and forklifts operate near the roadway.',
    'Anda memandu di dalam kawasan fasiliti. Kenderaan beratur di hadapan dan forklift beroperasi berhampiran laluan.',
    '["Increase following distance and keep clear sight", "Maintain spacing and close the gap if traffic slows", "Reduce the gap to avoid blocking vehicles behind", "Match the distance used by surrounding vehicles"]',
    '["Tambah jarak kenderaan dan kekalkan pandangan jelas", "Kekalkan jarak dan rapatkan jika trafik perlahan", "Rapatkan jarak untuk elakkan menghalang kenderaan di belakang", "Ikut jarak yang digunakan oleh kenderaan sekeliling"]',
    0,
    'Maintain extra spacing and clear sight near operating equipment.',
    'Kekalkan jarak tambahan dan pandangan jelas berhampiran jentera beroperasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '004682f3-8b09-4507-9b3a-1c6dafc5ae9e',
    0,
    'You approach a busy site exit joining a public road. Space is tight and reversing may be needed to realign.',
    'Anda menghampiri pintu keluar tapak yang bersambung dengan jalan awam. Ruang sempit dan mungkin perlu mengundur untuk melaras kedudukan.',
    '["Edge forward to secure position and adjust if needed", "Stop, assess, and reverse slowly under control", "Use the horn and continue moving", "Reverse quickly before vehicles arrive"]',
    '["Bergerak sedikit ke hadapan untuk mendapatkan kedudukan", "Berhenti, nilai keadaan, dan undur perlahan dengan kawalan", "Gunakan hon dan terus bergerak", "Undur dengan cepat sebelum kenderaan tiba"]',
    1,
    'Stop and maintain full control before reversing near junctions.',
    'Berhenti dan kekalkan kawalan penuh sebelum mengundur berhampiran persimpangan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4dc38d60-d3ac-4554-861e-4d27c7429bd4',
    0,
    'After a delivery, you find a required document was not completed according to company procedure.',
    'Selepas selesai penghantaran, anda mendapati dokumen yang diperlukan tidak dilengkapkan mengikut prosedur syarikat.',
    '["Complete and correct the document before closing the job", "Leave it since the delivery is already done", "Make a brief note and update it later if needed", "Proceed to the next task and rely on existing records"]',
    '["Lengkapkan dan betulkan dokumen sebelum menyelesaikan tugasan", "Biarkan sahaja kerana penghantaran sudah selesai", "Buat catatan ringkas dan kemas kini kemudian jika perlu", "Teruskan ke tugasan seterusnya dan bergantung pada rekod sedia ada"]',
    0,
    'Complete documents correctly to maintain procedural compliance.',
    'Lengkapkan dokumen dengan betul memastikan pematuhan terhadap prosedur.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8d495299-1cff-4239-bf83-8a5ad770ab1c',
    0,
    'Feeling unusually tired due to insufficient rest, you are about to enter a site with narrow internal lanes.',
    'Anda berasa amat letih kerana kurang rehat dan akan memasuki tapak dengan laluan dalaman sempit.',
    '["Delay site entry to take a short rest", "Enter carefully and rely on slow speed", "Proceed since the site is familiar", "Enter and take breaks after the manoeuvre"]',
    '["Tangguhkan kemasukan ke tapak untuk berehat seketika", "Masuk dengan berhati-hati dan bergantung pada kelajuan rendah", "Teruskan kerana tapak tersebut sudah biasa", "Masuk dan berehat selepas selesai manuver"]',
    0,
    'Address fatigue before entering confined areas.',
    'Atasi keletihan sebelum memasuki kawasan sempit.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f4456ac6-99c2-42fc-a50c-de7271aab223',
    0,
    'While waiting inside a site, an emergency alarm sounds and vehicles are directed to clear the area. Your engine is running.',
    'Semasa menunggu di dalam tapak, penggera kecemasan berbunyi dan kenderaan diarahkan mengosongkan kawasan. Enjin anda masih hidup.',
    '["Follow evacuation instructions and stop the engine when safe", "Keep the engine running and leave quickly", "Wait for clarification before acting", "Continue idling until site personnel approach"]',
    '["Ikut arahan pemindahan dan matikan enjin apabila selamat", "Kekalkan enjin hidup dan keluar dengan cepat", "Tunggu penjelasan lanjut sebelum bertindak", "Terus hidupkan enjin sehingga kakitangan tapak datang"]',
    0,
    'Follow evacuation instructions and manage the vehicle safely.',
    'Ikut arahan pemindahan dan kendalikan kenderaan dengan selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3d4f360b-2533-4b0a-869b-ca5cc0b64bb1',
    0,
    'You arrive at a customer premise and are told unloading will take longer than expected. The vehicle is parked safely.',
    'Anda tiba di tempat pelanggan dan dimaklumkan proses memunggah keluar akan mengambil masa lebih lama daripada jangkaan. Kenderaan telah diparkir dengan selamat.',
    '["Switch off the engine while waiting", "Keep the engine running to be ready to move", "Rev the engine occasionally", "Leave the engine idling and monitor the situation"]',
    '["Matikan enjin semasa menunggu", "Biarkan enjin hidup untuk bersedia bergerak", "Tekan minyak sekali-sekala", "Biarkan enjin melahu sambil memantau keadaan"]',
    0,
    'Switch off the engine during long waiting periods.',
    'Matikan enjin semasa menunggu lama untuk mengelakkan pembaziran bahan api.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'cb781930-9270-4348-8add-ee1cc2fe4b84',
    0,
    'While driving, you notice unusual vibration and a new mechanical noise from the vehicle.',
    'Semasa memandu, anda merasakan getaran tidak normal dan bunyi mekanikal baharu daripada kenderaan.',
    '["Continue driving and observe if the noise disappears", "Stop safely and report the issue clearly to the supervisor", "Reduce speed and complete the trip as planned", "Mention the issue during the next scheduled check"]',
    '["Teruskan memandu dan lihat sama ada bunyi itu hilang", "Berhenti di tempat selamat dan laporkan masalah kepada penyelia", "Kurangkan kelajuan dan teruskan perjalanan seperti dirancang", "Nyatakan masalah semasa pemeriksaan seterusnya"]',
    1,
    'Early detection and clear reporting help prevent minor issues from becoming safety risks.',
    'Pengesanan awal dan laporan yang jelas membantu mengelakkan masalah kecil menjadi risiko keselamatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '42bb16bc-e9af-4eba-90b0-8dbb5872618d',
    0,
    'At a site checkpoint, you notice a vehicle defect just before being cleared to proceed.',
    'Di checkpoint tapak, anda perasan ada kerosakan pada kenderaan sejurus sebelum dibenarkan bergerak.',
    '["Proceed through the checkpoint and report the defect afterwards", "Stop at the checkpoint and report the defect immediately", "Move past the checkpoint and assess the defect inside", "Request guidance while remaining in the queue"]',
    '["Terus melepasi checkpoint dan laporkan kerosakan kemudian", "Berhenti di checkpoint dan laporkan kerosakan segera", "Lepasi checkpoint dan periksa kerosakan di dalam", "Minta panduan sambil kekal dalam barisan"]',
    1,
    'Reporting defects at checkpoints prevents unsafe entry into controlled zones.',
    'Laporkan kerosakan sebelum bergerak untuk elakkan risiko semasa masuk atau keluar kawasan terkawal.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1c3e4845-cd88-4adf-958a-153e881befaa',
    0,
    'A staff member at the delivery premise hints that a small personal favour could speed up your delivery process.',
    'Seorang pekerja di tempat pelanggan mencadangkan bahawa bantuan peribadi kecil boleh mempercepatkan proses penghantaran.',
    '["Decline politely and follow standard procedures", "Accept the request to maintain good customer relations", "Delay the decision and see how the situation develops", "Refer the matter to another driver on site"]',
    '["Tolak dengan sopan dan ikut prosedur biasa", "Terima permintaan itu untuk jaga hubungan pelanggan", "Tangguhkan keputusan dan lihat perkembangan keadaan", "Rujuk perkara itu kepada pemandu lain di tapak"]',
    0,
    'Following standard procedures protects fairness and avoids improper influence.',
    'Mengikut prosedur biasa membantu kekalkan keadilan dan elakkan pengaruh yang tidak wajar.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ab84b763-1102-4f61-96fa-654929919a81',
    0,
    'After a delivery, you notice the recorded details do not fully match what occurred.',
    'Selepas penghantaran, anda mendapati butiran yang direkod tidak sepenuhnya sepadan dengan apa yang berlaku.',
    '["Clarify the discrepancy and update the records accurately", "Leave the records unchanged to avoid reopening the discussion", "Add brief notes later so the paperwork roughly reflects events", "Ask someone else to adjust the documents if needed"]',
    '["Jelaskan perbezaan dan kemas kini rekod dengan tepat", "Biarkan rekod seperti itu untuk elakkan perbincangan dibuka semula", "Tambah catatan ringkas kemudian supaya dokumen lebih kurang mencerminkan keadaan sebenar", "Minta orang lain mengubah dokumen jika perlu"]',
    0,
    'Correct records promptly to ensure accuracy and prevent misunderstandings.',
    'Betulkan rekod dengan segera untuk memastikan ketepatan dan mengelakkan salah faham.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1b4acd79-0010-4969-8329-d62568bfb7df',
    0,
    'After unloading in a public street, a nearby shop owner asks you to record a shorter stop time to avoid complaints.',
    'Selepas memunggah muatan di tepi jalan awam, seorang pemilik kedai meminta anda merekod masa berhenti yang lebih singkat untuk elakkan aduan.',
    '["Record the actual stop time and submit the document as required", "Shorten the recorded time since unloading is already completed", "Leave the timing unclear so it does not attract attention", "Explain the situation verbally and minimise what is written"]',
    '["Catat masa berhenti sebenar dan serahkan dokumen seperti dikehendaki", "Pendekkan masa yang direkod kerana proses memunggah sudah selesai", "Biarkan catatan masa tidak jelas supaya tidak menarik perhatian", "Jelaskan secara lisan dan kurangkan maklumat bertulis"]',
    0,
    'Accurate records uphold accountability, even when there is public pressure.',
    'Catatan yang tepat membantu kekalkan tanggungjawab walaupun ada tekanan dari luar.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '26e3f180-2e20-4d1d-a24d-1643b2e7af78',
    0,
    'You are driving through a residential area where pedestrians are present and traffic is light.',
    'Anda memandu melalui kawasan perumahan dengan kehadiran pejalan kaki dan trafik yang ringan.',
    '["Maintain an appropriate speed and remain mindful of people nearby", "Drive slightly faster to clear the area quickly", "Match the flow of traffic and continue as usual", "Focus on the road ahead and avoid reacting to bystanders"]',
    '["Kekalkan kelajuan yang sesuai dan peka terhadap orang di sekeliling", "Pandu sedikit lebih laju untuk keluar dari kawasan itu dengan cepat", "Ikut aliran trafik dan teruskan seperti biasa", "Fokus ke hadapan dan abaikan pergerakan orang di tepi jalan"]',
    0,
    'Reducing speed in residential areas shows consideration for pedestrian safety.',
    'Mengurangkan kelajuan di kawasan perumahan menunjukkan keprihatinan terhadap keselamatan pejalan kaki.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4cb48b41-12d0-4db0-b065-cd45468a2d97',
    0,
    'You intend to change lanes, but another driver in your blind spot appears unsure of your intention.',
    'Anda bercadang untuk menukar lorong, namun pemandu di titik buta kelihatan tidak pasti tentang niat anda.',
    '["Signal early and wait until the other driver responds before moving", "Drift slightly to indicate intention and move when space appears", "Check mirrors again and change lanes once traffic slows", "Hold position and change lanes later without signalling"]',
    '["Beri isyarat awal dan tunggu sehingga diberi ruang", "Hanyut sedikit ke sisi untuk menunjukkan niat dan masuk apabila ada ruang", "Periksa cermin sekali lagi dan tukar lorong apabila trafik menjadi perlahan", "Kekalkan kedudukan dan tukar lorong kemudian tanpa memberi isyarat"]',
    0,
    'Clear signalling helps other drivers understand your intention and reduces uncertainty during lane changes.',
    'Isyarat yang jelas membantu pemandu lain memahami niat anda dan mengurangkan ketidakpastian semasa menukar lorong.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd91c0576-b7ae-4a08-bb90-c311a91eb030',
    0,
    'Another driver cuts in suddenly, forcing you to brake, then begins gesturing angrily at you.',
    'Seorang pemandu memotong masuk secara tiba-tiba sehingga anda terpaksa membrek, kemudian menunjukkan isyarat marah kepada anda.',
    '["Regain composure and continue driving without reacting", "Respond briefly to show you were affected by the move", "Accelerate to move away from the situation", "Slow further to signal your frustration"]',
    '["Tenangkan diri dan teruskan pemanduan tanpa memberi respons", "Beri respons ringkas untuk menunjukkan anda terkesan", "Tambah kelajuan untuk menjauhkan diri daripada situasi", "Perlahankan lagi kenderaan sebagai tanda tidak puas hati"]',
    0,
    'Maintaining composure and not reacting helps prevent aggressive situations from escalating.',
    'Mengekalkan ketenangan dan tidak bertindak balas membantu mengelakkan situasi agresif daripada menjadi lebih tegang.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '67396d71-2eb8-4931-8d07-7c6396d8b9e4',
    0,
    'You plan to install a sun shade, dark tint film, or stickers on the company truck windscreen.',
    'Anda bercadang memasang pelindung matahari, filem gelap, atau pelekat pada cermin hadapan lori syarikat.',
    '["Install them if they do not block the main driving view.", "Do not install them without company approval.", "Use removable shades only during daytime driving.", "Check whether other drivers have done similar modifications."]',
    '["Pasang jika tidak menghalang pandangan utama ketika memandu.", "Jangan pasang tanpa kelulusan syarikat.", "Gunakan pelindung yang boleh ditanggalkan pada waktu siang sahaja.", "Periksa sama ada pemandu lain pernah membuat pengubahsuaian yang sama."]',
    1,
    'Avoid unauthorised vehicle modifications that may affect safety or compliance.',
    'Elakkan pengubahsuaian pada kenderaan tanpa kelulusan yang boleh menjejaskan keselamatan atau pematuhan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8c4dd441-3f15-4133-b735-cada22e8ce31',
    0,
    'Your goods vehicle is experiencing failure on a highway and you have stopped on the left shoulder.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda telah berhenti di bahu jalan sebelah kiri.',
    '["Remain inside and assess the situation first.", "Switch on the hazard lights immediately.", "Call your supervisor before taking further action.", "Step out briefly to check approaching traffic."]',
    '["Kekal di dalam kenderaan dan nilai keadaan terlebih dahulu.", "Hidupkan lampu kecemasan dengan segera.", "Hubungi penyelia sebelum mengambil tindakan lanjut.", "Keluar sebentar untuk memeriksa trafik yang menghampiri."]',
    1,
    'Activate hazard lights promptly to alert approaching traffic.',
    'Hidupkan lampu kecemasan segera untuk memberi amaran kepada pengguna jalan lain.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fb35cd8d-dd0f-4f95-b8fa-1a373fd3d120',
    0,
    'Your vehicle is due for scheduled maintenance according to the company/manufacturer''s manual.',
    'Kenderaan anda telah tiba masa menjalani penyelenggaraan berjadual mengikut manual syarikat atau pengeluar.',
    '["Continue operating since the vehicle is running smoothly.", "Follow the scheduled maintenance requirement.", "Postpone the service until the next trip cycle.", "Wait for further confirmation before arranging service."]',
    '["Terus beroperasi kerana kenderaan masih berfungsi dengan baik.", "Patuhi keperluan penyelenggaraan berjadual.", "Tangguhkan servis sehingga kitaran perjalanan seterusnya.", "Tunggu pengesahan lanjut sebelum mengaturkan servis."]',
    1,
    'Follow the company/manufacturer''s maintenance schedule as required.',
    'Patuhi jadual penyelenggaraan yang ditetapkan oleh syarikat atau pengeluar.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '469c1930-d6d2-40e0-9fb5-d86831586278',
    0,
    'You are involved in a minor incident during vehicle operation.',
    'Anda terlibat dalam satu insiden kecil semasa mengendalikan kenderaan.',
    '["Report the incident within 2 hours as required.", "Report it at the end of the workday.", "Report only if damage is visible.", "Wait until instructed before reporting."]',
    '["Laporkan insiden dalam tempoh 2 jam seperti yang ditetapkan.", "Laporkan pada akhir hari kerja.", "Laporkan hanya jika terdapat kerosakan yang dapat dilihat.", "Tunggu arahan sebelum membuat laporan."]',
    0,
    'Report accidents or incidents within the required reporting timeframe.',
    'Laporkan kemalangan atau insiden dalam tempoh masa pelaporan yang ditetapkan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd4c86a9d-6069-4920-b456-2d7e2e496d79',
    0,
    'You are about to start driving the vehicle.',
    'Anda hendak memulakan pemanduan kenderaan.',
    '["Fasten the seat belt before moving.", "Drive first and fasten it later.", "Wear it only on highways.", "Use it only when carrying heavy cargo."]',
    '["Pakai tali pinggang keledar sebelum bergerak.", "Mula memandu dan pakai kemudian.", "Pakai hanya di lebuh raya.", "Pakai hanya apabila membawa muatan berat."]',
    0,
    'Always wear the seat belt before driving.',
    'Pakai tali pinggang keledar sebelum memandu.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b63245d6-d2f8-4f27-a659-7ba2657bd67d',
    0,
    'You are reporting for duty after several weeks without a haircut.',
    'Anda melapor diri untuk bertugas selepas beberapa minggu tanpa memotong rambut.',
    '["Maintain short and neat hair as required.", "Keep long hair if tied properly.", "Trim only when reminded by HR.", "Maintain appearance only for inspections."]',
    '["Pastikan rambut sentiasa pendek dan kemas seperti yang ditetapkan.", "Simpan rambut panjang asalkan diikat dengan kemas.", "Potong rambut hanya apabila diingatkan oleh pihak sumber manusia (HR).", "Jaga penampilan hanya semasa pemeriksaan dijalankan."]',
    0,
    'Maintain neat and appropriate grooming for duty.',
    'Kekalkan penampilan yang kemas dan sesuai semasa bertugas.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5b768565-6d24-401c-9cbf-7778b6613259',
    0,
    'You arrive at a delivery location and notice the address differs from the delivery note.',
    'Anda tiba di lokasi penghantaran dan mendapati alamat berbeza daripada yang tertera pada nota penghantaran.',
    '["Deliver to the new address if the customer confirms verbally.", "Contact operations for confirmation before proceeding.", "Deliver if the location is nearby.", "Leave the goods with the person present at the site."]',
    '["Hantar ke alamat baharu jika pelanggan mengesahkan secara lisan.", "Hubungi bahagian operasi untuk pengesahan sebelum meneruskan penghantaran.", "Hantar jika lokasi berhampiran.", "Tinggalkan barang kepada individu yang berada di tapak."]',
    1,
    'Verify address changes with operations before delivery.',
    'Sahkan sebarang perubahan alamat dengan bahagian operasi sebelum membuat penghantaran.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '311e9ca4-0695-4de7-9da4-e324c4e70fa0',
    0,
    'Following a collision, what photographic evidence should you collect?',
    'Selepas pelanggaran, bukti gambar apakah yang perlu anda ambil?',
    '["Photos of the scene and vehicles involved.", "Only your own vehicle damage.", "A photo after vehicles are moved.", "No photos if witnesses are present."]',
    '["Gambar lokasi kejadian dan kenderaan yang terlibat.", "Gambar kerosakan kenderaan anda sahaja.", "Gambar selepas kenderaan dialihkan.", "Tidak perlu ambil gambar jika ada saksi."]',
    0,
    'Take clear photos of the accident scene and vehicles.',
    'Ambil gambar yang jelas bagi lokasi kejadian dan kenderaan yang terlibat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ce135b48-5b4f-4d1a-bc40-3330314cb899',
    0,
    'You drive in slow traffic. A driver cuts in and brakes sharply.',
    'Anda memandu dalam trafik perlahan. Seorang pemandu memotong masuk dan membrek secara mengejut.',
    '["Reduce speed smoothly and keep a safe pace", "Maintain speed to avoid being pushed back", "Slow briefly, then speed up to create space", "Adjust speed after traffic settles"]',
    '["Kurangkan kelajuan secara lancar dan kekalkan kelajuan selamat", "Kekalkan kelajuan untuk mengelak daripada didorong ke belakang.", "Perlahankan seketika kemudian tambah kelajuan untuk mewujudkan ruang di hadapan", "Sesuaikan kelajuan selepas trafik kembali stabil"]',
    0,
    'Calm speed control prevents impulsive reactions in frustrating traffic.',
    'Kawalan kelajuan yang tenang membantu mengelakkan tindak balas impulsif dalam trafik.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.25, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6fd52a72-16eb-4a04-a365-ccf2e8a81dd9',
    0,
    'You are in an active loading area during heavy rain. Surfaces are wet and equipment operates nearby.',
    'Anda berada di kawasan pemuatan aktif semasa hujan lebat. Permukaan basah dan jentera beroperasi berhampiran.',
    '["Stay clear of the loading area until conditions stabilise", "Proceed carefully while adjusting pace for the weather", "Move closer to monitor equipment movement", "Continue approaching so loading can proceed"]',
    '["Kekal jauh dari kawasan pemuatan sehingga keadaan stabil", "Teruskan dengan berhati-hati sambil laraskan kelajuan", "Bergerak lebih dekat untuk memantau pergerakan jentera", "Terus menghampiri supaya proses pemuatan boleh diteruskan"]',
    0,
    'Keep clear of loading activity when weather increases risk.',
    'Kekalkan jarak dari aktiviti pemuatan apabila keadaan cuaca meningkatkan risiko.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0b55fad7-6408-4fc2-9fd1-70c2f9c130e1',
    0,
    'You move from an internal roadway toward a loading area. Obstructions and movement change around you.',
    'Anda bergerak dari laluan dalaman menuju kawasan pemunggahan. Halangan dan pergerakan berubah di sekeliling.',
    '["Slow early and adjust your path to surrounding movement", "Maintain pace and react when a hazard appears", "Focus on the path ahead and reassess inside", "Follow vehicles ahead that pass smoothly"]',
    '["Perlahankan kenderaan lebih awal dan sesuaikan laluan mengikut pergerakan sekitar", "Kekalkan kelajuan dan bertindak apabila bahaya muncul", "Fokus pada laluan di hadapan dan nilai semula selepas masuk", "Ikut kenderaan di hadapan yang melalui kawasan dengan lancar"]',
    0,
    'Anticipate early and adjust space to avoid sudden reactions.',
    'Jangka lebih awal dan sesuaikan ruang untuk elakkan tindak balas mengejut.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '011e89db-1beb-416e-8441-fbfad4901f9c',
    0,
    'At a security checkpoint, the vehicle ahead is being cleared and the guard signals you to move closer.',
    'Di pusat pemeriksaan keselamatan, kenderaan di hadapan sedang diperiksa dan pengawal memberi isyarat supaya anda bergerak lebih dekat.',
    '["Close the gap to speed up clearance", "Keep a safe following distance", "Stop directly behind the vehicle", "Move slowly and rely on the guard to manage spacing"]',
    '["Rapatkan jarak untuk mempercepatkan pemeriksaan", "Kekalkan jarak selamat dengan kenderaan di hadapan", "Berhenti tepat di belakang kenderaan", "Bergerak perlahan dan bergantung pada pengawal untuk mengawal jarak"]',
    1,
    'Checkpoint instructions do not replace safe spacing.',
    'Arahan pusat pemeriksaan tidak menggantikan disiplin jarak selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '32a6f1f3-52ab-46a1-9de0-4dcecda3e522',
    0,
    'After a delivery, you are stopped for inspection and asked to present your documents. One document was completed late but is accurate.',
    'Selepas penghantaran, anda ditahan untuk pemeriksaan dan diminta menunjukkan dokumen. Satu dokumen dilengkapkan lewat tetapi maklumatnya tepat.',
    '["Present the documents and clarify the late entry", "Hand over the documents without mentioning the late entry", "Say the document was completed earlier", "Offer to update the document later"]',
    '["Tunjukkan dokumen dan jelaskan tentang pengisian lewat", "Serahkan dokumen tanpa memaklumkan tentang kelewatan pengisian", "Nyatakan bahawa dokumen telah dilengkapkan lebih awal", "Tawarkan untuk mengemas kini dokumen kemudian"]',
    0,
    'Present accurate documents and clarify issues during inspections.',
    'Tunjukkan dokumen yang tepat dan jelaskan perkara berkaitan semasa pemeriksaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bc7fc742-d4e2-42ae-a96e-326e262b4536',
    0,
    'While driving inside a site, you see a posted speed limit.',
    'Semasa memandu di dalam tapak, anda melihat had laju yang dipaparkan.',
    '["Adjust speed to comply with the posted limit", "Maintain current speed since traffic is light", "Reduce speed slightly but continue comfortably", "Match the speed of other vehicles"]',
    '["Laraskan kelajuan untuk mematuhi had laju yang dipaparkan", "Kekalkan kelajuan kerana trafik ringan", "Kurangkan kelajuan sedikit tetapi teruskan dengan selesa", "Ikut kelajuan kenderaan lain"]',
    0,
    'Follow posted speed limits inside operational sites.',
    'Patuhi had laju yang ditetapkan di dalam kawasan operasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '99139092-0bb9-408b-adb3-cc0d2894c20c',
    0,
    'After a pre-trip inspection, you feel an unusual vibration while driving.',
    'Selepas pemeriksaan sebelum perjalanan, anda merasakan getaran tidak biasa semasa memandu.',
    '["Stop and recheck the vehicle before continuing", "Continue driving since the inspection showed no problems", "Complete the trip and report it at the end of the shift", "Ignore it unless a warning indicator appears"]',
    '["Berhenti dan periksa semula kenderaan", "Terus memandu kerana pemeriksaan awalan dibuat", "Selesaikan perjalanan dan laporkan pada akhir syif", "Abaikan kecuali lampu amaran muncul"]',
    0,
    'Unusual vehicle behaviour requires immediate checking.',
    'Perubahan mekanikal kenderaan perlu diperiksa segera.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5f280fc2-64b2-4197-91e3-2efa45c14400',
    0,
    'At the end of your shift, the vehicle cabin is cluttered with items.',
    'Pada akhir syif, kabin kenderaan berselerak dengan barang.',
    '["Tidy the cabin and leave it ready for the next driver", "Leave the cabin since the shift has ended", "Remove personal items and clean it the next shift", "Clean only if the next driver is known"]',
    '["Kemas kabin dan sediakan untuk pemandu seterusnya", "Biarkan kabin kerana syif telah tamat", "Ambil barang peribadi dan kemakan kabin keesokan hari", "Bersihkan hanya jika pemandu seterusnya dikenali"]',
    0,
    'Leave the cabin orderly for the next user or the next shift',
    'Tinggalkan kabin dalam keadaan kemas untuk pengguna seterusnya.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8d48ee39-3d42-40a2-bb46-2c5b8a7189ae',
    0,
    'Before departure, you identify a cargo safety concern while another party pressures you to move immediately.',
    'Sebelum berlepas, anda mengenal pasti isu keselamatan muatan sementara pihak lain mendesak anda bergerak segera.',
    '["Proceed carefully to avoid further discussion", "Address the safety concern and explain the delay calmly", "Agree to move briefly to reduce tension", "Remain silent and delay action"]',
    '["Teruskan dengan berhati-hati untuk elakkan perbincangan lanjut", "Tangani isu keselamatan muatan dan jelaskan kelewatan dengan tenang", "Setuju bergerak seketika untuk mengurangkan ketegangan", "Berdiam diri dan tangguhkan tindakan"]',
    1,
    'Address safety concerns first while responding calmly to others.',
    'Utamakan keselamatan sambil bertindak balas dengan tenang kepada pihak lain.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ad010493-6773-477a-893d-25de540ce479',
    0,
    'While reversing slowly inside a site, you notice steering response feels abnormal.',
    'Semasa mengundur perlahan di dalam tapak, anda merasakan tindak balas stereng tidak normal.',
    '["Continue reversing carefully to clear the area", "Stop the manoeuvre and assess the defect", "Complete the reverse and report afterward", "Reduce speed further and keep moving"]',
    '["Terus mengundur dengan berhati-hati untuk lepasi kawasan itu", "Hentikan manuver dan periksa keadaan", "Selesaikan undur dan laporkan selepas itu", "Kurangkan lagi kelajuan dan teruskan bergerak"]',
    1,
    'Stopping immediately when a defect is felt during manoeuvres prevents damage and injury.',
    'Hentikan kenderaan apabila terasa tanda tidak normal semasa manuver untuk elakkan kerosakan dan kecederaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4e545ad3-dd1e-427d-836e-f12afaac0720',
    0,
    'A customer becomes verbally aggressive after being told the delivery cannot proceed as requested.',
    'Seorang pelanggan bercakap secara agresif selepas dimaklumkan bahawa penghantaran tidak dapat diteruskan seperti diminta.',
    '["Respond firmly to assert your position", "Stay calm, acknowledge concerns, and explain the situation clearly", "End the conversation and walk away", "Repeat company policy without further engagement"]',
    '["Jawab dengan tegas untuk pertahankan pendirian", "Kekal tenang, dengar perkara yang dibangkitkan dan terangkan keadaan dengan jelas", "Tamatkan perbualan dan beredar", "Ulang dasar syarikat tanpa perbincangan lanjut"]',
    1,
    'Staying calm and acknowledging concerns helps prevent escalation and keeps the situation under control.',
    'Kekal tenang dan beri penjelasan yang jelas membantu elakkan keadaan menjadi lebih tegang dan kekalkan kawalan situasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a8617a58-108f-436d-857d-8c01c424d0b8',
    0,
    'During unloading, a site worker suggests a small personal favour to speed up the process.',
    'Semasa proses memunggah, seorang pekerja tapak mencadangkan bantuan peribadi kecil untuk mempercepatkan proses.',
    '["Decline politely and continue unloading as required", "Agree briefly since it may help everyone finish faster", "Avoid responding directly and keep working to reduce attention", "Suggest handling the request later to keep things moving"]',
    '["Tolak dengan sopan dan teruskan proses memunggah seperti dikehendaki", "Setuju seketika kerana ia mungkin mempercepatkan kerja", "Elakkan memberi respons secara langsung dan teruskan kerja", "Cadangkan urus perkara itu kemudian supaya kerja berjalan"]',
    0,
    'Declining improper requests helps maintain integrity and fair working practices.',
    'Menolak permintaan yang tidak sesuai membantu kekalkan integriti dan amalan kerja yang adil.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '84addca1-93de-49b5-8a28-a3846da224b1',
    0,
    'During a delivery discussion, someone becomes upset after you refuse an improper request.',
    'Semasa perbincangan penghantaran, seseorang menjadi tidak puas hati selepas anda menolak permintaan yang tidak sesuai.',
    '["Restate your position calmly and keep the discussion respectful", "Explain in detail why the request is wrong and unacceptable", "End the discussion abruptly to avoid further disagreement", "Respond firmly to make it clear the matter is closed"]',
    '["Nyatakan semula pendirian anda dengan tenang dan kekalkan perbincangan secara hormat", "Terangkan dengan terperinci mengapa permintaan itu salah dan tidak boleh diterima", "Tamatkan perbincangan secara mendadak untuk elak pertelingkahan lanjut", "Beri respons dengan tegas supaya jelas perkara itu telah selesai"]',
    0,
    'Holding your position calmly helps resolve issues without escalating conflict.',
    'Kekalkan pendirian dengan tenang untuk selesaikan isu tanpa meningkatkan ketegangan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '526f8fee-6ed0-40a2-a580-fa1c4fdde45b',
    0,
    'A driver behind you flashes headlights repeatedly and gestures, appearing impatient with your speed.',
    'Seorang pemandu di belakang anda berulang kali memberi lampu tinggi dan membuat isyarat, kelihatan tidak sabar dengan kelajuan anda.',
    '["Keep your speed steady and avoid responding to the behaviour", "Speed up slightly so the situation does not turn into an argument", "Change lanes when possible to prevent further confrontation", "React briefly to signal you have noticed the other driver"]',
    '["Kekalkan kelajuan secara konsisten dan elakkan memberi respons", "Tambah sedikit kelajuan supaya keadaan tidak menjadi tegang", "Tukar lorong apabila selamat untuk mengelakkan konfrontasi", "Beri respons ringkas untuk menunjukkan anda sedar akan kehadirannya"]',
    0,
    'Maintaining steady driving and not reacting helps prevent conflicts from escalating.',
    'Pemanduan yang stabil dan tidak bertindak balas membantu mengelakkan situasi daripada menjadi tegang.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '98032fd2-d864-4cd5-a259-67c45975d992',
    0,
    'You slow to turn near pedestrians, and nearby road users appear unsure of your intention.',
    'Anda memperlahankan kenderaan untuk membelok berhampiran pejalan kaki, dan pengguna jalan lain kelihatan tidak pasti tentang niat anda.',
    '["Signal early and make the turn carefully", "Slow further to see how others react", "Turn once there is space without signalling", "Edge forward slightly to show what you intend to do"]',
    '["Beri isyarat awal dan belok secara cermat", "Perlahankan lagi untuk melihat reaksi orang lain", "Belok apabila ada ruang tanpa memberi isyarat", "Gerak sedikit ke hadapan untuk menunjukkan niat"]',
    0,
    'Early signalling helps pedestrians and other road users understand your intention and stay safe.',
    'Isyarat awal membantu pejalan kaki dan pengguna jalan lain memahami niat anda dan kekal selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '248ecc40-c64b-4bd2-a5dd-aa539aab8bc9',
    0,
    'A vehicle cuts in sharply, making you angry. You need to change lanes while drivers around you are unsure of your intention.',
    'Sebuah kenderaan memotong masuk secara mengejut sehingga anda berasa marah. Anda perlu menukar lorong ketika pemandu lain di sekitar tidak pasti tentang niat anda.',
    '["Regain composure and signal clearly before changing lanes", "Change lanes quickly to get away from the situation", "Sound the horn briefly to express frustration", "Hold your lane without signalling until traffic settles"]',
    '["Tenangkan diri dan beri isyarat dengan jelas sebelum menukar lorong", "Tukar lorong dengan cepat untuk menjauhkan diri daripada situasi", "Bunyi hon seketika untuk meluahkan rasa tidak puas hati", "Kekalkan lorong tanpa memberi isyarat sehingga trafik kembali stabil"]',
    0,
    'Clear signalling after regaining composure helps others understand your intentions and keeps traffic moving safely.',
    'Isyarat yang jelas selepas menenangkan diri membantu pemandu lain memahami niat anda dan memastikan aliran trafik kekal selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9d5562d1-cfc9-4baa-9535-ad9720dc3d56',
    0,
    'You have completed 8 hours of driving for the day and one nearby delivery remains.',
    'Anda telah memandu selama 8 jam pada hari tersebut dan satu penghantaran berhampiran masih belum selesai.',
    '["Continue driving to complete the final delivery.", "Stop driving and report reaching the daily limit.", "Drive for another 30 minutes before stopping.", "Reduce speed and complete the delivery carefully."]',
    '["Terus memandu untuk menyelesaikan penghantaran terakhir.", "Hentikan pemanduan dan laporkan bahawa had harian telah dicapai.", "Memandu lagi selama 30 minit sebelum berhenti.", "Kurangkan kelajuan dan selesaikan penghantaran dengan berhati-hati."]',
    1,
    'Follow driving hour limits to maintain safety and compliance.',
    'Patuhi had waktu pemanduan untuk menjaga keselamatan dan pematuhan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fc74aebd-ccac-4cfa-9df9-b07372e8a0bb',
    0,
    'Your goods vehicle is experiencing failure at night and you need to step out.',
    'Kenderaan barangan anda mengalami kerosakan pada waktu malam dan anda perlu keluar dari kenderaan.',
    '["Exit quickly to place warning devices.", "Wear a safety vest before exiting.", "Stand beside the vehicle and observe traffic.", "Use your phone light while walking behind the vehicle."]',
    '["Keluar dengan segera untuk meletakkan alat amaran.", "Pakai jaket keselamatan sebelum keluar.", "Berdiri di sebelah kenderaan dan perhatikan trafik.", "Gunakan lampu telefon bimbit semasa berjalan di belakang kenderaan."]',
    1,
    'Ensure personal visibility before exiting to reduce roadside risk.',
    'Pastikan anda mudah dilihat sebelum keluar bagi mengurangkan risiko di tepi jalan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd7c05d94-5da2-4d19-9058-2c68c6be1b13',
    0,
    'During inspection, you notice the fire extinguisher has passed its expiry date.',
    'Semasa pemeriksaan, anda mendapati alat pemadam api telah melepasi tarikh luput.',
    '["Keep using it since it has not been discharged.", "Replace it with a compliant 9kg extinguisher within validity.", "Replace it with a compliant 6kg extinguisher within validity.", "Replace it with a compliant 12kg extinguisher within validity."]',
    '["Terus gunakan kerana ia belum pernah digunakan.", "Gantikan dengan alat pemadam api 9kg yang mematuhi spesifikasi dan masih dalam tempoh sah.", "Gantikan dengan alat pemadam api 6kg yang mematuhi spesifikasi dan masih dalam tempoh sah.", "Gantikan dengan alat pemadam api 12kg yang mematuhi spesifikasi dan masih dalam tempoh sah."]',
    1,
    'Ensure the required fire extinguisher meets the approved specification and validity.',
    'Pastikan alat pemadam api yang diperlukan mematuhi spesifikasi dan tempoh sah yang ditetapkan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1236f17f-dc92-4f60-baec-5ef0898ea4db',
    0,
    'You are asked to modify the vehicle''s GPS tracking or speedometer settings.',
    'Anda diminta untuk mengubah suai tetapan sistem GPS atau meter kelajuan kenderaan.',
    '["Make the adjustment if it improves convenience.", "Refuse any modification that violates safety or company protocol.", "Adjust the settings temporarily and restore them later.", "Modify only if other drivers have done so."]',
    '["Buat pelarasan jika ia memudahkan urusan.", "Tolak sebarang pengubahsuaian yang melanggar peraturan keselamatan atau prosedur syarikat.", "Ubah tetapan sementara dan pulihkan kemudian.", "Buat pengubahsuaian hanya jika pemandu lain pernah melakukannya."]',
    1,
    'Do not alter vehicle systems against safety rules or company protocol.',
    'Jangan mengubah suai sistem kenderaan yang bertentangan dengan peraturan keselamatan atau prosedur syarikat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c6e742fe-49f9-471f-91a5-6ff5b1037851',
    0,
    'You are selected for a random blood and urine test during duty.',
    'Anda dipilih untuk menjalani ujian darah dan air kencing secara rawak semasa bertugas.',
    '["Cooperate and undergo the test as required.", "Request to postpone the test to another day.", "Refuse the test because it is unlawful.", "Agree only if other drivers are tested first."]',
    '["Berikan kerjasama dan jalani ujian tersebut seperti yang dikehendaki.", "Minta supaya ujian ditangguhkan ke hari lain.", "Tolak ujian tersebut kerana ia tidak sah di sisi undang-undang.", "Bersetuju hanya jika pemandu lain diuji terlebih dahulu."]',
    0,
    'Comply with random substance testing as required.',
    'Patuhi ujian saringan bahan terlarang secara rawak seperti yang ditetapkan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a34279b2-d125-4969-8bde-f10f39015e15',
    0,
    'You are starting your work shift for the day.',
    'Anda memulakan syif kerja pada hari tersebut.',
    '["Record your attendance at the end of the shift.", "Record your attendance at the beginning and end of the shift.", "Inform your supervisor.", "Record attendance only when requested."]',
    '["Rekodkan kehadiran pada akhir syif.", "Rekodkan kehadiran pada awal dan akhir syif.", "Maklumkan kepada penyelia.", "Rekodkan kehadiran hanya apabila diminta."]',
    1,
    'Record attendance properly at the start and end of duty.',
    'Rekod kehadiran dengan betul pada awal dan akhir tugas.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b2f20dbf-b4e6-40f3-967f-286acf2406a8',
    0,
    'After ensuring safety at the accident scene, what should you do next?',
    'Selepas memastikan keselamatan di lokasi kemalangan, apakah tindakan seterusnya?',
    '["Report immediately to office.", "Complete delivery first and report later.", "Wait until returning to depot.", "Inform only if damage is serious."]',
    '["Laporkan segera kepada pejabat.", "Selesaikan penghantaran dahulu dan laporkan kemudian.", "Tunggu sehingga kembali ke depot.", "Maklumkan hanya jika kerosakan adalah serius."]',
    0,
    'Report the incident immediately and await instruction.',
    'Laporkan kejadian segera dan tunggu arahan lanjut.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5a9576ea-34ed-42c4-b1b8-566db0868d76',
    0,
    'After a collision, operations asks for your location.',
    'Selepas pelanggaran, bahagian operasi meminta lokasi anda.',
    '["Provide the exact location using junctions or landmarks.", "Say you are \"near the highway\".", "Share the location after police arrival.", "Wait for GPS tracking to update automatically."]',
    '["Berikan lokasi tepat dengan menyatakan simpang atau mercu tanda.", "Berikan anggaran lokasi berdasarkan kawasan sekitar.", "Kongsi lokasi selepas polis tiba.", "Tunggu sistem GPS dikemas kini secara automatik."]',
    0,
    'Provide precise accident location details.',
    'Berikan butiran lokasi kemalangan dengan tepat dan jelas.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bd20439a-9de7-431f-9fd7-0bb54c3bee45',
    0,
    'You drive in steady multi-lane traffic. Motorcycles filter between lanes and traffic slows near an exit.',
    'Anda memandu dalam trafik berbilang lorong yang lancar. Motosikal bergerak di antara lorong dan trafik perlahan berhampiran susur keluar.',
    '["Maintain lane position and prepare for sudden movement", "Change lanes early to avoid slowing traffic", "Hold lane but move closer to the lane marking", "Continue normally and react only if traffic slows"]',
    '["Kekalkan kedudukan lorong dan bersedia untuk pergerakan mengejut", "Tukar lorong lebih awal untuk mengelakkan trafik perlahan", "Kekalkan lorong tetapi bergerak lebih dekat ke garisan lorong", "Teruskan seperti biasa dan bertindak hanya jika trafik perlahan"]',
    0,
    'Maintain stable lane position and anticipate sudden movement.',
    'Kekalkan kedudukan lorong yang stabil dan jangka pergerakan mengejut.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '41a136a6-05ad-4711-804e-029319c374b6',
    0,
    'You follow a slow vehicle on a busy road. Traffic flows on the adjacent lane.',
    'Anda mengekori kenderaan perlahan di jalan sibuk. Trafik bergerak di lorong sebelah.',
    '["Wait for a clear safe gap before overtaking", "Overtake quickly to avoid staying behind", "Move closer to signal your intent", "Begin overtaking and adjust as traffic responds"]',
    '["Tunggu ruang yang benar-benar selamat sebelum memotong", "Memotong dengan cepat supaya tidak terus terperangkap", "Bergerak lebih dekat untuk memberi isyarat niat", "Mulakan memotong dan sesuaikan kedudukan mengikut trafik"]',
    0,
    'Manage frustration and wait for a clear safe gap before overtaking.',
    'Kawal rasa marah dan tunggu ruang yang benar-benar selamat sebelum memotong.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '068d1388-c0e4-49c1-87b4-6aa56596c692',
    0,
    'You approach a junction inside an industrial site. Internal lanes intersect and site rules require vehicles to yield.',
    'Anda menghampiri persimpangan di dalam kawasan industri. Laluan dalaman bersilang dan peraturan tapak memerlukan kenderaan memberi laluan.',
    '["Slow down and follow the site junction rule", "Roll forward and proceed when the path looks clear", "Edge into the junction to signal intention", "Enter if nearby vehicles move through safely"]',
    '["Perlahankan kenderaan dan ikut peraturan persimpangan tapak", "Bergerak perlahan dan masuk apabila laluan kelihatan jelas", "Masuk sedikit ke persimpangan untuk memberi isyarat niat", "Masuk jika kenderaan berhampiran kelihatan melalui dengan selamat"]',
    0,
    'Apply site junction rules to prevent conflicts at internal intersections.',
    'Patuhi peraturan persimpangan tapak untuk mengelakkan konflik di persimpangan dalaman.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f1eb244a-7adb-469e-bf3e-6b5bb9be2d8a',
    0,
    'During a roadside inspection, an officer approaches and you realise you are not wearing a safety vest.',
    'Semasa pemeriksaan di tepi jalan, seorang pegawai menghampiri dan anda sedar anda tidak memakai vest keselamatan.',
    '["Put on the safety vest and cooperate with the inspection", "Continue the inspection and wear it if instructed", "Answer the officer''s questions and address it later", "Remain where you are until the inspection ends"]',
    '["Pakai vest keselamatan dan beri kerjasama semasa pemeriksaan", "Teruskan pemeriksaan dan pakai jika diarahkan", "Jawab soalan pegawai dan uruskan kemudian", "Kekal di tempat anda sehingga pemeriksaan selesai"]',
    0,
    'Wear required safety equipment during inspections.',
    'Pakai peralatan keselamatan yang diperlukan semasa pemeriksaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9c90b2cb-5a1d-41fa-ad24-ab5ba7a0ea3f',
    0,
    'While driving inside a site, you encounter uneven surfaces and hazards along the route. You are within the speed limit.',
    'Semasa memandu di dalam tapak, anda menghadapi permukaan tidak rata dan bahaya di laluan. Anda masih dalam had laju dibenarkan.',
    '["Reduce speed to suit the hazards", "Maintain speed since it is within the limit", "Adjust speed only near visible obstacles", "Continue at normal speed and rely on steering"]',
    '["Kurangkan kelajuan mengikut keadaan", "Kekalkan kelajuan kerana masih dalam had laju", "Sesuaikan kelajuan hanya berhampiran halangan yang jelas", "Teruskan pada kelajuan biasa dan bergantung pada kawalan stereng"]',
    0,
    'Adjust speed to suit conditions even within the limit.',
    'Sesuaikan kelajuan mengikut keadaan walaupun masih dalam had laju.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3144682b-68a2-424d-b77d-055732ac072d',
    0,
    'After a pre-trip inspection, the vehicle behaves differently once you begin moving.',
    'Selepas pemeriksaan sebelum perjalanan, kenderaan menunjukkan keadaan tidak biasa apabila anda mula bergerak.',
    '["Continue driving to see if it settles", "Stop safely and reassess the vehicle", "Adjust driving style to compensate", "Complete the trip and report later"]',
    '["Terus memandu untuk melihat sama ada keadaan kembali normal", "Berhenti dengan selamat dan periksa semula kenderaan", "Laraskan cara pemanduan untuk menyesuaikan keadaan", "Selesaikan perjalanan dan laporkan kemudian"]',
    1,
    'Vehicle behaviour should match inspection results.',
    'Jika kenderaan menunjukkan keadaan tidak biasa, berhenti dan periksa semula sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5dd75e18-bc96-4110-a01e-a60f5be47fa3',
    0,
    'While preparing for delivery, you notice the cargo is not fully secured and the customer is waiting.',
    'Semasa bersedia untuk penghantaran, anda mendapati muatan tidak dikunci dengan sempurna dan pelanggan sedang menunggu.',
    '["Pause and secure the cargo before proceeding", "Continue carefully and address it afterward", "Proceed to avoid delay and handle carefully", "Proceed while explaining the situation to the customer"]',
    '["Berhenti seketika dan pastikan muatan dikunci dengan betul sebelum meneruskan", "Teruskan dengan berhati-hati dan selesaikan isu kemudian", "Teruskan untuk mengelakkan kelewatan dan kendalikan dengan berhati-hati", "Teruskan sambil menerangkan keadaan kepada pelanggan"]',
    0,
    'Secure cargo before delivery despite time pressure.',
    'Pastikan muatan selamat sebelum meneruskan penghantaran walaupun terdapat tekanan masa.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '842c6f04-c1b4-43e9-8642-4b56714d342a',
    0,
    'Before entering an industrial site, you have not completed the required pre-trip inspection.',
    'Sebelum memasuki tapak industri, anda belum melengkapkan pemeriksaan pra-perjalanan kenderaan.',
    '["Enter the site carefully and complete checks later", "Complete the inspection and follow site entry rules", "Rely on previous checks and proceed as directed", "Ask site staff to guide you inside immediately"]',
    '["Masuk ke tapak dengan berhati-hati dan lakukan pemeriksaan kemudian", "Lengkapkan pemeriksaan dan patuhi peraturan kemasukan tapak", "Bergantung pada pemeriksaan sebelumnya dan teruskan seperti diarahkan", "Minta kakitangan tapak membimbing anda masuk segera"]',
    1,
    'Complete inspections before site entry to ensure readiness and compliance.',
    'Lengkapkan pemeriksaan sebelum memasuki tapak untuk memastikan kesiapsiagaan dan pematuhan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e3488c4a-567d-4270-891b-aa297ea96ccd',
    0,
    'While waiting inside a confined site area, the vehicle is idling near structures and pedestrians.',
    'Semasa menunggu di kawasan tapak yang sempit, enjin masih hidup berhampiran struktur dan pejalan kaki.',
    '["Keep the engine idling so you can move off quickly", "Switch off the engine while waiting", "Keep idling until instructed to move", "Remain stationary with the engine running"]',
    '["Biarkan enjin hidup supaya boleh bergerak segera", "Matikan enjin semasa menunggu", "Terus biarkan enjin hidup sehingga diarahkan bergerak", "Kekal berhenti dengan enjin masih hidup"]',
    1,
    'Switching off the engine when stationary reduces risk and unnecessary exposure in confined areas.',
    'Matikan enjin semasa berhenti untuk kurangkan risiko dan pendedahan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e851bcbd-a36c-488f-afc1-71af3ae47a2f',
    0,
    'During a delivery, a customer begins recording your interaction on a mobile phone.',
    'Semasa penghantaran, seorang pelanggan mula merakam interaksi anda menggunakan telefon bimbit.',
    '["Continue the discussion calm and professional", "Ask the customer to stop recording before continuing", "Keep responses brief and focus on completing the task", "Proceed with the delivery without acknowledging the recording"]',
    '["Teruskan perbincangan dengan tenang dan profesional", "Minta pelanggan berhenti merakam sebelum meneruskan", "Jawab secara ringkas dan fokus untuk selesaikan tugas", "Teruskan penghantaran tanpa mengendahkan rakaman"]',
    0,
    'Maintaining professional behaviour protects your image when interactions are visible or recorded.',
    'Kekalkan tingkah laku profesional apabila interaksi dirakam atau dilihat orang lain.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7fcf0e4b-6c77-4fa7-ac60-fad1e6e6d710',
    0,
    'During unloading, a disagreement with site staff begins to escalate over the unloading sequence.',
    'Semasa proses memunggah, berlaku perbezaan pendapat dengan kakitangan tapak mengenai turutan memunggah muatan dan keadaan mula menjadi tegang.',
    '["Pause briefly, acknowledge the concern, and suggest resolving it calmly", "Explain in detail why your unloading sequence is correct and safer", "Continue unloading quietly to avoid making the situation worse", "Justify your approach so everyone understands your reasoning"]',
    '["Berhenti seketika dan bincang dengan tenang", "Terangkan dengan panjang lebar mengapa turutan anda lebih betul dan selamat", "Teruskan proses memunggah secara senyap untuk elak keadaan menjadi lebih tegang", "Pertahankan cara anda supaya semua faham sebabnya"]',
    0,
    'Pausing and responding calmly helps defuse tension.',
    'Berhenti seketika dan beri respons dengan tenang membantu redakan ketegangan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0ac8b5a9-705a-42b8-b721-e386606dd221',
    0,
    'After unloading, someone pressures you to change delivery records so the issue does not escalate.',
    'Selepas proses memunggah, seseorang menekan anda supaya mengubah rekod penghantaran agar isu tersebut tidak menjadi lebih besar.',
    '["Say the records must stay as they are and continue calmly", "Change the records slightly so the discussion can end", "Leave the records for now to avoid further disagreement", "Explain repeatedly why the records cannot be changed"]',
    '["Nyatakan rekod mesti kekal seperti sedia ada dan teruskan dengan tenang", "Ubah sedikit rekod supaya perbincangan boleh dihentikan", "Biarkan rekod dahulu untuk elak pertelingkahan lanjut", "Terangkan berulang kali mengapa rekod tidak boleh diubah"]',
    0,
    'Keeping records accurate while staying calm helps prevent conflict from escalating.',
    'Kekalkan rekod yang tepat sambil bersikap tenang untuk elakkan keadaan menjadi lebih tegang.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1217757f-8a03-4f39-9276-1235045b945f',
    0,
    'While driving through a community area, people nearby gesture for you to slow down as you pass.',
    'Semasa melalui kawasan komuniti, orang di sekitar memberi isyarat supaya anda memperlahankan kenderaan.',
    '["Reduce speed and continue driving considerately", "Maintain your speed since you are within the limit", "Slow briefly, then resume your previous speed", "Focus ahead and avoid reacting to the gestures"]',
    '["Kurangkan kelajuan dan teruskan pemanduan dengan penuh pertimbangan", "Kekalkan kelajuan kerana masih dalam had yang dibenarkan", "Perlahankan seketika, kemudian sambung semula kelajuan asal", "Fokus ke hadapan dan abaikan isyarat tersebut"]',
    0,
    'Adjusting speed in response to community signals shows courtesy and respect for local conditions.',
    'Melaras kelajuan mengikut keadaan setempat menunjukkan sikap hormat dan prihatin terhadap komuniti.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0ed307aa-c124-4ef9-aece-427d3eb0112f',
    0,
    'In a local area, another driver gestures courteously for you to merge while traffic slows.',
    'Di kawasan tempatan, seorang pemandu memberi isyarat sopan untuk membenarkan anda masuk ketika trafik semakin perlahan.',
    '["Signal clearly and merge when safe", "Merge promptly to return the courtesy", "Hesitate briefly to avoid appearing disrespectful", "Acknowledge the gesture and continue moving"]',
    '["Beri isyarat dengan jelas dan masuk apabila selamat", "Masuk segera untuk membalas kesopanan tersebut", "Tangguh seketika supaya tidak kelihatan tidak menghormati", "Balas isyarat tersebut dan teruskan bergerak"]',
    0,
    'Clear signalling should guide merging decisions, even when courtesy is shown by others.',
    'Isyarat yang jelas dan pertimbangan keselamatan perlu menjadi panduan walaupun diberi laluan oleh pemandu lain.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fa70e3a7-be8c-4d6f-9113-63bee06fd905',
    0,
    'You plan to install a sun shade, dark tint film, or stickers on the company truck windscreen.',
    'Anda bercadang memasang pelindung matahari, filem gelap, atau pelekat pada cermin hadapan lori syarikat.',
    '["Install them if they do not block the main driving view.", "Do not install them without company approval.", "Use removable shades only during daytime driving.", "Check whether other drivers have done similar modifications."]',
    '["Pasang jika tidak menghalang pandangan utama ketika memandu.", "Jangan pasang tanpa kelulusan syarikat.", "Gunakan pelindung yang boleh ditanggalkan pada waktu siang sahaja.", "Periksa sama ada pemandu lain pernah membuat perubahan yang sama."]',
    1,
    'Avoid unauthorised vehicle modifications that may affect safety or compliance.',
    'Elakkan pengubahsuaian kenderaan tanpa kelulusan yang boleh menjejaskan keselamatan atau pematuhan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '261ba6db-afc6-4007-8c69-4c2b859f40f1',
    0,
    'You have been on duty for 10 hours and are asked to continue working.',
    'Anda telah bertugas selama 10 jam dan diminta untuk terus bekerja.',
    '["Continue if the remaining task is short.", "Stop working after reaching the 10-hour limit.", "Work another hour and rest later.", "Continue if traffic conditions are light."]',
    '["Teruskan jika baki tugasan adalah singkat.", "Hentikan bekerja selepas mencapai had 10 jam.", "Bekerja satu jam lagi dan berehat kemudian.", "Teruskan jika keadaan trafik tidak sibuk."]',
    1,
    'Adhere to the maximum daily working hour limit.',
    'Patuhi had maksimum waktu kerja harian.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3d603230-d9f0-42fc-ac1b-9d42915a3aa2',
    0,
    'Your goods vehicle is experiencing failure on a highway and you are placing safety cones behind it.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda sedang meletakkan kon keselamatan di belakangnya.',
    '["Place cones a few metres behind the vehicle to alert nearby traffic.", "Position cones to the rear, spaced about 10 metres apart.", "Place one cone directly behind the vehicle as a marker.", "Set the cones beside the vehicle to save time."]',
    '["Letakkan kon beberapa meter di belakang kenderaan untuk memberi amaran kepada trafik berhampiran.", "Letakkan kon di bahagian belakang dengan jarak kira-kira 10 meter antara satu sama lain.", "Letakkan satu kon tepat di belakang kenderaan sebagai penanda.", "Letakkan kon di sisi kenderaan untuk menjimatkan masa."]',
    1,
    'Position warning devices correctly to provide clear rear hazard warning.',
    'Letakkan alat amaran dengan jarak yang sesuai untuk memberi amaran yang jelas kepada trafik dari belakang.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '06bfb157-d4fa-45fe-b847-1d9290f97ffc',
    0,
    'During inspection, you realise the vehicle has no working torchlight.',
    'Semasa pemeriksaan, anda mendapati tiada lampu suluh yang berfungsi di dalam kenderaan.',
    '["Proceed if driving is during daytime only.", "Replace the torchlight before operating the vehicle.", "Use your phone light if needed.", "Continue since other safety items are present."]',
    '["Teruskan perjalanan jika pemanduan hanya pada waktu siang.", "Gantikan lampu suluh tersebut sebelum mengendalikan kenderaan.", "Gunakan lampu telefon bimbit jika perlu.", "Teruskan kerana peralatan keselamatan lain masih ada."]',
    1,
    'Ensure required safety equipment is present and functional.',
    'Pastikan peralatan keselamatan yang diperlukan tersedia dan berfungsi dengan baik.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd7ee9388-5b77-445a-986b-f404cc6c4a0c',
    0,
    'Before starting your trip, you review the vehicle''s licensing documents.',
    'Sebelum memulakan perjalanan, anda menyemak dokumen lesen kenderaan.',
    '["Proceed if the documents were checked last month.", "Verify that all required vehicle licences are valid.", "Continue driving and check only if stopped.", "Rely on the office to monitor document validity."]',
    '["Teruskan perjalanan jika dokumen telah diperiksa bulan lepas.", "Pastikan semua lesen kenderaan yang diperlukan masih sah.", "Terus memandu dan semak hanya jika ditahan.", "Bergantung kepada pejabat untuk memantau tempoh sah dokumen."]',
    1,
    'Ensure vehicle licensing documents are valid before operating.',
    'Pastikan semua dokumen lesen kenderaan masih sah sebelum mengendalikan kenderaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a0a6496e-5bcd-4bbe-909c-89739f3a66d5',
    0,
    'You are scheduled to begin duty at 5:00 AM.',
    'Anda dijadualkan untuk memulakan tugas pada pukul 8:00 pagi.',
    '["Arrive early to prepare before starting duty.", "Arrive exactly at 8:00 AM and prepare afterward.", "Arrive a few minutes late if traffic is light.", "Inform colleagues to cover while you arrive."]',
    '["Tiba lebih awal untuk membuat persediaan sebelum bertugas.", "Tiba tepat pukul 8:00 pagi dan buat persediaan selepas itu.", "Tiba lewat beberapa minit jika trafik lancar.", "Maklumkan rakan sekerja untuk mengambil alih tugas sementara anda tiba."]',
    0,
    'Arrive early to prepare and start duty on time.',
    'Tiba lebih awal untuk membuat persediaan dan memulakan tugas tepat pada masanya.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c2604e43-4c1a-4d45-95fd-4ca0ff21e927',
    0,
    'During a delivery, a customer raises their voice and provokes you.',
    'Semasa membuat penghantaran, seorang pelanggan meninggikan suara dan memprovokasi anda.',
    '["Respond firmly to defend your position.", "Avoid confrontation and report to operations.", "Leave the site immediately without informing anyone.", "Continue arguing until the issue is resolved."]',
    '["Bertindak balas dengan tegas untuk mempertahankan diri.", "Elakkan pertelingkahan dan laporkan kepada bahagian operasi.", "Tinggalkan tapak serta-merta tanpa memaklumkan kepada sesiapa.", "Terus berdebat sehingga isu selesai."]',
    1,
    'Do not engage in confrontation; report the matter to operations.',
    'Elakkan pertelingkahan dan laporkan perkara tersebut kepada bahagian operasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5024cea3-8ef7-4654-9aff-5e8ec9fc8e7b',
    0,
    'After a collision, the third party offers to settle repair costs privately.',
    'Selepas pelanggaran, pihak ketiga menawarkan untuk menyelesaikan kos pembaikan secara persendirian.',
    '["Accept the offer to avoid paperwork.", "Inform operations and wait for instruction.", "Negotiate and settle on the spot.", "Accept payment and continue duty."]',
    '["Terima tawaran untuk mengelakkan urusan dokumentasi.", "Maklumkan bahagian operasi dan tunggu arahan selanjutnya.", "Berunding dan selesaikan di tempat kejadian.", "Terima bayaran dan teruskan tugas."]',
    1,
    'Do not agree to private settlements without company instruction.',
    'Jangan bersetuju dengan penyelesaian persendirian tanpa arahan syarikat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '61cfd508-74f7-4dfd-8107-253e75d2de29',
    0,
    'Your vehicle is carrying chemical cargo and is involved in an accident.',
    'Kenderaan anda membawa muatan bahan kimia dan terlibat dalam kemalangan.',
    '["Inform operations of the cargo type and any hazard risk.", "Report the vehicle damage.", "Wait for emergency responders to identify the cargo.", "Mention cargo details when asked."]',
    '["Maklumkan kepada bahagian operasi jenis muatan dan sebarang risiko bahaya.", "Laporkan kerosakan kenderaan.", "Tunggu pasukan kecemasan mengenal pasti jenis muatan.", "Nyatakan butiran muatan bila ditanya."]',
    0,
    'Communicate cargo hazards immediately during an accident.',
    'Maklumkan risiko bahaya muatan dengan segera semasa kemalangan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c4280671-ffaa-4fb1-ad03-4012e7594fef',
    0,
    'You drive at cruising speed. Vehicles ahead brake intermittently and motorcycles filter between lanes.',
    'Anda memandu pada kelajuan tetap. Kenderaan di hadapan membrek dan motosikal bergerak di antara lorong.',
    '["Increase following distance for sudden slowing", "Maintain distance and brake if traffic slows", "Move closer to match the pace ahead", "Change lanes to avoid unpredictable movement"]',
    '["Tambah jarak kenderaan untuk lebih bersedia", "Kekalkan jarak dan brek jika trafik perlahan", "Bergerak lebih dekat untuk ikut kelajuan di hadapan", "Tukar lorong untuk elakkan pergerakan tidak menentu"]',
    0,
    'Extra space gives more time to respond to hazards ahead.',
    'Ruang tambahan memberi lebih masa untuk bertindak terhadap bahaya di hadapan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '159608d4-20d1-4a4e-bab6-87f6a77c5855',
    0,
    'You drive at night in heavy rain. Spray from vehicles ahead reduces visibility.',
    'Anda memandu pada waktu malam dalam keadaan hujan lebat. Percikan air dari kenderaan di hadapan mengurangkan pandangan.',
    '["Increase following distance for more reaction time", "Maintain distance since traffic speed is steady", "Close the gap to keep sight of the vehicle ahead", "Keep the same distance and react if traffic slows"]',
    '["Tambah jarak kenderaan untuk lebih masa bertindak", "Kekalkan jarak kerana kelajuan trafik stabil", "Rapatkan jarak untuk mengekalkan pandangan kenderaan di hadapan", "Kekalkan jarak dan bertindak jika trafik perlahan"]',
    0,
    'Increase spacing in poor visibility to manage sudden slowing safely.',
    'Tingkatkan jarak antara kenderaan ketika penglihatan terhad bagi menangani tindakan brek mengejut dengan selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '31e87ea9-8a5e-4bf5-acdf-5b7af29e20d5',
    0,
    'Inside a site yard, you merge into an internal lane while equipment operates nearby.',
    'Di dalam kawasan tapak, anda perlu masuk ke lorong dalaman sementara jentera beroperasi berhampiran.',
    '["Wait for a clear gap with safe equipment clearance", "Merge when a small gap appears to maintain flow", "Move forward gradually to secure space", "Follow the vehicle ahead into the lane"]',
    '["Tunggu ruang jelas dengan jarak selamat daripada jentera", "Masuk apabila terdapat ruang kecil untuk kekalkan aliran trafik", "Bergerak ke hadapan secara beransur untuk mendapatkan ruang", "Ikut kenderaan di hadapan masuk ke lorong"]',
    0,
    'Choose a clear gap and keep safe distance from operating equipment.',
    'Tunggu ruang yang jelas dan kekalkan jarak selamat dari jentera beroperasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5d8dd3e1-f414-4623-b776-2abe153044b1',
    0,
    'After a delivery, you park in a designated area where idling is prohibited.',
    'Selepas penghantaran, anda parkir di kawasan yang ditetapkan di mana enjin tidak dibenarkan hidup.',
    '["Switch off the engine and follow the parking procedure", "Leave the engine running briefly to save time", "Complete the procedure and address the engine later", "Wait in the vehicle with the engine on"]',
    '["Matikan enjin dan ikut prosedur parkir", "Biarkan enjin hidup seketika untuk menjimatkan masa", "Lengkapkan prosedur dahulu dan matikan enjin kemudian", "Tunggu di dalam kenderaan dengan enjin masih hidup"]',
    0,
    'Follow procedures and switch off the engine where idling is prohibited.',
    'Ikut prosedur dan matikan enjin di kawasan yang melarang melahu enjin.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'dea44344-6c95-4e11-8f9a-1944bc6816af',
    0,
    'While driving inside a site with pedestrians and equipment moving nearby, your phone receives a message.',
    'Semasa memandu di dalam tapak dengan pekerja dan jentera bergerak berhampiran, telefon anda menerima mesej.',
    '["Ignore the message and maintain full attention", "Check the message briefly since speed is low", "Slow down and glance when the area looks clear", "Respond quickly."]',
    '["Abaikan mesej dan kekalkan tumpuan penuh", "Periksa mesej seketika kerana kelajuan rendah", "Perlahankan dan lihat mesej apabila kawasan kelihatan selamat", "Balas mesej dengan cepat."]',
    0,
    'Avoid distractions in mixed-movement areas.',
    'Elakkan gangguan di kawasan pergerakan bercampur.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bb4afb75-3f00-45f7-8b72-0d1ac9e37446',
    0,
    'During a slow loading manoeuvre in a confined space, a nearby worker offers guidance.',
    'Semasa manuver perlahan untuk pemuatan di ruang sempit, seorang pekerja memberi panduan.',
    '["Pause and coordinate clearly with the worker before continuing", "Continue manoeuvring slowly and rely on hand signals as they appear", "Proceed carefully without engaging to avoid confusion", "Continue cautiously while listening for instructions and adjusting if needed"]',
    '["Berhenti seketika dan sesuaikan komunikasi dengan pekerja sebelum meneruskan", "Teruskan manuver perlahan dan bergantung pada isyarat tangan yang diberi", "Teruskan dengan berhati-hati tanpa berinteraksi untuk elakkan kekeliruan", "Teruskan dengan berhati-hati sambil mendengar arahan dan melaras jika perlu"]',
    0,
    'Clear coordination during manoeuvres helps prevent damage and supports safe cooperation.',
    'Koordinasi yang jelas semasa manuver membantu mencegah kerosakan dan menyokong kerjasama yang selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '25aa1de5-6069-455b-b584-670bfe038f00',
    0,
    'While moving through a busy site, you feel abnormal resistance and hear a new mechanical sound.',
    'Semasa bergerak di tapak yang sibuk, anda merasakan rintangan tidak normal dan bunyi mekanikal baharu.',
    '["Continue moving slowly to clear the area", "Stop safely, assess the issue, and proceed only when clear", "Adjust steering and throttle to maintain site flow", "Complete the movement and report the issue afterward"]',
    '["Terus bergerak perlahan untuk keluar dari kawasan itu", "Berhenti di tempat selamat, periksa keadaan, dan teruskan hanya apabila jelas selamat", "Laraskan stereng dan pendikit untuk mengekalkan aliran pergerakan tapak", "Selesaikan pergerakan dan laporkan masalah selepas itu"]',
    1,
    'Respond promptly to mechanical cues and ensure the area is safe before proceeding.',
    'Bertindak segera terhadap tanda mekanikal dan pastikan kawasan selamat sebelum meneruskan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bb4216e1-e64f-4807-aa4f-73e50ef62cc2',
    0,
    'At a site gate, you notice a wheel chock and tool left unsecured on the vehicle before entry.',
    'Di pintu masuk tapak, anda perasan pengadang tayar dan peralatan tidak diikat kemas pada kenderaan sebelum masuk.',
    '["Enter the site and secure them at the first parking point", "Secure the items before entering the site", "Proceed inside since the items are not in use", "Ask security to allow entry first"]',
    '["Masuk tapak dan kemaskan di tempat parkir pertama", "Kemaskan dahulu sebelum masuk tapak", "Terus masuk kerana alat itu tidak digunakan", "Minta kebenaran masuk daripada pengawal dahulu"]',
    1,
    'Securing loose equipment before entry prevents avoidable risks inside controlled areas.',
    'Kemaskan peralatan sebelum masuk tapak untuk elakkan risiko.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '21592ca5-bd3e-46bc-baa7-c0e09baac6ad',
    0,
    'A customer asks you to change delivery details on the paperwork.',
    'Seorang pelanggan meminta anda mengubah butiran penghantaran dalam dokumen.',
    '["Complete the paperwork accurately and explain the situation", "Adjust the delivery details as requested by the customer", "Leave the paperwork unchanged and submit it later", "Submit the paperwork as requested without explanation"]',
    '["Lengkapkan dokumen dengan tepat dan jelaskan keadaan sebenar", "Ubah butiran penghantaran seperti diminta", "Biarkan dokumen seperti itu dan serahkan kemudian", "Serahkan dokumen seperti diminta tanpa penjelasan"]',
    0,
    'Accurate documentation ensures transparency and protects everyone involved.',
    'Dokumentasi yang tepat memastikan ketelusan dan melindungi semua pihak.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '96c1b62f-9336-4b90-be32-d0c4f111699e',
    0,
    'During unloading, a tense exchange with site staff starts attracting attention from people nearby.',
    'Semasa proses memunggah, perbualan tegang dengan kakitangan tapak mula menarik perhatian orang di sekeliling.',
    '["Keep your tone calm and behaviour professional", "Explain your actions in detail so observers understand your position", "Continue the task while limiting further interaction", "Justify your response to avoid appearing at fault"]',
    '["Kekalkan nada tenang dan tingkah laku profesional", "Terangkan tindakan anda dengan terperinci supaya orang lain faham", "Teruskan tugas sambil hadkan interaksi lanjut", "Jelaskan respons anda untuk elak kelihatan bersalah"]',
    0,
    'Maintaining calm, professional behaviour protects your image when situations draw public attention.',
    'Kekalkan sikap tenang dan profesional apabila situasi menarik perhatian orang ramai.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bb8c8d2d-b66a-4a59-9b8b-a841e76e3437',
    0,
    'During a delivery, a customer explains that a small personal gift is customary in their culture.',
    'Semasa penghantaran, seorang pelanggan menjelaskan bahawa pemberian kecil peribadi adalah amalan dalam budayanya.',
    '["Decline respectfully and continue with the delivery as planned", "Accept briefly to avoid appearing disrespectful", "Delay responding and see how others handle it", "Explain carefully why such gifts can cause problems"]',
    '["Tolak dengan hormat dan teruskan penghantaran seperti dirancang", "Terima seketika supaya tidak kelihatan tidak hormat", "Tangguhkan respons dan lihat bagaimana orang lain bertindak", "Terangkan dengan teliti mengapa pemberian itu boleh menimbulkan isu"]',
    0,
    'Respecting culture does not require accepting gifts that compromise integrity.',
    'Menghormati budaya tidak bermaksud menerima pemberian yang boleh menjejaskan integriti.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '960c1603-08ee-4d9d-9569-2d1fb8668781',
    0,
    'You approach a road section with temporary cones where pedestrians are crossing near your lane.',
    'Anda menghampiri laluan yang dipasang kon sementara dengan pejalan kaki melintas berhampiran lorong anda.',
    '["Maintain correct lane position and proceed cautiously past the area", "Move closer to the lane edge to pass through more quickly", "Adjust position to follow vehicles ahead without slowing", "Focus on traffic flow and avoid reacting to people nearby"]',
    '["Kekalkan kedudukan lorong yang betul dan pandu dengan berhati-hati melalui kawasan tersebut", "Rapat ke tepi lorong untuk melepasi kawasan dengan lebih cepat", "Laraskan kedudukan mengikut kenderaan di hadapan tanpa memperlahankan", "Fokus pada aliran trafik dan abaikan orang di sekitar"]',
    0,
    'Maintaining lane discipline and caution protects pedestrians and reflects responsible public conduct.',
    'Disiplin lorong dan pemanduan berhati-hati melindungi pejalan kaki serta mencerminkan sikap bertanggungjawab di tempat awam.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '494b8928-1c87-4bdf-b49d-7bd68c306bd8',
    0,
    'You prepare to merge into a moving lane when another driver accelerates and blocks the available gap.',
    'Anda bersedia untuk masuk ke lorong yang sedang bergerak apabila seorang pemandu lain memecut dan menutup ruang yang ada.',
    '["Hold back and wait for a clearer gap", "Force the merge to assert your position", "Move closer to pressure the other driver to yield", "Gesture briefly to signal dissatisfaction"]',
    '["Tahan dan tunggu ruang yang lebih jelas serta selamat", "Paksa masuk untuk mempertahankan kedudukan anda", "Rapatkan kenderaan untuk memberi tekanan supaya pemandu lain mengalah", "Buat isyarat ringkas tanda tidak puas hati"]',
    0,
    'Waiting for a safe gap and avoiding confrontation reduces risk and prevents unnecessary conflict.',
    'Menunggu ruang yang selamat dan mengelakkan konfrontasi membantu mengurangkan risiko serta ketegangan di jalan raya.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a50ee46a-61ab-4aa5-9313-e11cd024a269',
    0,
    'You have completed 8 hours of driving for the day and one nearby delivery remains.',
    'Anda telah memandu selama 8 jam pada hari itu dan satu penghantaran berhampiran masih belum selesai.',
    '["Continue driving to complete the final delivery.", "Stop driving and report reaching the daily limit.", "Drive for another 30 minutes before stopping.", "Reduce speed and complete the delivery carefully."]',
    '["Terus memandu untuk menyelesaikan penghantaran terakhir.", "Hentikan pemanduan dan laporkan bahawa had harian telah dicapai.", "Memandu lagi selama 30 minit sebelum berhenti.", "Kurangkan kelajuan dan selesaikan penghantaran dengan berhati-hati."]',
    1,
    'Follow driving hour limits to maintain safety and compliance.',
    'Patuhi had waktu pemanduan untuk menjaga keselamatan dan pematuhan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'caa446d2-97f4-48c5-a523-6fb12024f62b',
    0,
    'You have worked six consecutive days and are scheduled for another duty.',
    'Anda telah bekerja selama enam hari berturut-turut dan dijadualkan untuk bertugas lagi.',
    '["Continue working if you feel fit.", "Take one rest day after six working days.", "Work half a day before taking leave.", "Swap shifts without taking a rest day."]',
    '["Terus bekerja jika anda berasa cergas.", "Ambil satu hari rehat selepas enam hari bekerja.", "Bekerja separuh hari sebelum mengambil cuti.", "Tukar syif tanpa mengambil hari rehat."]',
    1,
    'Take the required rest day after six consecutive working days.',
    'Ambil hari rehat yang ditetapkan selepas bekerja enam hari berturut-turut.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ad7e29d4-1584-47be-be12-01a00e0c5268',
    0,
    'Your goods vehicle is experiencing failure on a highway and you are placing a warning triangle.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda sedang meletakkan segi tiga amaran.',
    '["Place it a few metres behind the vehicle for quick visibility.", "Place it about 50 metres to the rear of the vehicle.", "Place it beside the vehicle near the shoulder.", "Hold it while standing near traffic to alert drivers."]',
    '["Letakkan beberapa meter di belakang kenderaan supaya mudah dilihat dengan cepat.", "Letakkan kira-kira 50 meter di belakang kenderaan.", "Letakkan di sisi kenderaan berhampiran bahu jalan.", "Pegang sambil berdiri berhampiran trafik untuk memberi amaran."]',
    1,
    'Position warning devices at a safe rear distance to alert approaching traffic early.',
    'Letakkan alat amaran pada jarak selamat di belakang kenderaan untuk memberi amaran awal kepada trafik yang menghampiri.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '677a1f79-f616-45aa-aa85-4eb14bda64f0',
    0,
    'You check the vehicle and the warning triangle is missing.',
    'Anda memeriksa kenderaan dan mendapati segi tiga amaran tiada.',
    '["Continue driving if hazard lights are working.", "Replace the safety triangle before departure.", "Borrow one only when needed.", "Use cones instead of a triangle."]',
    '["Terus memandu jika lampu kecemasan berfungsi.", "Gantikan segi tiga amaran sebelum memulakan perjalanan.", "Pinjam satu hanya apabila diperlukan.", "Gunakan kon sebagai ganti segi tiga amaran."]',
    1,
    'Carry the required warning triangle before operating.',
    'Bawa segi tiga amaran yang diperlukan sebelum mengendalikan kenderaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '75d3a8f3-9472-4637-a652-40cc9db14d20',
    0,
    'During inspection, you check the engine system before departure.',
    'Semasa pemeriksaan, anda memeriksa sistem enjin sebelum memulakan perjalanan.',
    '["Skip the check if the engine started normally.", "Verify the engine system as part of the safety inspection.", "Check only when warning lights appear.", "Inspect the engine only during scheduled servicing."]',
    '["Abaikan pemeriksaan jika enjin dapat dihidupkan seperti biasa.", "Sahkan sistem enjin sebagai sebahagian daripada pemeriksaan keselamatan.", "Periksa hanya apabila lampu amaran menyala.", "Periksa enjin hanya semasa servis berjadual."]',
    1,
    'Include engine system checks in daily safety inspections.',
    'Periksa sistem enjin setiap hari sebagai sebahagian daripada pemeriksaan keselamatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '47f4e87c-f313-4193-99de-95efeebadc77',
    0,
    'You are starting and completing a delivery trip.',
    'Anda memulakan dan menamatkan satu perjalanan penghantaran.',
    '["Record the meter reading only at the end of the trip.", "Record the meter reading before and after the trip.", "Record it only if fuel usage seems unusual.", "Estimate the reading based on distance travelled."]',
    '["Catat bacaan meter hanya pada akhir perjalanan.", "Catat bacaan meter sebelum dan selepas perjalanan.", "Catat hanya jika penggunaan bahan api kelihatan luar biasa.", "Anggarkan bacaan berdasarkan jarak perjalanan."]',
    1,
    'Record meter readings before and after each trip.',
    'Catat bacaan meter sebelum dan selepas setiap perjalanan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'de072f64-513d-4cc5-8d46-97dc3d336bb3',
    0,
    'While driving, a member of the public provokes you aggressively.',
    'Semasa memandu, seorang orang awam bertindak agresif dan memprovokasi anda.',
    '["React quickly to assert your position.", "Remain calm and report the incident.", "Stop and confront the person.", "Follow the person to clarify the issue."]',
    '["Bertindak segera untuk mempertahankan pendirian anda.", "Kekal tenang dan laporkan kejadian tersebut.", "Berhenti dan bersemuka dengan individu tersebut.", "Ikut individu tersebut untuk menjelaskan keadaan."]',
    1,
    'Avoid impulsive actions and report the incident appropriately.',
    'Kekal tenang dan laporkan kejadian dengan cara yang sesuai.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '12638cdf-16c6-472d-8630-b5d61a4bfb01',
    0,
    'After an accident, operations asks about injuries.',
    'Selepas kemalangan, bahagian operasi bertanya tentang kecederaan.',
    '["Confirm injuries to yourself and others involved.", "Say everyone seems fine without checking.", "Wait for medical staff to assess first.", "Report injuries after confirmed by hospital."]',
    '["Sahkan kecederaan kepada diri sendiri dan pihak yang terlibat.", "Maklumkan semua kelihatan baik tanpa membuat pemeriksaan.", "Tunggu petugas perubatan membuat penilaian terlebih dahulu.", "Laporkan kecederaan selepas disahkan oleh pihak hospital."]',
    0,
    'Provide accurate injury status information promptly.',
    'Berikan maklumat status kecederaan dengan tepat dan segera.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1e8b2c02-e0dd-47f1-b208-7cfdac863c25',
    0,
    'You prepare to change lanes in steady traffic. Motorcycles filter between lanes and traffic slows near an exit.',
    'Anda bersedia untuk menukar lorong dalam trafik lancar. Motosikal bergerak di antara lorong dan trafik perlahan berhampiran susur keluar.',
    '["Signal early and complete full mirror checks before moving", "Signal as you move and rely on others to adjust", "Check mirrors quickly and move when the lane looks clear", "Wait for traffic to stabilise before signalling"]',
    '["Beri isyarat awal dan periksa cermin sepenuhnya sebelum bergerak", "Beri isyarat semasa bergerak dan harap pemandu lain menyesuaikan diri", "Periksa cermin dengan cepat dan bergerak apabila lorong kelihatan jelas", "Tunggu trafik stabil sebelum memberi isyarat"]',
    0,
    'Signal early and complete full checks before changing lanes.',
    'Beri isyarat awal dan lakukan pemeriksaan penuh sebelum menukar lorong.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c332f335-b356-41cf-8f85-59ecf6518538',
    0,
    'You approach an industrial access road. Surfaces are uneven, obstructions present, and visibility is reduced.',
    'Anda menghampiri laluan masuk kawasan industri. Permukaan jalan tidak rata, terdapat halangan, dan pandangan terhad.',
    '["Reduce speed early and adjust your path for hazards", "Maintain a cautious pace and react if conditions worsen", "Proceed steadily while focusing on the access route", "Follow the vehicle ahead navigating the area"]',
    '["Kurangkan kelajuan lebih awal dan sesuaikan laluan untuk elakkan bahaya", "Kekalkan kelajuan berhati-hati dan bertindak jika keadaan bertambah buruk", "Terus bergerak secara stabil sambil fokus pada laluan utama", "Ikut kenderaan di hadapan yang melalui kawasan itu"]',
    0,
    'Adjust early to surface and visibility risks to maintain control.',
    'Sesuaikan pemanduan lebih awal terhadap risiko permukaan dan pandangan untuk kekalkan kawalan kenderaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3f9f7b4e-bb54-462d-9e46-11e3d6a3271f',
    0,
    'While reversing to park, your phone receives a message.',
    'Semasa mengundur untuk parkir, telefon anda menerima mesej.',
    '["Ignore the message and complete the manoeuvre", "Pause and check the message before continuing", "Continue reversing while glancing at the phone", "Stop midway and respond to the message"]',
    '["Abaikan mesej dan selesaikan manuver", "Berhenti seketika dan periksa mesej sebelum meneruskan", "Terus mengundur sambil melihat telefon", "Berhenti di tengah dan balas mesej"]',
    0,
    'Avoid device use during manoeuvres.',
    'Elakkan penggunaan telefon semasa manuver.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '48856096-fa1a-461a-9281-e9a3337fcb1a',
    0,
    'After completing your trip, you notice a minor defect that developed during the drive.',
    'Selepas selesai perjalanan, anda mendapati kerosakan kecil berlaku semasa memandu.',
    '["Report the defect and ensure the vehicle is checked before reuse", "Note the defect later since the trip is completed", "Mention it informally to the next driver", "Leave the vehicle available since it still operates"]',
    '["Laporkan kerosakan dan pastikan kenderaan diperiksa sebelum digunakan semula", "Catat kerosakan kemudian kerana perjalanan telah selesai", "Beritahu secara tidak rasmi kepada pemandu seterusnya", "Biarkan kenderaan digunakan kerana masih boleh beroperasi"]',
    0,
    'Report defects promptly to prevent risk in the next operation.',
    'Laporkan kerosakan dengan segera untuk mengelakkan risiko dalam operasi seterusnya.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '623b86f2-9239-4f96-a951-1d005467a338',
    0,
    'After a trip, you identify a minor defect before completing the handover documentation.',
    'Selepas tamat perjalanan, anda mengesan kerosakan kecil sebelum melengkapkan dokumentasi serahan kenderaan.',
    '["Record the defect accurately and submit the documentation", "Submit the documentation first and update the defect record later", "Delay recording the defect until the next scheduled inspection", "Note the defect informally and proceed with documentation"]',
    '["Rekodkan kerosakan dengan tepat dan serahkan dokumentasi", "Serahkan dokumentasi dahulu dan kemas kini rekod kerosakan kemudian", "Tangguhkan merekod kerosakan sehingga pemeriksaan seterusnya", "Catat kerosakan secara tidak rasmi dan teruskan dokumentasi"]',
    0,
    'Defects must be formally recorded to ensure proper documentation and accountability.',
    'kerosakan mesti direkod secara rasmi untuk memastikan dokumentasi dan akauntabiliti yang betul.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1f1e6c77-59f2-42ee-95a8-8706f32629ad',
    0,
    'While moving on a wet, uneven surface, you notice abnormal vibration and reduced vehicle response.',
    'Semasa bergerak di permukaan basah dan tidak rata, anda merasakan getaran tidak normal dan tindak balas kenderaan berkurang.',
    '["Maintain steady movement to avoid wheel slip", "Stop and assess before continuing", "Adjust speed slightly and continue through the area", "Complete the movement and report the issue later"]',
    '["Kekalkan pergerakan stabil untuk elakkan gelinciran tayar", "Berhenti dan periksa sebelum meneruskan", "Laraskan kelajuan sedikit dan teruskan melalui kawasan itu", "Selesaikan pergerakan dan laporkan masalah kemudian"]',
    1,
    'Pause to assess mechanical signals under challenging surface conditions.',
    'Berhenti dan periksa isu mekanikal dalam keadaan permukaan yang mencabar.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b307b5ef-a0b8-4e3c-8376-8a0a1f61f9d8',
    0,
    'While parked inside a site, an emergency alarm sounds and evacuation routes must be kept clear.',
    'Semasa parkir di dalam tapak, penggera kecemasan berbunyi dan laluan keluar mesti dikekalkan bebas halangan.',
    '["Remain in the cabin and wait for instructions", "Secure cabin items and clear the evacuation path immediately", "Leave the vehicle as it is and exit quickly", "Move the vehicle slightly to create more space"]',
    '["Kekal di dalam kabin dan tunggu arahan", "Pastikan barang dalam kabin tidak bergerak dan kosongkan laluan keluar segera", "Tinggalkan kenderaan seperti sedia ada dan keluar dengan cepat", "Gerakkan kenderaan sedikit untuk beri lebih ruang"]',
    1,
    'Secure loose items and clear evacuation routes immediately.',
    'Pastikan barang tidak bergerak dan kekalkan laluan keluar jelas dengan segera.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '86bee808-dc86-4c68-b246-f1f68c6ba015',
    0,
    'During a delivery, a customer follows cultural practices unfamiliar to you.',
    'Semasa membuat penghantaran, seorang pelanggan mengikut amalan budaya yang tidak biasa bagi anda.',
    '["Acknowledge the practice and respond respectfully", "Continue the task without engaging further", "Question the practice to clarify expectations", "Follow your usual approach and proceed"]',
    '["Hormati amalan tersebut dan beri respons dengan sesuai", "Teruskan tugas tanpa melibatkan diri", "Persoalkan amalan itu untuk jelaskan jangkaan", "Ikut cara biasa anda dan teruskan"]',
    0,
    'Respecting cultural differences helps maintain positive and professional interactions.',
    'Menghormati perbezaan budaya membantu kekalkan interaksi yang profesional dan baik.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd4fb8920-6fa8-4b44-aebd-251490465022',
    0,
    'During unloading, site staff suggest recording different details on the delivery documents to save time.',
    'Semasa proses memunggah, kakitangan tapak mencadangkan supaya butiran pada dokumen penghantaran direkod berbeza untuk jimat masa.',
    '["Record the actual details accurately", "Adjust the details slightly so unloading can finish smoothly", "Note the change later to keep the paperwork acceptable", "Leave the documents for someone else to complete"]',
    '["Catat butiran yang sebenarnya dengan tepat", "Ubah sedikit butiran supaya proses memunggah selesai dengan lancar", "Catat perubahan kemudian supaya dokumen masih kelihatan boleh diterima", "Biarkan dokumen untuk disiapkan oleh orang lain"]',
    0,
    'Recording accurate details supports accountability and prevents issues later.',
    'Merekod butiran dengan tepat membantu pastikan tanggungjawab jelas dan elakkan masalah pada masa akan datang.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd5289bb6-5968-496a-9a9a-a5eb6346b7ca',
    0,
    'During a delivery, a cultural misunderstanding causes tension between you and the customer.',
    'Semasa penghantaran, berlaku salah faham berkaitan budaya yang menyebabkan ketegangan antara anda dan pelanggan.',
    '["Acknowledge the concern respectfully and respond calmly", "Explain your intentions in detail to clear the misunderstanding", "Step back from the discussion to prevent further discomfort", "Defend your position to avoid being seen as disrespectful"]',
    '["Ambil maklum dengan hormat dan beri respons dengan tenang", "Terangkan niat anda dengan terperinci untuk jelaskan salah faham", "Undur diri daripada perbincangan untuk elak keadaan menjadi lebih tidak selesa", "Pertahankan pendirian supaya tidak dianggap tidak hormat"]',
    0,
    'Respectful acknowledgement and calm response help ease tension caused by misunderstandings.',
    'Pengakuan yang hormat dan respons yang tenang membantu redakan ketegangan akibat salah faham.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'dbdf9adf-ae20-436b-b002-c209366de0b2',
    0,
    'You are holding your lane in slow traffic when another driver begins tailgating and sounding the horn.',
    'Anda mengekalkan lorong dalam trafik perlahan apabila pemandu di belakang mula mengekori rapat dan membunyikan hon.',
    '["Maintain your lane position and avoid reacting to the behaviour", "Shift position slightly to signal cooperation and reduce tension", "Change lanes quickly to get away from the situation", "Gesture briefly to show you have noticed the other driver"]',
    '["Kekalkan kedudukan lorong dan elakkan memberi respons", "Ubah sedikit kedudukan untuk menunjukkan kerjasama dan mengurangkan ketegangan", "Tukar lorong dengan cepat untuk menjauhkan diri daripada situasi", "Buat isyarat ringkas untuk menunjukkan anda sedar akan kehadirannya"]',
    0,
    'Holding lane discipline and not reacting helps prevent aggressive situations from escalating.',
    'Mengekalkan disiplin lorong dan tidak bertindak balas membantu mengelakkan situasi agresif daripada menjadi lebih tegang.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '96abe3eb-e024-4378-8677-1b55f00cee1d',
    0,
    'You spot debris ahead and slow early, while vehicles behind continue approaching at speed.',
    'Anda terlihat objek di atas jalan di hadapan lalu memperlahankan kenderaan lebih awal, sementara kenderaan di belakang masih menghampiri dengan laju.',
    '["Ease off smoothly and press brakes smoothly to warn others", "Maintain speed to avoid confusing traffic behind", "Brake later so following vehicles react together", "Slow suddenly once the debris is closer"]',
    '["Perlahankan kenderaan secara beransur supaya lampu brek memberi amaran kepada kenderaan belakang", "Kekalkan kelajuan supaya tidak mengelirukan trafik di belakang", "Brek kemudian supaya kenderaan belakang bertindak serentak", "Perlahankan kenderaan secara mengejut apabila objek semakin hampir"]',
    0,
    'Early slowing with clear signals helps other drivers adjust safely to hazards ahead.',
    'Memperlahankan kenderaan lebih awal membantu memberi amaran awal kepada pemandu lain dan membolehkan mereka menyesuaikan diri dengan selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.25, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '599a9da2-35f3-49fb-bf57-82fd032cd5dc',
    0,
    'You have been on duty for 10 hours and are asked to continue working.',
    'Anda telah bertugas selama 10 jam dan diminta untuk terus bekerja.',
    '["Continue if the remaining task is short.", "Stop working after reaching the 10-hour limit.", "Work another hour and rest later.", "Continue if traffic conditions are light."]',
    '["Teruskan jika baki tugasan adalah singkat.", "Hentikan kerja selepas mencapai had 10 jam.", "Bekerja satu jam lagi dan berehat kemudian.", "Teruskan jika keadaan trafik ringan."]',
    1,
    'Adhere to the maximum daily working hour limit.',
    'Patuhi had maksimum waktu kerja harian.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2233ab20-dc2f-4dd7-a07b-d6a97c932523',
    0,
    'While driving, you notice the sun shade and stickers on the windscreen reduce your side visibility.',
    'Semasa memandu, anda mendapati pelindung matahari dan pelekat pada cermin hadapan mengurangkan penglihatan sisi.',
    '["Continue driving carefully despite reduced visibility.", "Stop at a safe location and remove or adjust the obstruction.", "Reduce speed and rely more on mirrors.", "Adjust your lane position to compensate for the blind area."]',
    '["Terus memandu dengan berhati-hati walaupun penglihatan terhad.", "Berhenti di lokasi yang selamat dan tanggalkan/laraskan halangan tersebut.", "Kurangkan kelajuan dan lebih bergantung pada cermin sisi.", "Laraskan kedudukan lorong untuk mengimbangi kawasan yang terhalang."]',
    1,
    'Ensure full visibility before continuing to drive safely.',
    'Pastikan penglihatan jelas sepenuhnya sebelum meneruskan pemanduan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '14e47de3-34fa-43d9-aff0-190847213877',
    0,
    'Your goods vehicle is experiencing failure on a highway and assistance has arrived.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan bantuan telah tiba.',
    '["Leave the vehicle where it stopped since help is present.", "Move the vehicle to a safer location when possible.", "Wait until traffic reduces before relocating.", "Relocate only if other drivers signal it is safe."]',
    '["Biarkan kenderaan di tempat ia berhenti kerana bantuan telah tiba.", "Alihkan kenderaan ke lokasi yang lebih selamat jika keadaan mengizinkan.", "Tunggu sehingga trafik berkurangan sebelum mengalihkan kenderaan.", "Alihkan hanya jika pemandu lain memberi isyarat selamat."]',
    1,
    'Relocate the vehicle to minimise continued traffic exposure.',
    'Alihkan kenderaan ke lokasi lebih selamat untuk mengurangkan pendedahan berterusan kepada trafik.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2f5ec742-6a09-48f7-b018-a7760aeb988f',
    0,
    'You find that the first aid kit is incomplete.',
    'Anda mendapati kit pertolongan cemas tidak lengkap.',
    '["Continue if no emergency is expected.", "Replenish the first aid kit before operating.", "Rely on site facilities if needed.", "Inform later after completing the trip."]',
    '["Teruskan perjalanan jika tiada kecemasan dijangka berlaku.", "Lengkapkan kit pertolongan cemas sebelum mengendalikan kenderaan.", "Bergantung kepada kemudahan di lokasi jika perlu.", "Maklumkan kemudian selepas menamatkan perjalanan."]',
    1,
    'Maintain a complete and ready first aid kit at all times.',
    'Pastikan kit pertolongan cemas sentiasa lengkap dan sedia digunakan pada setiap masa.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '97499c0f-31e2-4833-8bfb-99ab59f8d904',
    0,
    'Before departure, you conduct a safety inspection.',
    'Sebelum memulakan perjalanan, anda menjalankan pemeriksaan keselamatan.',
    '["Focus only on tyres since they wear faster.", "Check brakes, tyres, steering, and vehicle lights.", "Inspect brakes only if carrying heavy cargo.", "Check lights after beginning the journey."]',
    '["Periksa tayar sahaja kerana ia lebih cepat haus.", "Periksa brek, tayar, stereng dan lampu kenderaan.", "Periksa brek hanya jika membawa muatan berat.", "Periksa lampu selepas memulakan perjalanan."]',
    1,
    'Inspect all critical control and lighting systems before driving.',
    'Periksa semua sistem kawalan dan lampu sebelum memandu.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '79c15621-c6df-443f-92f0-1f5b968e03dd',
    0,
    'Your driving document will expire in three weeks.',
    'Dokumen pemanduan anda akan tamat tempoh dalam tiga minggu.',
    '["Renew it two weeks before expiry.", "Renew it on your next off day.", "Renew it when you have free time.", "Renew it during the expiry week."]',
    '["Perbaharui dua minggu sebelum tamat tempoh.", "Perbaharui pada hari cuti anda yang seterusnya.", "Perbaharui apabila ada masa lapang.", "Perbaharui pada minggu tamat tempoh."]',
    0,
    'Renew required documents at least two weeks before expiry.',
    'Perbaharui dokumen yang diperlukan sekurang-kurangnya dua minggu sebelum tamat tempoh.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd5106e04-89a5-40e8-ab8f-46b204dc6d9b',
    0,
    'After completing your assignment, you are returning the vehicle.',
    'Selepas menamatkan tugasan, anda hendak memulangkan kenderaan.',
    '["Park the truck at any available space nearby.", "Park the truck at the company''s designated area.", "Leave the truck where it is most convenient.", "Park outside temporarily and inform later."]',
    '["Parkir lori di mana-mana ruang yang tersedia berhampiran.", "Parkir lori di kawasan yang ditetapkan oleh syarikat.", "Tinggalkan lori di tempat yang paling mudah.", "Parkir di luar buat sementara dan maklumkan kemudian."]',
    1,
    'Park company vehicles only at approved locations.',
    'Parkir kenderaan syarikat hanya di lokasi yang diluluskan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '100c73df-9165-4a44-b1c0-2389b17e03cf',
    0,
    'A roadside altercation with a member of the public escalates and feels unsafe.',
    'Berlaku pertelingkahan di tepi jalan dengan orang awam dan keadaan menjadi tidak selamat.',
    '["Handle the matter personally.", "Go to the nearest police station and report.", "Ignore it and continue driving.", "Confront the individual to settle it."]',
    '["Uruskan sendiri situasi tersebut.", "Pergi ke balai polis terdekat dan buat laporan.", "Abaikan dan teruskan pemanduan.", "Bersemuka untuk menyelesaikan isu."]',
    1,
    'Seek police assistance when safety is threatened.',
    'Dapatkan bantuan polis apabila keselamatan terancam.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9e654247-8ce8-4bab-8c22-19762653b483',
    0,
    'After a collision, operations asks whether the vehicle can be moved.',
    'Selepas pelanggaran, bahagian operasi bertanya sama ada kenderaan boleh dialihkan.',
    '["Inform whether the vehicle can be moved or is blocking traffic.", "Move the vehicle without informing anyone.", "Leave it as it is and end the call.", "Decide later after completing documentation."]',
    '["Maklumkan sama ada kenderaan boleh dialihkan atau sedang menghalang trafik.", "Alihkan kenderaan tanpa memaklumkan kepada sesiapa.", "Biarkan sahaja dan tamatkan panggilan.", "Buat keputusan kemudian selepas melengkapkan dokumen."]',
    0,
    'Inform operations about vehicle condition and obstruction status.',
    'Maklumkan keadaan kenderaan dan sama ada ia menghalang trafik.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ecae01c0-692e-4396-871c-c8c8eef95d3f',
    0,
    'While driving at the posted speed, you see motorcycles filtering between lanes and uneven braking ahead.',
    'Anda memandu pada kelajuan dibenarkan. Motosikal bergerak di antara lorong dan brek tidak sekata berlaku di hadapan.',
    '["Maintain speed and brake if traffic slows suddenly", "Reduce speed early and increase following distance", "Change lanes to avoid slower traffic ahead", "Maintain speed and focus on the vehicle ahead"]',
    '["Kekalkan kelajuan dan brek jika trafik perlahan secara tiba-tiba", "Kurangkan kelajuan lebih awal dan tambah jarak kenderaan", "Tukar lorong untuk mengelakkan trafik perlahan", "Kekalkan kelajuan dan fokus pada kenderaan di hadapan"]',
    1,
    'Reduce speed early to create time and space for sudden road changes.',
    'Kurangkan kelajuan lebih awal untuk memberi masa dan ruang apabila keadaan jalan berubah.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ff44611e-0bb9-42ee-92f3-20f70df1424b',
    0,
    'You merge from a slip road onto a busy highway. Vehicles ahead brake unevenly and motorcycles pass between lanes.',
    'Anda memasuki lebuh raya dari laluan masuk. Kenderaan di hadapan membrek tidak sekata dan motosikal bergerak di antara lorong.',
    '["Wait for a clearly safe gap before merging", "Merge and adjust speed once on the highway", "Use the gap quickly before traffic closes", "Move forward to signal intent and merge when traffic slows"]',
    '["Tunggu jarak/ruang yang benar-benar selamat sebelum masuk", "Masuk dahulu dan ubah kelajuan di lebuh raya", "Gunakan ruang dengan cepat sebelum trafik menjadi padat/sesak", "Bergerak ke hadapan untuk beri isyarat niat dan masuk apabila trafik perlahan"]',
    0,
    'Choose a safe gap to avoid sudden braking and conflict during merging.',
    'Pilih jarak yang selamat untuk mengelakkan brek mengejut dan konflik semasa masuk ke lebuh raya.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e24a6f5f-e0d3-44d3-aa31-5860172971b4',
    0,
    'You need to reverse into a marked bay inside a site. Space is tight, visibility is limited, and vehicles move nearby.',
    'Anda perlu mengundur ke petak bertanda di dalam tapak. Ruang sempit, pandangan terhad, dan kenderaan bergerak berhampiran.',
    '["Stop and reverse only when visibility and clearance are confirmed", "Reverse slowly while checking mirrors and adjusting position", "Continue reversing to avoid delaying vehicles behind", "Reverse carefully and rely on others to keep clear"]',
    '["Berhenti dan undur hanya apabila pandangan dan ruang selamat dipastikan", "Undur perlahan sambil periksa cermin dan sesuaikan kedudukan", "Terus undur untuk elakkan melambatkan kenderaan di belakang", "Undur dengan berhati-hati dan harap orang lain menjauh"]',
    0,
    'Confirm visibility and clearance before reversing in confined areas.',
    'Pastikan pandangan dan ruang selamat sebelum mengundur di kawasan sempit.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd75176a7-104e-473e-8087-3670d743745c',
    0,
    'You approach a terminal gate where vehicles queue across multiple lanes.',
    'Anda menghampiri pintu masuk terminal. Kenderaan beratur di beberapa lorong.',
    '["Remain in the assigned lane and follow the gate process", "Shift to a faster lane when another vehicle is processed", "Move forward gradually as space opens ahead", "Follow the vehicle ahead through the gate"]',
    '["Kekal di lorong yang ditetapkan dan ikut proses di pintu masuk", "Tukar ke lorong lebih laju apabila kenderaan lain sedang diproses", "Bergerak ke hadapan secara beransur-ansur apabila ruang terbuka", "Ikut kenderaan di hadapan melalui pintu masuk"]',
    0,
    'Remain in your lane and follow gate instructions to keep entry orderly.',
    'Kekalkan lorong dan patuhi arahan pintu masuk untuk memastikan kemasukan teratur.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '91928863-04c2-489a-84be-eec4bb3f0515',
    0,
    'Inside a site yard, a marshal instructs you to hold while vehicles reposition nearby.',
    'Di kawasan tapak, seorang marshal mengarahkan anda supaya berhenti sementara kenderaan berhampiran sedang mengubah kedudukan.',
    '["Hold position and continue checking mirrors and blind spots", "Signal and edge forward slightly to prepare to move", "Adjust position gradually while watching the marshal", "Follow nearby vehicles once they begin moving"]',
    '["Kekal berhenti dan terus periksa cermin serta titik buta", "Beri isyarat dan bergerak sedikit ke hadapan sebagai persediaan bergerak", "Sesuaikan kedudukan secara beransur sambil memerhati marshal", "Ikut pergerakan kenderaan berhampiran apabila ia mula bergerak"]',
    0,
    'Follow marshal instructions while maintaining situational awareness.',
    'Patuhi arahan marshal sambil kekalkan kesedaran persekitaran.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b27d448e-ff2d-46dd-9c69-c284db89751e',
    0,
    'You queue to mount a container onto your trailer. The vehicle ahead is still aligning and the area is congested.',
    'Anda beratur untuk loading/offloading kontena ke atas treler. Kenderaan di hadapan masih melaras kedudukan dan kawasan sesak.',
    '["Maintain spacing and wait until the mounting area is clear", "Move closer to prepare once the vehicle ahead finishes", "Close the gap slowly to reduce waiting time", "Follow ground staff signals to approach closely"]',
    '["Kekalkan jarak dan tunggu sehingga kawasan loading/offloading kosong", "Bergerak lebih dekat untuk bersedia apabila kenderaan di hadapan selesai", "Rapatkan jarak perlahan untuk kurangkan masa menunggu", "Ikut isyarat pekerja tapak untuk menghampiri sedekat mungkin"]',
    0,
    'Maintain spacing during container mounting operations.',
    'Kekalkan jarak semasa operasi loading/offloading kontena.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2efd61d5-a750-42af-87e7-d30a13fcae19',
    0,
    'You approach a terminal gate where entry requires credential verification. One credential is no longer valid.',
    'Anda menghampiri pintu masuk terminal yang memerlukan pengesahan pas akses. Satu akses tidak lagi sah.',
    '["Stop the entry process and report the issue", "Proceed with entry and resolve the issue inside", "Wait to see if the gate allows access", "Continue toward the gate since the trip is scheduled"]',
    '["Hentikan proses masuk dan laporkan masalah tersebut", "Teruskan masuk dan selesaikan isu di dalam terminal", "Tunggu untuk melihat sama ada pintu membenarkan masuk", "Terus menuju ke pintu masuk kerana perjalanan telah dijadualkan"]',
    0,
    'Valid credentials are required before terminal entry.',
    'Dokumen akses yang sah diperlukan sebelum memasuki terminal.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '370e7b0b-31e0-4a9d-86f9-ff855d8a45ac',
    0,
    'At a checkpoint, you are asked to present documents and notice the delivery time was recorded inaccurately.',
    'Di tempat pemeriksaan, anda diminta menunjukkan dokumen dan menyedari masa penghantaran direkod tidak tepat.',
    '["Present the document and clarify the timing if asked", "Hand over the document without mentioning the timing", "Explain verbally that the details are correct", "Ask for time to update the document before presenting it"]',
    '["Serahkan dokumen dan jelaskan masa jika ditanya", "Serahkan dokumen tanpa menyebut tentang masa", "Jelaskan secara lisan bahawa butiran adalah betul", "Minta masa untuk mengemas kini dokumen sebelum menyerahkannya"]',
    0,
    'Accurate documents and cooperation support smooth inspections.',
    'Dokumen yang tepat dan kerjasama membantu pemeriksaan berjalan lancar.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1ff1f59b-db08-494d-abf9-2aba004d5539',
    0,
    'While driving, the engine feels strained during acceleration though no warning lights appear.',
    'Semasa memandu, enjin terasa kurang responsive semasa memecut walaupun tiada lampu amaran menyala.',
    '["Ease acceleration and monitor the condition", "Maintain normal acceleration since no lights show", "Increase engine output to test the response", "Continue driving and act only if it worsens"]',
    '["Kurangkan pecutan dan pantau keadaan", "Kekalkan pecutan kerana tiada lampu amaran", "Tingkatkan kuasa enjin untuk menguji tindak balas", "Terus memandu dan bertindak hanya jika keadaan bertambah teruk"]',
    0,
    'Respond early to unusual vehicle performance.',
    'Bertindak awal apabila prestasi kenderaan tidak biasa.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2fc80748-a5ce-48bf-bc94-d672ad20ba0c',
    0,
    'During pre-trip inspection, you discover a brake defect before departure.',
    'Semasa pemeriksaan pra-perjalanan, anda menemui masalah pada brek sebelum berlepas.',
    '["Proceed carefully and monitor the defect during the journey", "Delay reporting until after completing the delivery", "Report the defect immediately and follow required procedures", "Ignore the defect to avoid operational delays"]',
    '["Teruskan dengan berhati-hati dan pantau masalah sepanjang perjalanan", "Tangguhkan laporan sehingga penghantaran selesai", "Laporkan masalah segera dan ikut prosedur yang ditetapkan", "Abaikan masalah untuk elakkan kelewatan operasi"]',
    2,
    'Defects must be reported before departure to ensure safety and integrity.',
    'Masalah mesti dilaporkan sebelum berlepas untuk memastikan keselamatan dan integriti.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '865bf68e-d264-4695-98a5-e7107a0d5526',
    0,
    'While waiting in an active loading zone, you notice cargo movement that may affect load stability.',
    'Semasa menunggu di zon pemuatan aktif, anda melihat pergerakan muatan yang boleh menjejaskan kestabilan muatan.',
    '["Remain in position and allow loading to continue", "Stop the process and alert site staff to address the cargo risk", "Move the vehicle slightly to reduce exposure", "Monitor the situation and proceed once loading appears stable"]',
    '["Kekal di tempat dan biarkan proses pemuatan diteruskan", "Hentikan proses dan maklumkan kakitangan tapak tentang risiko muatan", "Gerakkan kenderaan sedikit untuk mengurangkan pendedahan", "Pantau keadaan dan teruskan apabila pemuatan kelihatan stabil"]',
    1,
    'Address cargo instability promptly to prevent incidents in loading areas.',
    'Tangani ketidakstabilan muatan dengan segera untuk mengelakkan insiden di kawasan pemuatan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e4f9d960-17b4-47c2-bf0a-0f0f28d4899d',
    0,
    'A customer questions a delivery delay and speaks to you in a frustrated tone.',
    'Seorang pelanggan mempersoalkan kelewatan penghantaran dan bercakap dengan nada tidak puas hati.',
    '["Respond briefly and focus on completing the delivery", "Explain the situation calmly and confirm the next steps", "Defend your actions and point out factors beyond your control", "Avoid discussion and direct the customer to the office"]',
    '["Jawab secara ringkas dan fokus untuk selesaikan penghantaran", "Terangkan keadaan dengan tenang dan sahkan langkah seterusnya", "Pertahankan tindakan anda dan jelaskan faktor di luar kawalan", "Elakkan perbincangan dan arahkan pelanggan ke pejabat"]',
    1,
    'Calm, clear explanation helps reduce frustration and keeps the interaction professional.',
    'Penjelasan yang tenang dan jelas membantu kurangkan ketegangan dan kekalkan profesionalisme.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '485b0efc-3063-4edb-88a1-302949f6f571',
    0,
    'A colleague suggests you keep quiet about a major issue to avoid attention from management.',
    'Seorang rakan sekerja mencadangkan supaya anda berdiam diri tentang satu isu besar untuk elakkan perhatian pihak pengurusan.',
    '["Explain clearly why the issue should be reported", "Agree to stay quiet to keep things smooth", "Avoid responding and let the matter pass", "Say little and continue with your work"]',
    '["Jelaskan dengan terang mengapa isu itu perlu dilaporkan", "Setuju untuk berdiam diri supaya keadaan kekal tenang", "Elakkan memberi respons dan biarkan perkara itu berlalu", "Kurangkan bercakap dan teruskan kerja anda"]',
    0,
    'Clear communication and honesty help prevent larger problems later.',
    'Komunikasi yang jelas dan jujur membantu elakkan masalah menjadi lebih besar.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '10f4a839-33e6-4895-9af1-164815ab6e7b',
    0,
    'While parked in a public area, a bystander hints that a small payment could allow special access.',
    'Semasa parkir di kawasan awam, seorang individu menyatakan bahawa bayaran kecil boleh membolehkan akses khas.',
    '["Decline politely and continue following normal procedures", "Consider the request since it may avoid inconvenience to others", "Delay responding and see if the situation resolves itself", "Suggest discussing the matter later to keep things moving"]',
    '["Tolak dengan sopan dan ikut prosedur biasa", "Pertimbangkan permintaan itu kerana mungkin elakkan kesulitan", "Tangguhkan respons dan lihat perkembangan keadaan", "Cadangkan bincang perkara itu kemudian supaya urusan dapat diteruskan"]',
    0,
    'Refusing improper offers protects integrity and maintains public trust.',
    'Menolak tawaran yang tidak sesuai membantu kekalkan integriti dan kepercayaan orang awam.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1637ba0c-5f44-4e6e-9327-c45496f2be59',
    0,
    'During a delivery, a culturally sensitive interaction is happening while people nearby are watching or recording.',
    'Semasa penghantaran, berlaku interaksi sensitif berkaitan budaya dan orang sekeliling sedang melihat dan merakam.',
    '["Maintain respectful behaviour and continue professionally", "Explain your actions carefully so others do not misinterpret them", "Limit the interaction to avoid drawing further attention", "Adjust your response to match how others expect you to behave"]',
    '["Kekalkan tingkah laku yang hormat dan teruskan secara profesional", "Terangkan tindakan anda dengan teliti supaya tidak disalah tafsir", "Hadkan interaksi untuk elak menarik lebih perhatian", "Ubah respons anda mengikut jangkaan orang sekeliling"]',
    0,
    'Maintaining respectful, professional behaviour protects your image during visible interactions.',
    'Sikap hormat dan profesional membantu melindungi imej anda apabila situasi diperhatikan orang lain.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9e199a04-8f73-4441-ba5b-ef662dbcb498',
    0,
    'Traffic ahead is moving, but you keep extra distance. A customer messages asking why progress feels slow.',
    'Trafik di hadapan bergerak, namun anda mengekalkan jarak yang lebih selamat. Pelanggan menghantar mesej bertanya mengapa pergerakan agak lambat.',
    '["Maintain safe following distance and explain the situation calmly", "Close the gap slightly so movement appears faster", "Reassure the customer and focus on keeping pace", "Ignore the message and continue driving"]',
    '["Kekalkan jarak selamat dan jelaskan keadaan dengan tenang", "Rapatkan sedikit jarak supaya pergerakan nampak lebih cepat", "Yakinkan pelanggan dan cuba kekalkan kelajuan trafik", "Abaikan mesej dan teruskan pemanduan"]',
    0,
    'Keeping a safe following distance while explaining the reason supports safety and customer confidence.',
    'Mengekalkan jarak selamat sambil memberi penjelasan membantu menjaga keselamatan dan keyakinan pelanggan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7df3e598-a21b-4977-901a-d9b922e4e1db',
    0,
    'You slow early after spotting a hazard ahead. The driver behind reacts angrily and closes in.',
    'Anda memperlahankan kenderaan lebih awal selepas melihat bahaya di hadapan. Pemandu di belakang bertindak marah dan merapat.',
    '["Keep your speed steady and avoid engaging", "Speed up slightly to reduce pressure from behind", "Brake again to show there is a hazard ahead", "Gesture briefly to discourage the tailgating"]',
    '["Kekalkan kelajuan yang stabil dan elakkan memberi respons", "Tambah sedikit kelajuan untuk mengurangkan tekanan dari belakang", "Tekan brek sekali lagi untuk menunjukkan terdapat bahaya di hadapan", "Buat isyarat ringkas untuk menghalang tingkah laku tersebut"]',
    0,
    'Maintaining steady driving and avoiding engagement helps manage hazards without escalating conflict.',
    'Mengekalkan pemanduan yang stabil dan tidak bertindak balas membantu mengurus risiko tanpa menambahkan ketegangan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '35b43a04-b834-4eb5-bc2c-4742d9cbee77',
    0,
    'You have worked six consecutive days and are scheduled for another duty.',
    'Anda telah bekerja selama enam hari berturut-turut dan dijadualkan untuk bertugas lagi.',
    '["Continue working if you feel fit.", "Take one rest day after six working days.", "Work half a day before taking leave.", "Swap shifts without taking a rest day."]',
    '["Terus bekerja jika anda berasa cergas.", "Ambil satu hari rehat selepas enam hari bekerja.", "Bekerja separuh hari sebelum mengambil cuti.", "Tukar syif tanpa mengambil hari rehat."]',
    1,
    'Take the required rest day after six consecutive working days.',
    'Ambil hari rehat yang ditetapkan selepas enam hari bekerja berturut-turut.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bb4fc910-76ac-4197-9782-0577b0047155',
    0,
    'Before starting your shift, you notice dark tint film and stickers on part of the windscreen.',
    'Sebelum memulakan syif, anda mendapati terdapat filem gelap dan pelekat pada sebahagian cermin hadapan.',
    '["Leave them since they were already installed.", "Remove or report them because they may obstruct visibility.", "Start driving and adjust your seating position instead.", "Ignore them as long as the road ahead is visible."]',
    '["Biarkan kerana ia telah dipasang sebelum ini.", "Tanggalkan atau laporkan kerana ia boleh menghalang penglihatan.", "Mulakan pemanduan dan laraskan kedudukan tempat duduk.", "Abaikan selagi jalan di hadapan masih kelihatan."]',
    1,
    'Address unauthorised modifications to protect visibility and vehicle safety.',
    'Tangani pengubahsuaian tanpa kelulusan untuk menjaga penglihatan dan keselamatan kenderaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '001080fd-8513-44a1-8bb5-62e0769786fb',
    0,
    'A colleague asks to ride in your cabin as a second driver for convenience.',
    'Seorang rakan sekerja meminta untuk menaiki kabin anda sebagai pemandu kedua atas alasan kemudahan.',
    '["Allow the ride if the journey is short.", "Decline unless company authorisation is given.", "Allow the ride if the colleague is an employee.", "Permit the ride if no customers are affected."]',
    '["Benarkan jika perjalanan adalah singkat.", "Tolak kecuali terdapat kebenaran daripada syarikat.", "Benarkan jika rakan tersebut ialah pekerja syarikat.", "Benarkan jika tiada pelanggan yang terjejas."]',
    1,
    'Do not carry passengers without proper company authorisation.',
    'Jangan membawa penumpang tanpa kebenaran rasmi daripada syarikat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f1eade48-f27f-48be-9695-b39270ce4f1f',
    0,
    'You notice only three safety cones are available in the vehicle.',
    'Anda mendapati hanya tiga kon keselamatan tersedia di dalam kenderaan.',
    '["Proceed since cones are rarely used.", "Ensure five compliant safety cones are available.", "Carry additional cones only for highway trips.", "Proceed since 3 cones is enough."]',
    '["Teruskan perjalanan kerana kon jarang digunakan.", "Pastikan lima kon keselamatan yang mematuhi spesifikasi tersedia.", "Bawa kon tambahan hanya untuk perjalanan di lebuh raya.", "Teruskan kerana 3 kon sudah mencukupi."]',
    1,
    'Ensure the required number of compliant safety cones is carried.',
    'Pastikan bilangan kon keselamatan yang mematuhi spesifikasi dibawa seperti yang ditetapkan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4915f575-5308-459b-a1cc-50cfc3edac35',
    0,
    'You are verifying the vehicle before loading cargo.',
    'Anda sedang mengesahkan keadaan kenderaan sebelum memuatkan kargo.',
    '["Confirm the permitted load limit before loading.", "Load first and check weight later.", "Estimate weight based on experience.", "Accept the customer''s estimate without verification."]',
    '["Sahkan had muatan yang dibenarkan sebelum memuatkan kargo.", "Muatkan terlebih dahulu dan periksa berat kemudian.", "Anggarkan berat berdasarkan pengalaman.", "Terima anggaran pelanggan tanpa pengesahan."]',
    0,
    'Confirm the permitted load limit before carrying cargo.',
    'Sahkan had muatan yang dibenarkan sebelum membawa kargo.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2333e90e-80bb-4f9d-bbdc-52dc4ae178a2',
    0,
    'You are preparing for duty.',
    'Anda sedang membuat persediaan untuk bertugas.',
    '["Wear a collared shirt before reporting for duty.", "Wear any casual T-shirt as long as it is clean.", "Wear a sleeveless shirt in hot weather.", "Change only if instructed by a supervisor."]',
    '["Pakai baju berkolar sebelum melapor diri untuk bertugas.", "Pakai mana-mana baju T kasual asalkan bersih.", "Pakai baju tanpa lengan ketika cuaca panas.", "Tukar pakaian hanya jika diarahkan oleh penyelia."]',
    0,
    'Wear proper collared attire as required for duty.',
    'Pakai pakaian berkolar yang sesuai seperti yang ditetapkan semasa bertugas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b5980698-ee84-4c46-b262-7cac511e4da4',
    0,
    'After completing your task, you still have the prime mover key.',
    'Selepas menamatkan tugasan, anda masih memegang kunci kepala lori.',
    '["Take the key home for the next shift.", "Return the key to the company as required.", "Leave the key inside the vehicle.", "Keep the key until requested."]',
    '["Bawa pulang kunci untuk syif seterusnya.", "Pulangkan kunci kepada syarikat seperti yang ditetapkan.", "Tinggalkan kunci di dalam kenderaan.", "Simpan kunci sehingga diminta."]',
    1,
    'Return vehicle keys to the company after duty.',
    'Pulangkan kunci kenderaan kepada syarikat selepas bertugas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '32d410ee-4323-455f-9bd9-50d072887426',
    0,
    'You notice a mismatch between the seal number and the gate pass record.',
    'Anda mendapati nombor seal tidak sepadan dengan rekod pada gate pass.',
    '["Proceed if the container is sealed.", "Report to operations for further instruction.", "Correct the document yourself.", "Continue if the customer is waiting."]',
    '["Teruskan jika kontena telah dimeterai.", "Laporkan kepada bahagian operasi untuk arahan selanjutnya.", "Betulkan dokumen sendiri.", "Teruskan perjalanan jika pelanggan sedang menunggu."]',
    1,
    'Report any container or seal discrepancy before proceeding.',
    'Laporkan sebarang perbezaan pada kontena atau seal sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9acdeb1c-9fba-4e11-9323-eb01a622c24f',
    0,
    'At the customer site, the container door appears misaligned.',
    'Di premis pelanggan, pintu kontena kelihatan tidak sejajar.',
    '["Record it internally and inform operations.", "Lock it and continue.", "Deliver first and explain later.", "Adjust it without reporting."]',
    '["Catat dalam rekod dalaman dan maklumkan bahagian operasi.", "Kunci pintu dan teruskan perjalanan.", "Hantar dahulu dan jelaskan kemudian.", "Laraskan tanpa melaporkan."]',
    0,
    'Report container defects before moving.',
    'Laporkan kecacatan kontena sebelum meneruskan pergerakan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0ec943b7-5606-44f5-b2c0-43e500526f9f',
    0,
    'The customer indicates a location that appears tight and near property.',
    'Pelanggan menunjukkan lokasi yang kelihatan sempit dan berhampiran harta benda.',
    '["Position quickly to minimise delay.", "Prioritise safety to prevent property damage or injury.", "Follow the instruction eventhough you have doubts.", "Ask workers to stand nearby to guide closely."]',
    '["Letakkan kontena dengan cepat untuk mengurangkan kelewatan.", "Utamakan keselamatan bagi mengelakkan kerosakan atau kecederaan.", "Teruskan walaupun anda mempunyai keraguan tentang ruang tersebut.", "Minta pekerja berdiri berhampiran untuk memberi panduan dari jarak dekat."]',
    1,
    'Prioritise safety when positioning containers on site.',
    'Utamakan keselamatan semasa meletakkan kontena di tapak.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f8b92a31-dbe3-430b-b71c-f8ecee705f68',
    0,
    'After a road collision, what should you record first?',
    'Selepas berlaku pelanggaran jalan raya, apakah yang perlu anda catat terlebih dahulu?',
    '["The exact accident location.", "The damages.", "The estimated repair cost.", "The traffic condition."]',
    '["Lokasi kemalangan yang tepat.", "Kerosakan yang berlaku.", "Anggaran kos pembaikan.", "Keadaan trafik."]',
    0,
    'Record the accident location accurately.',
    'Catat lokasi kemalangan dengan tepat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9c605124-7e41-4c45-a870-c5cedb05bd3b',
    0,
    'Your vehicle catches fire during transit.',
    'Kenderaan anda terbakar semasa dalam perjalanan.',
    '["Inform operations or the company safety team immediately.", "Attempt to control the fire fully before reporting.", "Inform the customer first.", "Report only if damage is severe."]',
    '["Maklumkan kepada bahagian operasi atau pasukan keselamatan syarikat dengan segera.", "Cuba kawal kebakaran sepenuhnya sebelum melaporkan.", "Maklumkan kepada pelanggan terlebih dahulu.", "Laporkan hanya jika kerosakan adalah serius."]',
    0,
    'Report fire incidents immediately for further instruction.',
    'Laporkan kejadian kebakaran dengan segera untuk arahan lanjut.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b0e062be-819e-4449-9baa-454f2c1df66d',
    0,
    'During initial reporting, what should you do if additional relevant details arise?',
    'Semasa laporan awal dibuat, apakah yang perlu anda lakukan jika terdapat maklumat tambahan yang berkaitan?',
    '["Share any information that supports the initial report.", "Limit information to basic facts only.", "Provide extra details only if requested later.", "Wait until writing a formal report."]',
    '["Kongsikan maklumat yang menyokong laporan awal.", "Hadkan maklumat kepada fakta asas sahaja.", "Berikan butiran tambahan hanya jika diminta kemudian.", "Tunggu sehingga menyediakan laporan rasmi."]',
    0,
    'Provide all relevant information for the initial response.',
    'Berikan semua maklumat yang berkaitan untuk tindakan awal yang tepat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b21027ee-1ad6-4bbb-96cd-0735b8fc147c',
    0,
    'You position your vehicle in a loading area where forklifts are operating.',
    'Anda meletakkan kenderaan di kawasan memuat/memunggah barang di mana forklift sedang beroperasi.',
    '["Move forward quickly and stop near loading", "Stop at a safe distance and proceed when clear", "Continue moving and rely on forklift guidance", "Park as close as possible despite limited space"]',
    '["Bergerak cepat ke hadapan dan berhenti berhampiran kawasan memuat/memunggah barang", "Berhenti pada jarak selamat dan bergerak apabila laluan sudah jelas", "Terus bergerak dan bergantung pada panduan forklift", "Parkir sedekat mungkin walaupun ruang terhad"]',
    1,
    'Keep a safe distance from active loading zones to reduce collision risk.',
    'Kekalkan jarak selamat dari kawasan kawasan pemuatan aktif untuk mengurangkan risiko pelanggaran.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b22cf67d-6ff7-4276-ac1f-5a1a81f21f20',
    0,
    'You approach a busy junction. Traffic slows and visibility is partly blocked by surrounding vehicles.',
    'Anda menghampiri persimpangan yang sibuk. Trafik perlahan dan sebahagian pandangan terhalang oleh kenderaan sekeliling.',
    '["Reduce speed early and prepare to stop", "Maintain speed and brake only if needed", "Slow slightly and move when the vehicle ahead moves", "Keep moving to clear the junction quickly"]',
    '["Kurangkan kelajuan lebih awal dan bersedia untuk berhenti", "Kekalkan kelajuan dan brek hanya jika perlu", "Perlahankan sedikit dan bergerak apabila kenderaan di hadapan bergerak", "Terus bergerak untuk melepasi persimpangan dengan cepat"]',
    0,
    'Reduce speed before junctions to respond safely to unexpected movement.',
    'Kurangkan kelajuan sebelum persimpangan untuk bertindak balas dengan selamat terhadap pergerakan mengejut.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b2b54bcb-d37d-465f-b7e6-bcf6107974d8',
    0,
    'You are on foot near your vehicle in an active loading area. Forklifts operate and stacked goods restrict visibility.',
    'Anda berjalan berhampiran kenderaan di kawasan pemunggahan aktif. Forklift beroperasi dan susunan barangan menghadkan pandangan.',
    '["Keep clear of loading paths and wait until movement settles", "Move closer to observe equipment movement", "Walk through quickly to minimise time in the area", "Stand where operators can see you and keep moving"]',
    '["Kekal jauh dari laluan pemunggahan dan tunggu sehingga pergerakan reda", "Bergerak lebih dekat untuk memerhati pergerakan jentera", "Berjalan cepat untuk kurangkan masa di kawasan itu", "Berdiri di tempat pengendali boleh nampak dan terus bergerak"]',
    0,
    'Keep clear of loading activity to avoid sudden equipment movement and blind spots.',
    'Kekalkan jarak dari aktiviti pemunggahan untuk elakkan pergerakan jentera mengejut dan kawasan titik buta.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1f25cfbc-992b-45c5-ac2f-e78632b5d06e',
    0,
    'You drive inside an industrial site where equipment operates near the roadway.',
    'Anda memandu di dalam kawasan industri di mana jentera beroperasi berhampiran laluan.',
    '["Reduce speed early and keep extra clearance from equipment", "Maintain pace and adjust if equipment enters your path", "Continue slowly to pass before equipment repositions", "Follow the vehicle ahead past the equipment"]',
    '["Kurangkan kelajuan lebih awal dan kekalkan jarak daripada jentera", "Kekalkan kelajuan dan sesuaikan jika jentera memasuki laluan anda", "Terus bergerak perlahan untuk melepasi sebelum jentera beralih", "Ikut kenderaan di hadapan melepasi jentera"]',
    0,
    'Reduce speed early and keep clear of operating equipment.',
    'Kurangkan kelajuan lebih awal dan kekalkan jarak dari jentera beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4306b0f8-1381-4f24-aa4e-6a83f7cb477e',
    0,
    'Inside a site yard, equipment operates near your path when another vehicle cuts across.',
    'Di kawasan tapak, jentera beroperasi berhampiran laluan anda dan tiba-tiba sebuah kenderaan melintas di hadapan.',
    '["Slow down, keep distance from equipment, and continue calmly", "Adjust position to regain progress while watching equipment", "Proceed steadily to clear the area quickly", "Follow the vehicle ahead closely to avoid delay"]',
    '["Perlahankan, kekalkan jarak dari jentera, dan teruskan dengan tenang", "Laraskan kedudukan untuk meneruskan pergerakan sambil memerhati jentera", "Terus bergerak untuk melepasi kawasan itu dengan cepat", "Ikut kenderaan di hadapan dengan rapat untuk elakkan kelewatan"]',
    0,
    'Maintain composure and distance near operating equipment.',
    'Kekalkan ketenangan dan jarak selamat berhampiran jentera beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '77b314e2-1cf3-4ef2-8577-a2cb63785499',
    0,
    'Before starting duty, you have not completed the required rest and are still under medication.',
    'Sebelum memulakan tugas, anda belum mendapat rehat yang cukup dan masih di bawah kesan ubat.',
    '["Delay starting duty and report the issue", "Start the trip carefully since the route is familiar", "Begin driving and stop later if you feel affected", "Proceed and take rest after your shift"]',
    '["Tangguhkan tugas dan laporkan keadaan tersebut", "Mulakan perjalanan dengan berhati-hati kerana laluan sudah biasa", "Mula memandu dan berhenti kemudian jika terasa terjejas", "Teruskan dan ambil rehat selepas tamat syif"]',
    0,
    'Confirm fitness for duty before driving.',
    'Pastikan kecergasan untuk bertugas sebelum memandu.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9b728445-53ee-495c-93a1-8017219c4c33',
    0,
    'At a site entrance, valid driving credentials are required. One required credential has expired.',
    'Di pintu masuk tapak, kelayakan memandu yang sah diperlukan. Satu kelayakan telah tamat tempoh.',
    '["Stop the entry process and report the issue", "Complete the safety induction and resolve it later", "Proceed since rules will be explained during induction", "Wait to see if access is granted"]',
    '["Hentikan proses masuk dan laporkan masalah tersebut", "Selesaikan taklimat keselamatan dan uruskan kemudian", "Teruskan masuk kerana peraturan akan diterangkan semasa taklimat", "Tunggu untuk melihat sama ada akses dibenarkan"]',
    0,
    'Valid credentials are required before site entry.',
    'Kelayakan yang sah diperlukan sebelum memasuki tapak.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '288bb33f-a017-49dc-913f-b55420e2ed89',
    0,
    'After loading at a site, procedure requires using a designated exit route.',
    'Selepas selesai memunggah keluar di tapak, prosedur memerlukan anda menggunakan laluan keluar yang ditetapkan.',
    '["Follow the designated exit route and site rules", "Take a shorter route since no traffic is visible", "Adjust your exit path to save time", "Exit based on familiarity rather than instructions"]',
    '["Ikut laluan keluar dan peraturan pergerakan tapak", "Ambil laluan lebih pendek kerana tiada trafik kelihatan", "Laraskan laluan keluar untuk menjimatkan masa", "Keluar berdasarkan kebiasaan dan bukan arahan"]',
    0,
    'Follow site exit routes and movement rules.',
    'Ikut laluan keluar dan peraturan pergerakan tapak.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '38165216-58b1-4d77-aedd-f4b4488fb45f',
    0,
    'While manoeuvring at low speed in a confined space, you notice resistance and a faint scraping sound.',
    'Semasa membuat manuver pada kelajuan rendah di ruang sempit, anda merasakan rintangan dan bunyi geseran ringan.',
    '["Stop and reassess clearance before continuing", "Proceed slowly and rely on steering to clear the space", "Apply more throttle to finish quickly", "Continue and inspect the vehicle after the manoeuvre"]',
    '["Berhenti dan semak semula ruang sebelum meneruskan", "Terus bergerak perlahan dan bergantung pada stereng", "Tekan minyak lebih untuk menyelesaikan manuver dengan cepat", "Teruskan dan periksa kenderaan selepas manuver selesai"]',
    0,
    'Stop when unusual resistance or sounds occur.',
    'Berhenti apabila terdapat rintangan atau bunyi tidak biasa.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bcf7af7a-f698-4957-9f83-aacab6daeda8',
    0,
    'During a rest stop, you notice rubbish and food containers inside the truck cabin.',
    'Semasa berhenti rehat, anda melihat sampah dan bekas makanan di dalam kabin lori.',
    '["Leave the cabin unchanged since cleanliness does not affect vehicle operation", "Clean the cabin later when the schedule is less demanding", "Clean and tidy the cabin immediately", "Remove only items that may interfere with driving controls"]',
    '["Biarkan kabin seperti itu kerana kebersihan tidak menjejaskan operasi kenderaan", "Bersihkan kabin kemudian apabila jadual kurang sibuk", "Bersihkan dan kemaskan kabin segera", "Buang hanya barang yang boleh mengganggu kawalan pemanduan"]',
    2,
    'Maintaining cabin cleanliness supports safe operation and professional standards.',
    'Menjaga kebersihan kabin menyokong operasi selamat dan mencerminkan profesionalisme.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0b90d779-993a-4f11-9932-954b59812f32',
    0,
    'While reversing slowly in a tight site area, you lose clear sight of one rear corner.',
    'Semasa mengundur perlahan di kawasan tapak yang sempit, anda hilang pandangan jelas pada satu sudut belakang.',
    '["Continue reversing slowly using mirrors", "Stop the vehicle and reassess the situation", "Turn the steering slightly and keep moving", "Rely on previous experience and continue"]',
    '["Terus mengundur perlahan menggunakan cermin", "Berhenti dan nilai semula keadaan", "Pusing stereng sedikit dan terus bergerak", "Bergantung pada pengalaman lalu dan teruskan"]',
    1,
    'Stop when visibility is uncertain to prevent damage and protect people and property.',
    'Berhenti apabila pandangan tidak jelas untuk mengelakkan kerosakan dan melindungi orang serta harta benda.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '517b9730-2212-4570-a30f-116ddedf0671',
    0,
    'During unloading, site staff give instructions abruptly while you are positioning the vehicle.',
    'Semasa memunggah muatan, kakitangan tapak memberi arahan secara tiba-tiba ketika anda sedang memposisikan kenderaan.',
    '["Respond minimally and focus only on vehicle positioning", "Acknowledge the instructions and coordinate calmly", "Challenge the tone and clarify who is responsible", "Proceed without engaging further"]',
    '["Jawab secara minimum dan fokus pada posisi kenderaan sahaja", "Akui arahan tersebut dan bekerjasama dengan tenang", "Persoalkan nada arahan dan jelaskan siapa bertanggungjawab", "Teruskan tanpa melibatkan diri"]',
    1,
    'Calm coordination helps tasks run smoothly, even when instructions are delivered abruptly.',
    'Bekerjasama dengan tenang membantu kerja berjalan lancar walaupun arahan diberi secara tiba-tiba.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a6770197-5c3c-4e48-918e-4ca627d4cb25',
    0,
    'A disagreement arises on site, and the discussion starts to become tense.',
    'Berlaku perbezaan pendapat di tapak dan perbincangan mula menjadi tegang.',
    '["Speak calmly, acknowledge concerns, and clarify next steps", "Restate your position firmly to end the discussion", "Reduce interaction and wait for the situation to pass", "Continue the task without engaging further"]',
    '["Bercakap dengan tenang dan jelaskan langkah seterusnya", "Tegaskan pendirian anda untuk tamatkan perbincangan", "Kurangkan interaksi dan tunggu keadaan reda", "Teruskan tugas tanpa melibatkan diri"]',
    0,
    'Calm acknowledgement and clear steps help prevent disagreements from escalating.',
    'Pendekatan yang tenang dan langkah yang jelas membantu elakkan keadaan menjadi lebih tegang.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ee64ccee-0e86-4f48-b84d-9947af9ea3b3',
    0,
    'In a public area, a bystander becomes upset about where your vehicle is stopped.',
    'Di kawasan awam, seorang individu berasa tidak puas hati tentang lokasi kenderaan anda berhenti.',
    '["Respond calmly, acknowledge the concern, and explain briefly", "Explain in detail why the stop is necessary and allowed", "Avoid engagement and continue the task to prevent escalation", "Justify your position firmly so the complaint does not continue"]',
    '["Beri respons tenang, ambil maklum dan jelaskan secara ringkas", "Terangkan dengan terperinci mengapa berhenti di situ perlu dan dibenarkan", "Elakkan berinteraksi dan teruskan tugas", "Pertahankan posisi anda dengan tegas supaya aduan tidak berlanjutan"]',
    0,
    'Calm acknowledgement helps ease public tension and prevents situations from escalating.',
    'Respons yang tenang dan jelas membantu redakan ketegangan dan elakkan keadaan menjadi lebih serius.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd4d763cd-6d74-40f3-9809-63e9ae9dc6f5',
    0,
    'A customer calls you during the trip and urges you to arrive faster due to a delay.',
    'Seorang pelanggan menelefon semasa perjalanan dan mendesak anda tiba lebih cepat kerana berlaku kelewatan.',
    '["Maintain a safe speed and explain your expected arrival time", "Increase speed slightly to show effort and responsiveness", "Reassure the customer and focus on reaching sooner", "Shorten the conversation and continue driving as planned"]',
    '["Kekalkan kelajuan selamat dan maklumkan anggaran masa ketibaan", "Tambah sedikit kelajuan untuk tunjuk usaha dan responsif", "Yakinkan pelanggan dan cuba sampai lebih awal", "Pendekkan perbualan dan teruskan perjalanan seperti biasa"]',
    0,
    'Maintaining safe speed while giving a clear update supports both safety and customer trust.',
    'Kekalkan kelajuan selamat sambil beri maklumat jelas bagi menjaga keselamatan dan kepercayaan pelanggan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'dea8bf60-8e8a-49ce-9c26-4b47ef290a58',
    0,
    'Traffic ahead slows sharply. You increase following distance while vehicles behind close in without warning.',
    'Trafik di hadapan menjadi perlahan secara mendadak. Anda menambah jarak hadapan sementara kenderaan di belakang semakin menghampiri tanpa amaran.',
    '["Ease off early and activate brake lights to signal slowing", "Maintain speed to avoid confusing drivers behind", "Close the gap to match traffic flow", "Brake later so others are forced to react"]',
    '["Lepaskan pedal awal dan hidupkan lampu brek untuk memberi isyarat memperlahankan kenderaan", "Kekalkan kelajuan supaya tidak mengelirukan pemandu di belakang", "Rapatkan jarak untuk mengikut aliran trafik", "Tekan brek secara mengejut supaya pemandu lain terpaksa bertindak balas"]',
    0,
    'Creating space early and signalling clearly helps others adjust safely to changing traffic conditions.',
    'Mewujudkan ruang lebih awal dan memberi isyarat dengan jelas membantu pemandu lain menyesuaikan diri dengan selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ccba75be-ab90-475a-8667-ba8fda04ac50',
    0,
    'At a junction, you prepare to turn while another vehicle approaches from the side and appears unsure of your intention.',
    'Di simpang jalan, anda bersedia untuk membelok apabila sebuah kenderaan dari sisi kelihatan tidak pasti tentang niat anda.',
    '["Signal early and complete the turn when it is safe", "Roll forward slightly to indicate you intend to go", "Wait longer to see how the other driver reacts", "Turn once there is space to avoid delaying traffic behind"]',
    '["Beri isyarat awal dan belok apabila selamat", "Gerak sedikit ke hadapan untuk menunjukkan niat", "Tunggu lebih lama untuk melihat reaksi pemandu lain", "Belok apabila ada ruang untuk mengelakkan kelewatan di belakang"]',
    0,
    'Clear signalling at junctions helps other drivers understand your intention and reduces uncertainty.',
    'Isyarat yang jelas di simpang membantu pemandu lain memahami niat anda dan mengurangkan ketidakpastian.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1d267adf-5255-40ef-86d6-dab51fa3654e',
    0,
    'While driving, you notice the sun shade and stickers on the windscreen reduce your side visibility.',
    'Semasa memandu, anda mendapati pelindung matahari dan pelekat pada cermin hadapan mengurangkan penglihatan sisi.',
    '["Continue driving carefully despite reduced visibility.", "Stop at a safe location and remove or adjust the obstruction.", "Reduce speed and rely more on mirrors.", "Adjust your lane position to compensate for the blind area."]',
    '["Terus memandu dengan berhati-hati walaupun penglihatan berkurang.", "Berhenti di lokasi selamat dan tanggalkan/laraskan halangan tersebut.", "Kurangkan kelajuan dan lebih bergantung pada cermin sisi.", "Laraskan kedudukan lorong untuk mengimbangi kawasan yang terhalang."]',
    1,
    'Ensure full visibility before continuing to drive safely.',
    'Pastikan penglihatan jelas sepenuhnya sebelum meneruskan pemanduan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5189eef1-35cf-4cb4-91f7-4220393a22ad',
    0,
    'You arrive at a customer site to uncouple the trailer on uneven, soft ground.',
    'Anda tiba di tapak pelanggan untuk membuka sambungan treler di atas permukaan tanah yang tidak rata dan lembut.',
    '["Lower the landing legs carefully and check stability after uncoupling.", "Place strong wooden planks under the landing legs before uncoupling.", "Adjust the trailer position slightly to find firmer ground before uncoupling.", "Ask site staff to observe the trailer during the process."]',
    '["Turunkan kaki sokongan dengan berhati-hati dan periksa kestabilan selepas membuka sambungan.", "Letakkan papan kayu yang kukuh di bawah kaki sokongan sebelum membuka sambungan.", "Laraskan sedikit kedudukan treler untuk mencari tanah yang lebih kukuh sebelum membuka sambungan.", "Minta kakitangan tapak memerhati treler semasa proses tersebut."]',
    1,
    'Ensure stable ground support before uncoupling to prevent trailer instability.',
    'Pastikan sokongan tanah stabil sebelum membuka sambungan bagi mengelakkan treler menjadi tidak stabil.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ed5701c3-4aaf-4cec-87b8-efb765cfebf2',
    0,
    'You are preparing to start your trip and will return later the same day.',
    'Anda sedang bersedia untuk memulakan perjalanan dan akan kembali pada hari yang sama.',
    '["Conduct inspection only before starting the trip.", "Conduct inspection only after completing the trip.", "Conduct inspections both before and after the trip.", "Conduct inspection only if a defect is suspected."]',
    '["Lakukan pemeriksaan sebelum memulakan perjalanan sahaja.", "Lakukan pemeriksaan selepas menamatkan perjalanan sahaja.", "Lakukan pemeriksaan sebelum dan selepas perjalanan.", "Lakukan pemeriksaan hanya jika terdapat tanda kerosakan."]',
    2,
    'Perform required inspections before and after every trip.',
    'Lakukan pemeriksaan yang ditetapkan sebelum dan selepas setiap perjalanan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c80d7793-d7a8-42eb-8321-2a4ca78b9682',
    0,
    'The reflective string delineators are damaged and no longer reflective.',
    'Tali delineator reflektif rosak dan tidak lagi memantulkan cahaya.',
    '["Continue if cones are available.", "Replace them with compliant reflective delineators.", "Use hazard lights instead.", "Keep them until the next inspection cycle."]',
    '["Teruskan perjalanan jika kon keselamatan tersedia.", "Gantikan dengan delineator reflektif yang mematuhi spesifikasi.", "Gunakan lampu kecemasan sebagai ganti.", "Kekalkan penggunaannya sehingga pemeriksaan seterusnya."]',
    1,
    'Maintain compliant reflective equipment for roadside safety.',
    'Pastikan peralatan reflektif yang mematuhi spesifikasi sentiasa tersedia untuk keselamatan di tepi jalan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '631c7147-fcac-4634-a52a-929c01179f72',
    0,
    'During inspection, you review emergency and fire equipment in the vehicle.',
    'Semasa pemeriksaan, anda menyemak peralatan kecemasan dan pemadam api di dalam kenderaan.',
    '["Check only for long-distance trips.", "Ensure emergency and fire equipment is complete and valid.", "Assume it is sufficient if previously used.", "Check after starting the trip."]',
    '["Periksa hanya untuk perjalanan jarak jauh.", "Pastikan peralatan kecemasan dan pemadam api lengkap dan masih sah untuk digunakan.", "Anggap mencukupi jika pernah digunakan sebelum ini.", "Periksa selepas memulakan perjalanan."]',
    1,
    'Ensure emergency and fire equipment is complete and valid before driving.',
    'Pastikan peralatan kecemasan dan pemadam api lengkap dan masih sah untuk digunakan sebelum memandu.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '81c9c3f2-de49-46ec-933d-454fb30aeb75',
    0,
    'You are dressing for your driving shift.',
    'Anda sedang berpakaian untuk syif pemanduan.',
    '["Wear long trousers as required.", "Wear shorts if the weather is hot.", "Wear track pants for comfort.", "Wear any trousers only when visiting customer sites."]',
    '["Pakai seluar panjang seperti yang ditetapkan.", "Pakai seluar pendek jika cuaca panas.", "Pakai seluar trek untuk keselesaan.", "Pakai apa-apa seluar hanya apabila melawat tapak pelanggan."]',
    0,
    'Wear long trousers as part of required duty attire.',
    'Pakai seluar panjang seperti yang ditetapkan semasa bertugas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '71f8d61d-b4e3-45df-a021-5322ec2cc00f',
    0,
    'As a driver, you must remain aware of the expiry and renewal dates of vehicle and operating documents.',
    'Sebagai seorang pemandu, anda perlu peka terhadap tarikh tamat tempoh dan pembaharuan dokumen kenderaan serta operasi.',
    '["Monitor the dates and arrange renewal before expiry.", "Wait for reminders from the office.", "Check the dates only during inspections.", "Rely on company personnel to identify expiry."]',
    '["Pantau tarikh tersebut dan uruskan pembaharuan sebelum tamat tempoh.", "Tunggu peringatan daripada pejabat.", "Semak tarikh hanya semasa pemeriksaan.", "Bergantung kepada pegawai syarikat untuk mengenal pasti tarikh tamat tempoh."]',
    0,
    'Be aware of expiry dates and renew documents before they lapse.',
    'Sentiasa peka terhadap tarikh tamat tempoh dan perbaharui dokumen sebelum tempoh sahnya berakhir.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6bbce806-e95f-4282-b4c7-c5d51a18ce0d',
    0,
    'While hauling an import container from the port, you notice a dent and scratches on the container wall.',
    'Semasa membawa kontena import dari pelabuhan, anda mendapati terdapat kesan kemek dan calar pada dinding kontena.',
    '["Record the damage in the gate pass before exiting the port.", "Inform operations after delivery.", "Record it only in the internal company form.", "Proceed since the seal is intact."]',
    '["Rekodkan kerosakan pada gate pass sebelum keluar dari pelabuhan.", "Maklumkan bahagian operasi selepas penghantaran.", "Rekodkan hanya dalam borang dalaman syarikat.", "Teruskan perjalanan kerana seal masih dalam keadaan baik."]',
    0,
    'Record visible container damage in the gate pass before leaving the port.',
    'Rekodkan sebarang kerosakan kontena yang kelihatan pada gate pass sebelum meninggalkan pelabuhan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5bee0ace-2cbb-4493-a2ca-7dee4adb5c33',
    0,
    'Before exiting the port, you compare the container number in the EIR/gate pass with the customs form and delivery note.',
    'Sebelum keluar dari pelabuhan, anda membandingkan nombor kontena dalam EIR atau gate pass dengan borang kastam dan nota penghantaran.',
    '["Proceed if the container type looks correct.", "Ensure all documents show the same container number.", "Check the number only at delivery point.", "Rely on port staff verification."]',
    '["Teruskan perjalanan jika jenis kontena kelihatan betul.", "Pastikan semua dokumen menunjukkan nombor kontena yang sama.", "Semak nombor hanya di lokasi penghantaran.", "Bergantung kepada pengesahan kakitangan pelabuhan."]',
    1,
    'Confirm container numbers match across all documents before exit.',
    'Pastikan nombor kontena sepadan dalam semua dokumen sebelum keluar dari pelabuhan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4ed55023-2cf5-4c70-8b53-d7aae7464ee8',
    0,
    'Before pulling a loaded export container, you inspect the seal.',
    'Sebelum menarik kontena eksport yang telah dimuatkan, anda memeriksa seal.',
    '["Ensure the container is sealed before departure.", "Proceed if the container door is locked.", "Seal it later at the port.", "Rely on warehouse staff confirmation."]',
    '["Pastikan kontena telah dipasang seal sebelum bertolak.", "Teruskan perjalanan jika pintu kontena telah dikunci.", "Pasang seal kemudian apabila tiba di pelabuhan.", "Bergantung kepada pengesahan kakitangan gudang."]',
    0,
    'Ensure export containers are properly sealed before movement.',
    'Pastikan kontena eksport dipasang seal dengan betul sebelum pergerakan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'afd027d1-d0b3-4547-b982-14a2354fb39b',
    0,
    'You are involved in a road collision.',
    'Anda terlibat dalam pelanggaran jalan raya.',
    '["Record the third party''s vehicle type and registration number.", "Record only the third party''s phone number.", "Take photos of the damage without recording vehicle details.", "Ask someone help to record the information for you."]',
    '["Catat jenis kenderaan dan nombor pendaftaran pihak ketiga.", "Catat nombor telefon pihak ketiga sahaja.", "Ambil gambar kerosakan tanpa merekod butiran kenderaan.", "Minta pertolongan orang lain mencatat maklumat bagi pihak anda."]',
    0,
    'Record vehicle type and registration details.',
    'Catat jenis kenderaan dan nombor pendaftaran dengan tepat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f210ab1c-8bfe-43fa-b26d-25ea94fc6b73',
    0,
    'A small fire starts near the engine compartment while parked.',
    'Semasa parkir, kebakaran kecil bermula berhampiran ruang enjin.',
    '["Use the ABC fire extinguisher if safe.", "Wait for others to assist before acting.", "Pour available water to reduce flames.", "Observe briefly before deciding."]',
    '["Gunakan alat pemadam api jenis ABC jika keadaan selamat.", "Tunggu bantuan sebelum mengambil tindakan.", "Tuang air yang ada untuk mengurangkan api.", "Perhatikan keadaan seketika sebelum membuat keputusan."]',
    0,
    'Use the appropriate extinguisher if the fire is manageable.',
    'Gunakan alat pemadam api yang sesuai jika kebakaran masih boleh dikawal dan keadaan selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8178df51-92c6-4256-b4b5-792a1a6cfc18',
    0,
    'You position your vehicle in a loading area where forklifts and pedestrians are moving.',
    'Anda meletakkan kenderaan di kawasan pemunggahan di mana forklift dan pejalan kaki sedang bergerak.',
    '["Move forward quickly before equipment approaches", "Position only when the area is clear of movement", "Continue moving slowly and watch for operator signals", "Stop close to the loading area to reduce walking"]',
    '["Bergerak cepat ke hadapan sebelum peralatan menghampiri", "Letakkan kenderaan hanya apabila kawasan itu tiada pergerakan", "Terus bergerak perlahan sambil perhatikan isyarat pengendali", "Berhenti dekat kawasan pemunggahan untuk kurangkan berjalan"]',
    1,
    'Keep clear of active loading zones to reduce collision and injury risk.',
    'Kekalkan jarak dari kawasan pemunggahan aktif untuk mengurangkan risiko pelanggaran dan kecederaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0f5aba22-14f8-4867-81be-244e77e353f9',
    0,
    'You approach a busy junction. Traffic slows unevenly and vehicles from the side edge forward.',
    'Anda menghampiri persimpangan sibuk. Trafik perlahan secara tidak sekata dan kenderaan dari sisi bergerak ke hadapan.',
    '["Hold your lane and approach at reduced speed", "Shift slightly within your lane to improve visibility", "Edge closer to discourage other vehicles", "Maintain speed and react only if a vehicle enters"]',
    '["Kekalkan lorong dan hampiri pada kelajuan rendah", "Bergerak sedikit dalam lorong untuk tingkatkan pandangan", "Bergerak lebih dekat untuk menghalang kenderaan lain", "Kekalkan kelajuan dan bertindak hanya jika kenderaan masuk"]',
    0,
    'Clear lane position and early speed control reduce conflict at junctions.',
    'Kedudukan lorong yang jelas dan kawalan kelajuan awal mengurangkan konflik di persimpangan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '846d5e88-f67d-41e4-90b5-4612ae1b38bc',
    0,
    'You approach a checkpoint inside a facility. Vehicles queue unevenly and lanes split toward inspection points.',
    'Anda menghampiri pusat pemeriksaan di dalam fasiliti. Kenderaan beratur tidak sekata dan lorong berpecah ke beberapa laluan pemeriksaan.',
    '["Remain in your lane and wait for checkpoint direction", "Shift early to a less congested lane", "Move forward and adjust position near the checkpoint", "Follow the vehicle ahead if its lane clears faster"]',
    '["Kekalkan lorong dan tunggu arahan pusat pemeriksaan", "Tukar awal ke lorong yang kurang sesak", "Bergerak ke hadapan dan sesuaikan kedudukan berhampiran pusat pemeriksaan", "Ikut kenderaan di hadapan jika lorongnya bergerak lebih cepat"]',
    0,
    'Remain orderly and wait for checkpoint direction in controlled zones.',
    'Kekalkan pergerakan teratur dan tunggu arahan pusat pemeriksaan di kawasan kawalan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '169007c0-a6cd-4ce3-a973-ea1a726b94e8',
    0,
    'You need to reverse into a tight space in a site yard. Vehicles and equipment move nearby.',
    'Anda perlu mengundur ke ruang sempit di kawasan tapak. Kenderaan dan jentera bergerak berhampiran.',
    '["Stop and reverse only when space and visibility are clear", "Reverse slowly and adjust speed as conditions change", "Complete the manoeuvre to minimise disruption", "Follow nearby vehicles to guide your reversing speed"]',
    '["Berhenti dan undur hanya apabila ruang dan pandangan jelas", "Undur perlahan dan sesuaikan kelajuan mengikut keadaan", "Selesaikan manuver untuk kurangkan gangguan kepada orang lain", "Ikut pergerakan kenderaan berhampiran untuk panduan kelajuan mengundur"]',
    0,
    'Confirm space and visibility before reversing in busy yards.',
    'Pastikan ruang dan pandangan jelas sebelum mengundur di kawasan tapak sibuk.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e2fa6cb2-99f5-41e1-82e7-03f4744ca738',
    0,
    'You approach a narrow access point inside a facility. Visibility is limited and vehicles may enter from the opposite direction.',
    'Anda menghampiri laluan masuk sempit di dalam fasiliti. Pandangan terhad dan kenderaan mungkin masuk dari arah bertentangan.',
    '["Slow early and wait until the access path is clear", "Continue forward cautiously and adjust if a vehicle appears", "Enter the access point to hold position", "Follow the vehicle ahead through the access"]',
    '["Perlahankan kenderaan lebih awal dan tunggu sehingga laluan benar-benar jelas", "Terus bergerak dengan berhati-hati dan sesuaikan jika kenderaan muncul", "Masuk ke laluan untuk menunggu", "Ikut kenderaan di hadapan melalui laluan"]',
    0,
    'Slow early and confirm the path is clear before entering.',
    'Perlahankan kenderaan lebih awal dan pastikan laluan jelas sebelum masuk.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b960e5fb-7dd6-48b9-8465-27fff6485902',
    0,
    'While driving, your phone receives a message and you are slightly above the speed limit.',
    'Semasa memandu, telefon anda menerima mesej dan anda memandu sedikit melebihi had laju.',
    '["Slow to the legal speed and ignore the message", "Maintain speed and quickly check the message", "Reduce speed slightly and read when traffic allows", "Keep speed steady and reply briefly"]',
    '["Kurangkan kelajuan ke had yang dibenarkan dan abaikan mesej tersebut", "Kekalkan kelajuan dan periksa mesej dengan cepat", "Kurangkan sedikit kelajuan dan baca apabila keadaan sesuai", "Kekalkan kelajuan dan balas mesej secara ringkas"]',
    0,
    'Follow speed limits and avoid device use while driving.',
    'Patuhi had laju dan elakkan penggunaan telefon semasa memandu.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1dd4bf7e-09fc-48fc-a532-3006026ac15c',
    0,
    'At a controlled checkpoint, valid credentials are required and one credential has expired.',
    'Di pusat pemeriksaan kawalan, kelayakan yang sah diperlukan dan satu kelayakan telah tamat tempoh.',
    '["Stop at the checkpoint and report the issue", "Proceed slowly and resolve it afterward", "Wait to see if access is granted without it", "Continue forward since monitoring appears light"]',
    '["Berhenti di pusat pemeriksaan dan laporkan masalah tersebut", "Terus bergerak perlahan dan selesaikan kemudian", "Tunggu untuk melihat sama ada akses dibenarkan tanpa kelayakan", "Terus bergerak kerana pemantauan kelihatan kurang ketat"]',
    0,
    'Stop and meet credential requirements before proceeding.',
    'Berhenti dan pastikan kelayakan dipenuhi sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8727e7c8-f10e-4656-9a35-ecfbf0008cb3',
    0,
    'At a site with active loading operations, you step out of your vehicle in the loading area without a safety helmet.',
    'Di tapak dengan operasi pemuatan aktif, anda keluar dari kenderaan di kawasan pemuatan tanpa topi keselamatan.',
    '["Put on the required PPE and keep clear of loading", "Remain where you are and rely on operators", "Move quickly through the area to reduce time", "Wait for instructions before addressing PPE"]',
    '["Pakai PPE yang diperlukan dan kekal jauh dari operasi pemuatan", "Kekal di tempat dan bergantung pada pengendali", "Bergerak cepat melalui kawasan itu untuk kurangkan masa", "Tunggu arahan dan kemudian pakai PPE"]',
    0,
    'Wear required PPE and keep clear of loading zones.',
    'Pakai PPE yang diperlukan dan kekalkan jarak dari kawasan pemuatan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '04a1938a-49eb-40bf-88ba-7a4afe9d4b9e',
    0,
    'While manoeuvring at low speed with a load, you feel the load shift and notice the vehicle is closer than expected to an obstacle.',
    'Semasa membuat manuver pada kelajuan rendah dengan muatan, anda merasakan muatan bergerak dan menyedari kenderaan lebih dekat daripada jangkaan kepada halangan.',
    '["Stop and assess if it is safe to proceed", "Proceed slowly and adjust steering to maintain clearance", "Complete the manoeuvre and check the load afterward", "Continue moving and secure the load once clear"]',
    '["Berhenti dan pastikan selamat sebelum meneruskan", "Terus bergerak perlahan dan laraskan stereng untuk kekalkan jarak", "Selesaikan manuver dan periksa muatan selepas itu", "Terus bergerak dan periksa di tempat perhentian"]',
    0,
    'Stop and reassess when load shift or clearance risk appears.',
    'Berhenti dan nilai semula apabila muatan bergerak atau jarak menjadi sempit.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '39acfd3d-eac3-4b74-adab-2886cf92d8fc',
    0,
    'While parked at a public roadside stop, your engine is running near pedestrians and nearby premises.',
    'Semasa parkir di tepi jalan awam, enjin kenderaan masih hidup berhampiran pejalan kaki dan premis berdekatan.',
    '["Keep the engine running to maintain cabin comfort", "Shut down the engine while parked", "Keep the engine running and remain inside the vehicle", "Leave the engine running briefly before moving off"]',
    '["Biarkan enjin hidup untuk keselesaan kabin", "Matikan enjin semasa parkir", "Biarkan enjin hidup dan kekal di dalam kenderaan", "Biarkan enjin hidup seketika sebelum bergerak"]',
    1,
    'Shutting down the engine when parked protects company assets and shows respect for the public.',
    'Mematikan enjin semasa parkir melindungi aset syarikat dan menunjukkan hormat kepada orang awam.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '785fdbb3-d8d7-4345-9d7c-c27cb2072e73',
    0,
    'Inside a site, you approach a junction where parked equipment limits turning space.',
    'Di dalam tapak, anda menghampiri simpang dan jentera parkir mengehadkan ruang membelok.',
    '["Continue forward and adjust steering during the turn", "Stop early and reposition for a wider, safer turn", "Follow the shortest path to clear the junction", "Move closer before deciding how to turn"]',
    '["Teruskan ke hadapan dan laras stereng semasa membelok", "Berhenti awal dan ubah posisi untuk belokan yang lebih luas dan selamat", "Ikut laluan paling pendek untuk lepasi simpang", "Bergerak lebih dekat sebelum tentukan cara membelok"]',
    1,
    'Early positioning inside sites prevents tight turns, damage, and unnecessary corrections.',
    'Posisi awal yang betul di dalam tapak membantu elakkan belokan sempit, kerosakan dan pembetulan yang tidak perlu.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ee6b10b5-7176-4a0b-9218-80739451ff67',
    0,
    'While making a delivery, members of the public are nearby and watching your interaction with the customer.',
    'Semasa membuat penghantaran, orang awam berada berdekatan dan memerhati interaksi anda dengan pelanggan.',
    '["Focus only on the customer and ignore the surroundings", "Maintain calm, respectful behaviour mindful of the public presence", "Keep the exchange short to avoid attention", "Let the customer lead the interaction tone"]',
    '["Fokus pada pelanggan sahaja dan abaikan keadaan sekeliling", "Kekalkan tingkah laku tenang dan hormat dengan mengambil kira kehadiran orang awam", "Pendekkan perbualan untuk elak perhatian", "Biarkan pelanggan tentukan nada interaksi"]',
    1,
    'Professional behaviour matters not only to the customer, but also to the public observing the interaction.',
    'Tingkah laku profesional penting bukan sahaja kepada pelanggan tetapi juga kepada orang awam yang memerhati.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3f7ce465-8ed8-494e-83af-435d4f84373b',
    0,
    'During a site discussion, you realise the conversation may be overheard or recorded.',
    'Semasa perbincangan di tapak, anda sedar perbualan mungkin didengar atau dirakam.',
    '["Speak carefully and keep the discussion professional", "Lower your voice and limit further discussion", "End the conversation and return to work", "Continue speaking as you normally would"]',
    '["Bercakap dengan berhati-hati dan kekalkan profesionalisme", "Rendahkan suara dan hadkan perbincangan", "Tamatkan perbualan dan kembali bekerja", "Terus bercakap seperti biasa"]',
    0,
    'Choosing words carefully helps protect your professional image in visible situations.',
    'Pilih kata dengan cermat untuk lindungi imej profesional di tempat umum.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ca442796-898d-44f6-bbcc-feedb1e9b19a',
    0,
    'In a public area, people nearby are watching and filming while you interact with others.',
    'Di kawasan awam, orang di sekeliling memerhati dan merakam semasa anda berinteraksi dengan orang lain.',
    '["Keep your behaviour calm and professional throughout", "Explain your actions clearly so observers understand your position", "Limit interaction and focus on finishing the task", "Respond firmly to avoid appearing uncertain"]',
    '["Kekalkan tingkah laku tenang dan profesional sepanjang masa", "Terangkan tindakan anda supaya orang yang memerhati faham", "Hadkan interaksi dan fokus selesaikan tugas", "Beri respons dengan tegas supaya tidak kelihatan ragu-ragu"]',
    0,
    'Professional behaviour matters most when actions are visible to the public.',
    'Tingkah laku profesional amat penting apabila tindakan anda dapat dilihat oleh orang awam.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '60251f84-a56f-4cea-bc12-1114c2e810cb',
    0,
    'Traffic slows unexpectedly, and a supervisor asks if you can make up time on the road.',
    'Trafik tiba-tiba menjadi perlahan dan penyelia bertanya sama ada anda boleh mengejar semula masa di jalan raya.',
    '["Keep to a safe speed and give a clear, realistic update", "Say you will try to make up time where possible", "Reassure them and focus on pushing ahead", "Keep the call short and continue driving"]',
    '["Kekalkan kelajuan selamat dan beri maklumat yang jelas serta realistik", "Beritahu bahawa anda akan cuba mengejar masa jika boleh", "Yakinkan penyelia dan fokus untuk bergerak lebih laju", "Pendekkan panggilan dan teruskan perjalanan"]',
    0,
    'Clear updates and safe driving help manage expectations without increasing risk.',
    'Maklumat yang jelas dan pemanduan selamat membantu urus jangkaan tanpa menambah risiko.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f3dc032d-e560-4f8e-bf28-14d4646966d7',
    0,
    'You increase following distance in slow traffic. The driver behind closes in and flashes headlights repeatedly.',
    'Anda menambah jarak kenderaan dalam trafik perlahan. Pemandu di belakang merapat dan berulang kali memberi lampu tinggi.',
    '["Keep your distance and continue without responding", "Ease closer to avoid further confrontation behind you", "Acknowledge the other driver briefly so they know you noticed", "Adjust your driving to discourage the behaviour"]',
    '["Kekalkan jarak dan teruskan tanpa memberi respons", "Rapatkan sedikit jarak untuk mengelakkan ketegangan di belakang", "Beri isyarat ringkas supaya pemandu lain tahu anda sedar", "Sesuaikan cara pemanduan untuk menghalang tingkah laku tersebut"]',
    0,
    'Maintaining safe distance and not reacting helps prevent tension from escalating in traffic.',
    'Mengekalkan jarak selamat dan tidak bertindak balas membantu mengelakkan ketegangan di jalan raya.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd8cd10bd-ebde-4741-9d86-7e066cc0bce5',
    0,
    'You enter a narrow roadworks zone with barriers while members of the public are standing nearby.',
    'Anda memasuki kawasan pembaikan jalan yang sempit dengan penghadang, sementara orang awam berada berhampiran.',
    '["Reduce speed early and proceed cautiously", "Maintain speed to clear the zone quickly", "Follow the vehicle ahead closely to avoid delay", "Focus on steering accuracy and ignore people nearby"]',
    '["Kurangkan kelajuan lebih awal dan lalui kawasan dengan berhati-hati", "Kekalkan kelajuan untuk melepasi kawasan dengan cepat", "Ikut rapat kenderaan di hadapan supaya tidak lewat", "Fokus pada kawalan stereng dan abaikan orang di sekitar"]',
    0,
    'Reducing speed early in high-risk areas helps protect the public and reduces potential harm.',
    'Mengurangkan kelajuan lebih awal di kawasan berisiko membantu melindungi orang awam dan mengurangkan potensi bahaya.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '917e957f-d53d-4c8a-b5bf-1e54a42f5af3',
    0,
    'Before starting your shift, you notice dark tint film and stickers on part of the windscreen.',
    'Sebelum memulakan syif, anda mendapati terdapat filem gelap dan pelekat pada sebahagian cermin hadapan.',
    '["Leave them since they were already installed.", "Remove or report them because they may obstruct visibility.", "Start driving and adjust your seating position instead.", "Ignore them as long as the road ahead is visible."]',
    '["Biarkan kerana ia telah dipasang sebelum ini.", "Tanggalkan atau laporkan kerana ia boleh menghalang penglihatan.", "Mulakan pemanduan dan laraskan kedudukan tempat duduk.", "Abaikan selagi jalan di hadapan masih kelihatan."]',
    1,
    'Address unauthorised modifications to protect visibility and vehicle safety.',
    'Tangani pengubahsuaian tanpa kelulusan untuk menjaga penglihatan dan keselamatan kenderaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3c770860-ae31-4466-942c-4b88e056dfcf',
    0,
    'Your goods vehicle is experiencing failure on a highway and there is no nearby exit.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan tiada susur keluar berhampiran.',
    '["Stop in the current lane and switch on hazard lights.", "Move the vehicle to the far left shoulder before stopping.", "Stop immediately and place warning devices behind the vehicle.", "Slow down and remain in the lane until assistance arrives."]',
    '["Berhenti di lorong semasa dan hidupkan lampu kecemasan.", "Gerakkan kenderaan ke bahu kiri paling luar sebelum berhenti.", "Berhenti serta-merta dan letakkan alat amaran di belakang kenderaan.", "Perlahankan kenderaan dan kekal di lorong sehingga bantuan tiba."]',
    1,
    'Move to a safer shoulder area to reduce exposure to traffic.',
    'Gerakkan kenderaan ke bahu jalan yang lebih selamat untuk mengurangkan risiko terdedah kepada trafik.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '24c412b2-1e27-48b2-ad9f-cadc9ec3bc9d',
    0,
    'You are loading cargo and the total weight is close to the vehicle''s permitted limit.',
    'Anda sedang memuatkan kargo dan jumlah beratnya hampir mencapai had yang dibenarkan untuk kenderaan.',
    '["Load slightly above the limit if the distance is short.", "Ensure the load remains within the permitted weight limit.", "Proceed since the excess weight is minimal.", "Accept the customer''s weight figure without verification."]',
    '["Muatkan sedikit melebihi had jika jarak adalah dekat.", "Pastikan muatan kekal dalam had berat yang dibenarkan.", "Teruskan perjalanan kerana lebihan berat adalah kecil.", "Terima angka berat pelanggan tanpa pengesahan."]',
    1,
    'Always operate within the approved weight limit.',
    'Sentiasa pastikan kenderaan beroperasi dalam had berat yang diluluskan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '80d206a6-9a5b-418c-8efa-9c65ebc5fc27',
    0,
    'You notice there is no compliant safety vest in the vehicle.',
    'Anda mendapati tiada vest keselamatan yang mematuhi spesifikasi di dalam kenderaan.',
    '["Proceed if you remain inside the vehicle.", "Ensure a compliant safety vest is available before departure.", "Wear any bright-coloured clothing instead.", "Borrow one only when entering a site."]',
    '["Teruskan perjalanan jika anda kekal berada di dalam kenderaan.", "Pastikan vest keselamatan yang mematuhi spesifikasi tersedia sebelum memulakan perjalanan.", "Pakai sebarang pakaian berwarna terang sebagai ganti.", "Pinjam vest hanya apabila memasuki tapak."]',
    1,
    'Carry the required safety vest before operating.',
    'Pastikan vest keselamatan yang diperlukan dibawa sebelum beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd6951da2-6e7d-4753-be28-4a3a2a65b5ed',
    0,
    'You arrive at a site and the nearest space is marked as a prohibited parking area.',
    'Anda tiba di tapak dan ruang terdekat ditanda sebagai kawasan larangan parkir.',
    '["Park there briefly if unloading is quick.", "Find a permitted parking space.", "Park there if other vehicles are doing the same.", "Stop there with hazard lights switched on."]',
    '["Parkir seketika jika proses menurunkan muatan adalah cepat.", "Cari ruang parkir yang dibenarkan.", "Parkir di situ jika kenderaan lain melakukan perkara yang sama.", "Berhenti di situ dengan lampu kecemasan dihidupkan."]',
    1,
    'Do not park in prohibited areas.',
    'Parkir hanya di kawasan yang dibenarkan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '04d1a8ec-1959-49fe-9a64-cdbceb5947a1',
    0,
    'Before starting duty, you are choosing your footwear.',
    'Sebelum memulakan tugas, anda memilih kasut untuk dipakai.',
    '["Wear covered shoes for duty.", "Wear slippers for short-distance trips.", "Wear sandals if driving locally.", "Change into shoes only when entering a site."]',
    '["Pakai kasut bertutup semasa bertugas.", "Pakai selipar untuk perjalanan jarak dekat.", "Pakai sandal jika memandu di kawasan setempat.", "Tukar kepada kasut hanya apabila memasuki tapak."]',
    0,
    'Wear proper shoes while on duty.',
    'Pakai kasut yang sesuai semasa bertugas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '606be5f6-a4e8-473e-bc28-5fad8be382be',
    0,
    'You have completed a delivery at a customer site.',
    'Anda telah menyelesaikan penghantaran di tapak pelanggan.',
    '["Obtain the receiver''s signature only.", "Obtain signature, company stamp, time received, and receiver''s name.", "Take a photo of the unloaded goods as proof.", "Record the delivery details after returning to the office."]',
    '["Dapatkan tandatangan penerima sahaja.", "Dapatkan tandatangan, cap syarikat, masa terima dan nama penerima.", "Ambil gambar barang yang telah diturunkan sebagai bukti.", "Rekodkan butiran penghantaran selepas kembali ke pejabat."]',
    1,
    'Ensure full and proper customer confirmation for every delivery.',
    'Pastikan pengesahan penerimaan lengkap bagi setiap penghantaran.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3ba23524-3ab1-44df-8e3a-2e592c73ba13',
    0,
    'Before exiting the port with an import container, you observe a small hole and cut mark.',
    'Sebelum keluar dari pelabuhan dengan kontena import, anda mendapati terdapat lubang kecil dan kesan potongan pada kontena.',
    '["Record the condition in the gate pass.", "Deliver first and report later.", "Ignore it if cargo is not exposed.", "Inform the customer upon arrival."]',
    '["Rekodkan keadaan tersebut pada gate pass.", "Hantar dahulu dan laporkan kemudian.", "Abaikan jika muatan tidak terdedah.", "Maklumkan kepada pelanggan apabila tiba."]',
    0,
    'Declare any container damage in the gate pass before departure.',
    'Isytiharkan sebarang kerosakan kontena pada gate pass sebelum berlepas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e51be1f4-fb1b-4048-908d-22927c44febe',
    0,
    'Before exiting the port, you notice the container number differs in one document.',
    'Sebelum keluar dari pelabuhan, anda mendapati nombor kontena berbeza pada satu dokumen.',
    '["Exit and clarify after leaving the port.", "Stop, report to operations, and wait for instruction.", "Amend the document yourself.", "Proceed if the seal number matches."]',
    '["Keluar dahulu dan jelaskan selepas meninggalkan pelabuhan.", "Berhenti, laporkan kepada bahagian operasi dan tunggu arahan lanjut.", "Pinda dokumen sendiri.", "Teruskan jika nombor seal sepadan."]',
    1,
    'Do not exit the port when container numbers mismatch.',
    'Jangan keluar dari pelabuhan apabila nombor kontena tidak sepadan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fea48174-0263-4da4-a61c-545aeff43356',
    0,
    'Before departure, you find that the export container has no seal.',
    'Sebelum bertolak, anda mendapati kontena eksport tersebut tidak mempunyai seal.',
    '["Install any available seal and proceed.", "Inform operations and wait for instruction.", "Proceed since cargo is already loaded.", "Seal it yourself without reporting."]',
    '["Pasang sebarang seal yang ada dan teruskan perjalanan.", "Maklumkan kepada bahagian operasi dan tunggu arahan lanjut.", "Teruskan perjalanan kerana muatan telah dimuatkan.", "Pasang seal sendiri tanpa membuat sebarang laporan."]',
    1,
    'Report missing seals before moving an export container.',
    'Laporkan ketiadaan seal sebelum menggerakkan atau membawa kontena.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8399d251-3bfd-4698-b9aa-294494498c7b',
    0,
    'After a collision, you are gathering information from the other driver.',
    'Selepas pelanggaran, anda mengumpul maklumat daripada pemandu lain.',
    '["Take the driver''s contact number and identification details.", "Record only the vehicle number.", "Ask them to contact your office directly.", "Leave once traffic clears."]',
    '["Ambil nombor telefon dan butiran pengenalan pemandu tersebut.", "Catat nombor pendaftaran kenderaan sahaja.", "Minta mereka hubungi pejabat anda secara terus.", "Beredar apabila trafik kembali lancar."]',
    0,
    'Obtain necessary contact and identification details.',
    'Dapatkan nombor telefon dan butiran pengenalan yang diperlukan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '801245c4-f429-40d7-babc-48ed391b2e23',
    0,
    'A fire on your vehicle becomes large and difficult to control.',
    'Kebakaran pada kenderaan anda menjadi besar dan sukar dikawal.',
    '["Contact the fire brigade immediately.", "Continue using the extinguisher repeatedly.", "Wait for operations to arrive first.", "Move the vehicle slightly before deciding."]',
    '["Hubungi pasukan bomba dengan segera.", "Terus gunakan alat pemadam api berulang kali.", "Tunggu bahagian operasi tiba dahulu.", "Gerakkan kendaraan sedikit sebelum membuat keputusan."]',
    0,
    'Contact fire brigade when the fire escalates.',
    'Hubungi bomba apabila kebakaran menjadi besar dan tidak terkawal.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'dea2a363-983e-441e-85e0-52a236023ed5',
    0,
    'You approach a site entrance from a public road. The access lane is narrow and partially obstructed.',
    'Anda menghampiri pintu masuk tapak dari jalan awam. Laluan masuk sempit dan sebahagiannya terhalang.',
    '["Maintain speed to avoid blocking traffic behind", "Slow early and proceed when the path is clear", "Move closer to assess space before stopping", "Enter the access lane and adjust position inside"]',
    '["Kekalkan kelajuan untuk elakkan menghalang trafik di belakang", "Perlahankan awal dan masuk apabila laluan jelas", "Bergerak lebih dekat untuk menilai ruang sebelum berhenti", "Masuk ke laluan dan laraskan kedudukan di dalam"]',
    1,
    'Slow early and confirm the path is clear before entering a constrained access point.',
    'Perlahankan kenderaan lebih awal dan pastikan laluan jelas sebelum memasuki laluan sempit.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2ce7ebc1-7111-4bd2-8c41-b29925c76b6a',
    0,
    'You drive at night in heavy rain on a downhill road. Visibility is reduced and vehicles ahead slow unpredictably.',
    'Anda memandu pada waktu malam dalam hujan lebat di jalan menurun. Pandangan terhad dan kenderaan di hadapan memperlahankan secara tidak menentu.',
    '["Reduce speed early for higher risk conditions", "Maintain speed and rely on headlights and braking", "Slow slightly and adjust if visibility worsens", "Keep pace with the vehicle ahead"]',
    '["Kurangkan kelajuan lebih awal kerana keadaan berisiko tinggi", "Kekalkan kelajuan dan bergantung pada lampu serta brek", "Perlahankan sedikit dan sesuaikan kelajuan jika pandangan semakin terhad", "Ikut kelajuan kenderaan di hadapan"]',
    0,
    'Reduce speed in poor visibility to maintain control.',
    'Kurangkan kelajuan apabila pandangan terhad untuk kekalkan kawalan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '675e5494-5a36-41d2-86ad-6a15990b8b50',
    0,
    'You arrive at a customer site. Access lanes are narrow and forklifts operate near the loading area.',
    'Anda tiba di tapak pelanggan. Laluan masuk sempit dan forklift beroperasi berhampiran kawasan pemuatan.',
    '["Hold back until access is clearly available", "Move forward slowly to secure a position near loading", "Approach while keeping visible to site staff", "Continue advancing to avoid delaying loading"]',
    '["Tunggu di luar sehingga laluan benar-benar jelas", "Bergerak perlahan untuk mendapatkan kedudukan berhampiran kawasan pemuatan", "Hampiri kawasan tersebut dengan memastikan anda kelihatan oleh pekerja tapak", "Terus bergerak untuk elakkan kelewatan proses pemuatan."]',
    0,
    'Keep distance from constrained access and active loading areas.',
    'Kekalkan jarak dari laluan sempit dan kawasan loading aktif.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0c45993c-c7f1-4359-90c9-ff5048c93b71',
    0,
    'You drive inside a facility. Vehicles queue ahead and forklifts operate near the roadway.',
    'Anda memandu di dalam kawasan fasiliti. Kenderaan beratur di hadapan dan forklift beroperasi berhampiran laluan.',
    '["Increase following distance and keep clear sight", "Maintain spacing and close the gap if traffic slows", "Reduce the gap to avoid blocking vehicles behind", "Match the distance used by surrounding vehicles"]',
    '["Tambah jarak kenderaan dan kekalkan pandangan jelas", "Kekalkan jarak dan rapatkan jika trafik perlahan", "Rapatkan jarak untuk elakkan menghalang kenderaan di belakang", "Ikut jarak yang digunakan oleh kenderaan sekeliling"]',
    0,
    'Maintain extra spacing and clear sight near operating equipment.',
    'Kekalkan jarak tambahan dan pandangan jelas berhampiran jentera beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9b8672c3-39f6-4ba6-9f93-229a1541ceb1',
    0,
    'You approach a busy site exit joining a public road. Space is tight and reversing may be needed to realign.',
    'Anda menghampiri pintu keluar tapak yang bersambung dengan jalan awam. Ruang sempit dan mungkin perlu mengundur untuk melaras kedudukan.',
    '["Edge forward to secure position and adjust if needed", "Stop, assess, and reverse slowly under control", "Use the horn and continue moving", "Reverse quickly before vehicles arrive"]',
    '["Bergerak sedikit ke hadapan untuk mendapatkan kedudukan", "Berhenti, nilai keadaan, dan undur perlahan dengan kawalan", "Gunakan hon dan terus bergerak", "Undur dengan cepat sebelum kenderaan tiba"]',
    1,
    'Stop and maintain full control before reversing near junctions.',
    'Berhenti dan kekalkan kawalan penuh sebelum mengundur berhampiran persimpangan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ef4833d3-2078-4b4f-9df2-1fc488c7b657',
    0,
    'After a delivery, you find a required document was not completed according to company procedure.',
    'Selepas selesai penghantaran, anda mendapati dokumen yang diperlukan tidak dilengkapkan mengikut prosedur syarikat.',
    '["Complete and correct the document before closing the job", "Leave it since the delivery is already done", "Make a brief note and update it later if needed", "Proceed to the next task and rely on existing records"]',
    '["Lengkapkan dan betulkan dokumen sebelum menyelesaikan tugasan", "Biarkan sahaja kerana penghantaran sudah selesai", "Buat catatan ringkas dan kemas kini kemudian jika perlu", "Teruskan ke tugasan seterusnya dan bergantung pada rekod sedia ada"]',
    0,
    'Complete documents correctly to maintain procedural compliance.',
    'Lengkapkan dokumen dengan betul memastikan pematuhan terhadap prosedur.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4fee409a-d1fb-4268-ab66-db451d5a7b1f',
    0,
    'Feeling unusually tired due to insufficient rest, you are about to enter a site with narrow internal lanes.',
    'Anda berasa amat letih kerana kurang rehat dan akan memasuki tapak dengan laluan dalaman sempit.',
    '["Delay site entry to take a short rest", "Enter carefully and rely on slow speed", "Proceed since the site is familiar", "Enter and take breaks after the manoeuvre"]',
    '["Tangguhkan kemasukan ke tapak untuk berehat seketika", "Masuk dengan berhati-hati dan bergantung pada kelajuan rendah", "Teruskan kerana tapak tersebut sudah biasa", "Masuk dan berehat selepas selesai manuver"]',
    0,
    'Address fatigue before entering confined areas.',
    'Atasi keletihan sebelum memasuki kawasan sempit.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3c8a073d-9f88-41c8-9eb4-47d20551cd33',
    0,
    'While waiting inside a site, an emergency alarm sounds and vehicles are directed to clear the area. Your engine is running.',
    'Semasa menunggu di dalam tapak, penggera kecemasan berbunyi dan kenderaan diarahkan mengosongkan kawasan. Enjin anda masih hidup.',
    '["Follow evacuation instructions and stop the engine when safe", "Keep the engine running and leave quickly", "Wait for clarification before acting", "Continue idling until site personnel approach"]',
    '["Ikut arahan pemindahan dan matikan enjin apabila selamat", "Kekalkan enjin hidup dan keluar dengan cepat", "Tunggu penjelasan lanjut sebelum bertindak", "Terus hidupkan enjin sehingga kakitangan tapak datang"]',
    0,
    'Follow evacuation instructions and manage the vehicle safely.',
    'Ikut arahan pemindahan dan kendalikan kenderaan dengan selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '29d3b86d-76c9-4a52-825b-e893e2dac140',
    0,
    'You arrive at a customer premise and are told unloading will take longer than expected. The vehicle is parked safely.',
    'Anda tiba di tempat pelanggan dan dimaklumkan proses memunggah keluar akan mengambil masa lebih lama daripada jangkaan. Kenderaan telah diparkir dengan selamat.',
    '["Switch off the engine while waiting", "Keep the engine running to be ready to move", "Rev the engine occasionally", "Leave the engine idling and monitor the situation"]',
    '["Matikan enjin semasa menunggu", "Biarkan enjin hidup untuk bersedia bergerak", "Tekan minyak sekali-sekala", "Biarkan enjin melahu sambil memantau keadaan"]',
    0,
    'Switch off the engine during long waiting periods.',
    'Matikan enjin semasa menunggu lama untuk mengelakkan pembaziran bahan api.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6443c454-cc02-4f90-ba6b-e4998d44cd71',
    0,
    'While driving, you notice unusual vibration and a new mechanical noise from the vehicle.',
    'Semasa memandu, anda merasakan getaran tidak normal dan bunyi mekanikal baharu daripada kenderaan.',
    '["Continue driving and observe if the noise disappears", "Stop safely and report the issue clearly to the supervisor", "Reduce speed and complete the trip as planned", "Mention the issue during the next scheduled check"]',
    '["Teruskan memandu dan lihat sama ada bunyi itu hilang", "Berhenti di tempat selamat dan laporkan masalah kepada penyelia", "Kurangkan kelajuan dan teruskan perjalanan seperti dirancang", "Nyatakan masalah semasa pemeriksaan seterusnya"]',
    1,
    'Early detection and clear reporting help prevent minor issues from becoming safety risks.',
    'Pengesanan awal dan laporan yang jelas membantu mengelakkan masalah kecil menjadi risiko keselamatan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'eba7b678-901c-4580-8d5c-f2587e9f1d7f',
    0,
    'At a site checkpoint, you notice a vehicle defect just before being cleared to proceed.',
    'Di checkpoint tapak, anda perasan ada kerosakan pada kenderaan sejurus sebelum dibenarkan bergerak.',
    '["Proceed through the checkpoint and report the defect afterwards", "Stop at the checkpoint and report the defect immediately", "Move past the checkpoint and assess the defect inside", "Request guidance while remaining in the queue"]',
    '["Terus melepasi checkpoint dan laporkan kerosakan kemudian", "Berhenti di checkpoint dan laporkan kerosakan segera", "Lepasi checkpoint dan periksa kerosakan di dalam", "Minta panduan sambil kekal dalam barisan"]',
    1,
    'Reporting defects at checkpoints prevents unsafe entry into controlled zones.',
    'Laporkan kerosakan sebelum bergerak untuk elakkan risiko semasa masuk atau keluar kawasan terkawal.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '13f86b22-22b4-464d-b65f-9760c5cbef16',
    0,
    'A staff member at the delivery premise hints that a small personal favour could speed up your delivery process.',
    'Seorang pekerja di tempat pelanggan mencadangkan bahawa bantuan peribadi kecil boleh mempercepatkan proses penghantaran.',
    '["Decline politely and follow standard procedures", "Accept the request to maintain good customer relations", "Delay the decision and see how the situation develops", "Refer the matter to another driver on site"]',
    '["Tolak dengan sopan dan ikut prosedur biasa", "Terima permintaan itu untuk jaga hubungan pelanggan", "Tangguhkan keputusan dan lihat perkembangan keadaan", "Rujuk perkara itu kepada pemandu lain di tapak"]',
    0,
    'Following standard procedures protects fairness and avoids improper influence.',
    'Mengikut prosedur biasa membantu kekalkan keadilan dan elakkan pengaruh yang tidak wajar.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5d11186c-a850-45e6-9107-f707a512c340',
    0,
    'After a delivery, you notice the recorded details do not fully match what occurred.',
    'Selepas penghantaran, anda mendapati butiran yang direkod tidak sepenuhnya sepadan dengan apa yang berlaku.',
    '["Clarify the discrepancy and update the records accurately", "Leave the records unchanged to avoid reopening the discussion", "Add brief notes later so the paperwork roughly reflects events", "Ask someone else to adjust the documents if needed"]',
    '["Jelaskan perbezaan dan kemas kini rekod dengan tepat", "Biarkan rekod seperti itu untuk elakkan perbincangan dibuka semula", "Tambah catatan ringkas kemudian supaya dokumen lebih kurang mencerminkan keadaan sebenar", "Minta orang lain mengubah dokumen jika perlu"]',
    0,
    'Correct records promptly to ensure accuracy and prevent misunderstandings.',
    'Betulkan rekod dengan segera untuk memastikan ketepatan dan mengelakkan salah faham.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '01ba20a5-48fe-4b37-9432-d97d14d14a0a',
    0,
    'After unloading in a public street, a nearby shop owner asks you to record a shorter stop time to avoid complaints.',
    'Selepas memunggah muatan di tepi jalan awam, seorang pemilik kedai meminta anda merekod masa berhenti yang lebih singkat untuk elakkan aduan.',
    '["Record the actual stop time and submit the document as required", "Shorten the recorded time since unloading is already completed", "Leave the timing unclear so it does not attract attention", "Explain the situation verbally and minimise what is written"]',
    '["Catat masa berhenti sebenar dan serahkan dokumen seperti dikehendaki", "Pendekkan masa yang direkod kerana proses memunggah sudah selesai", "Biarkan catatan masa tidak jelas supaya tidak menarik perhatian", "Jelaskan secara lisan dan kurangkan maklumat bertulis"]',
    0,
    'Accurate records uphold accountability, even when there is public pressure.',
    'Catatan yang tepat membantu kekalkan tanggungjawab walaupun ada tekanan dari luar.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2742d4ef-35a0-4ba9-ae3a-b5cb973c3f1c',
    0,
    'You are driving through a residential area where pedestrians are present and traffic is light.',
    'Anda memandu melalui kawasan perumahan dengan kehadiran pejalan kaki dan trafik yang ringan.',
    '["Maintain an appropriate speed and remain mindful of people nearby", "Drive slightly faster to clear the area quickly", "Match the flow of traffic and continue as usual", "Focus on the road ahead and avoid reacting to bystanders"]',
    '["Kekalkan kelajuan yang sesuai dan peka terhadap orang di sekeliling", "Pandu sedikit lebih laju untuk keluar dari kawasan itu dengan cepat", "Ikut aliran trafik dan teruskan seperti biasa", "Fokus ke hadapan dan abaikan pergerakan orang di tepi jalan"]',
    0,
    'Reducing speed in residential areas shows consideration for pedestrian safety.',
    'Mengurangkan kelajuan di kawasan perumahan menunjukkan keprihatinan terhadap keselamatan pejalan kaki.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fefc1aa5-9281-4298-9669-7943dbf00e1e',
    0,
    'You intend to change lanes, but another driver in your blind spot appears unsure of your intention.',
    'Anda bercadang untuk menukar lorong, namun pemandu di titik buta kelihatan tidak pasti tentang niat anda.',
    '["Signal early and wait until the other driver responds before moving", "Drift slightly to indicate intention and move when space appears", "Check mirrors again and change lanes once traffic slows", "Hold position and change lanes later without signalling"]',
    '["Beri isyarat awal dan tunggu sehingga diberi ruang", "Hanyut sedikit ke sisi untuk menunjukkan niat dan masuk apabila ada ruang", "Periksa cermin sekali lagi dan tukar lorong apabila trafik menjadi perlahan", "Kekalkan kedudukan dan tukar lorong kemudian tanpa memberi isyarat"]',
    0,
    'Clear signalling helps other drivers understand your intention and reduces uncertainty during lane changes.',
    'Isyarat yang jelas membantu pemandu lain memahami niat anda dan mengurangkan ketidakpastian semasa menukar lorong.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7dd144c4-1448-4363-b84b-7a51cfb083ba',
    0,
    'Another driver cuts in suddenly, forcing you to brake, then begins gesturing angrily at you.',
    'Seorang pemandu memotong masuk secara tiba-tiba sehingga anda terpaksa membrek, kemudian menunjukkan isyarat marah kepada anda.',
    '["Regain composure and continue driving without reacting", "Respond briefly to show you were affected by the move", "Accelerate to move away from the situation", "Slow further to signal your frustration"]',
    '["Tenangkan diri dan teruskan pemanduan tanpa memberi respons", "Beri respons ringkas untuk menunjukkan anda terkesan", "Tambah kelajuan untuk menjauhkan diri daripada situasi", "Perlahankan lagi kenderaan sebagai tanda tidak puas hati"]',
    0,
    'Maintaining composure and not reacting helps prevent aggressive situations from escalating.',
    'Mengekalkan ketenangan dan tidak bertindak balas membantu mengelakkan situasi agresif daripada menjadi lebih tegang.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b20afd0d-ac07-419c-bdf8-f621bc8348f0',
    0,
    'You plan to install a sun shade, dark tint film, or stickers on the company truck windscreen.',
    'Anda bercadang memasang pelindung matahari, filem gelap, atau pelekat pada cermin hadapan lori syarikat.',
    '["Install them if they do not block the main driving view.", "Do not install them without company approval.", "Use removable shades only during daytime driving.", "Check whether other drivers have done similar modifications."]',
    '["Pasang jika tidak menghalang pandangan utama ketika memandu.", "Jangan pasang tanpa kelulusan syarikat.", "Gunakan pelindung yang boleh ditanggalkan pada waktu siang sahaja.", "Periksa sama ada pemandu lain pernah membuat pengubahsuaian yang sama."]',
    1,
    'Avoid unauthorised vehicle modifications that may affect safety or compliance.',
    'Elakkan pengubahsuaian pada kenderaan tanpa kelulusan yang boleh menjejaskan keselamatan atau pematuhan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7c9ce9c4-9227-43f0-8713-efe8d7f575c6',
    0,
    'Your goods vehicle is experiencing failure on a highway and you have stopped on the left shoulder.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda telah berhenti di bahu jalan sebelah kiri.',
    '["Remain inside and assess the situation first.", "Switch on the hazard lights immediately.", "Call your supervisor before taking further action.", "Step out briefly to check approaching traffic."]',
    '["Kekal di dalam kenderaan dan nilai keadaan terlebih dahulu.", "Hidupkan lampu kecemasan dengan segera.", "Hubungi penyelia sebelum mengambil tindakan lanjut.", "Keluar sebentar untuk memeriksa trafik yang menghampiri."]',
    1,
    'Activate hazard lights promptly to alert approaching traffic.',
    'Hidupkan lampu kecemasan segera untuk memberi amaran kepada pengguna jalan lain.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'dd6fd417-23cf-46ac-b35c-2530f03ce286',
    0,
    'Your vehicle is due for scheduled maintenance according to the company/manufacturer''s manual.',
    'Kenderaan anda telah tiba masa menjalani penyelenggaraan berjadual mengikut manual syarikat atau pengeluar.',
    '["Continue operating since the vehicle is running smoothly.", "Follow the scheduled maintenance requirement.", "Postpone the service until the next trip cycle.", "Wait for further confirmation before arranging service."]',
    '["Terus beroperasi kerana kenderaan masih berfungsi dengan baik.", "Patuhi keperluan penyelenggaraan berjadual.", "Tangguhkan servis sehingga kitaran perjalanan seterusnya.", "Tunggu pengesahan lanjut sebelum mengaturkan servis."]',
    1,
    'Follow the company/manufacturer''s maintenance schedule as required.',
    'Patuhi jadual penyelenggaraan yang ditetapkan oleh syarikat atau pengeluar.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e03f3416-7500-4199-bf06-86bbe0c4af7f',
    0,
    'You are involved in a minor incident during vehicle operation.',
    'Anda terlibat dalam satu insiden kecil semasa mengendalikan kenderaan.',
    '["Report the incident within 2 hours as required.", "Report it at the end of the workday.", "Report only if damage is visible.", "Wait until instructed before reporting."]',
    '["Laporkan insiden dalam tempoh 2 jam seperti yang ditetapkan.", "Laporkan pada akhir hari kerja.", "Laporkan hanya jika terdapat kerosakan yang dapat dilihat.", "Tunggu arahan sebelum membuat laporan."]',
    0,
    'Report accidents or incidents within the required reporting timeframe.',
    'Laporkan kemalangan atau insiden dalam tempoh masa pelaporan yang ditetapkan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '59b022a4-b7df-495c-9735-c2d887e65b26',
    0,
    'You are about to start driving the vehicle.',
    'Anda hendak memulakan pemanduan kenderaan.',
    '["Fasten the seat belt before moving.", "Drive first and fasten it later.", "Wear it only on highways.", "Use it only when carrying heavy cargo."]',
    '["Pakai tali pinggang keledar sebelum bergerak.", "Mula memandu dan pakai kemudian.", "Pakai hanya di lebuh raya.", "Pakai hanya apabila membawa muatan berat."]',
    0,
    'Always wear the seat belt before driving.',
    'Pakai tali pinggang keledar sebelum memandu.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f606f614-0a35-4e2f-995d-58d8a8dc5a1b',
    0,
    'You are reporting for duty after several weeks without a haircut.',
    'Anda melapor diri untuk bertugas selepas beberapa minggu tanpa memotong rambut.',
    '["Maintain short and neat hair as required.", "Keep long hair if tied properly.", "Trim only when reminded by HR.", "Maintain appearance only for inspections."]',
    '["Pastikan rambut sentiasa pendek dan kemas seperti yang ditetapkan.", "Simpan rambut panjang asalkan diikat dengan kemas.", "Potong rambut hanya apabila diingatkan oleh pihak sumber manusia (HR).", "Jaga penampilan hanya semasa pemeriksaan dijalankan."]',
    0,
    'Maintain neat and appropriate grooming for duty.',
    'Kekalkan penampilan yang kemas dan sesuai semasa bertugas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9132de66-ee66-4d68-ad80-ee7979f5d532',
    0,
    'You arrive at a delivery location and notice the address differs from the delivery note.',
    'Anda tiba di lokasi penghantaran dan mendapati alamat berbeza daripada yang tertera pada nota penghantaran.',
    '["Deliver to the new address if the customer confirms verbally.", "Contact operations for confirmation before proceeding.", "Deliver if the location is nearby.", "Leave the goods with the person present at the site."]',
    '["Hantar ke alamat baharu jika pelanggan mengesahkan secara lisan.", "Hubungi bahagian operasi untuk pengesahan sebelum meneruskan penghantaran.", "Hantar jika lokasi berhampiran.", "Tinggalkan barang kepada individu yang berada di tapak."]',
    1,
    'Verify address changes with operations before delivery.',
    'Sahkan sebarang perubahan alamat dengan bahagian operasi sebelum membuat penghantaran.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2bb83aad-aa33-4819-9739-6c89d6b011c1',
    0,
    'You notice a crack, repair mark, and slight bulging on an import container panel.',
    'Anda mendapati terdapat rekahan, kesan pembaikan dan sedikit bonjolan pada panel sebuah kontena import.',
    '["Record the condition in the gate pass.", "Proceed if the door locks properly.", "Report only if damage worsens.", "Assume it was previously declared."]',
    '["Rekodkan keadaan tersebut pada gate pass.", "Teruskan perjalanan jika pintu boleh dikunci dengan baik.", "Laporkan hanya jika kerosakan menjadi lebih teruk.", "Anggap keadaan tersebut telah diisytiharkan sebelum ini."]',
    0,
    'Record abnormal container conditions in the gate pass.',
    'Rekodkan sebarang keadaan kontena yang tidak normal pada gate pass sebelum bertolak/meneruskan perjalanan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7f204680-784f-46b2-a105-06aeafc9927d',
    0,
    'Before moving the container, you inspect the seal.',
    'Sebelum menggerakkan kontena, anda memeriksa seal.',
    '["Ensure the seal is intact and secured.", "Proceed if the container door is locked.", "Check the seal only at delivery point.", "Rely on previous documentation."]',
    '["Pastikan seal dalam keadaan baik dan dikunci dengan betul.", "Teruskan perjalanan jika pintu kontena telah dikunci.", "Periksa seal hanya di lokasi penghantaran.", "Bergantung kepada dokumentasi terdahulu."]',
    0,
    'Ensure the container seal is intact before movement.',
    'Pastikan seal dalam keadaan baik sebelum menggerakkan kontena.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '573c94aa-20f3-46df-aa86-70f29d500de3',
    0,
    'After confirming the seal on a loaded export container, what should you do next?',
    'Selepas mengesahkan seal pada kontena eksport yang telah dimuatkan, apakah tindakan seterusnya?',
    '["Inform operations of the seal number.", "Proceed directly to the port.", "Record it only in your trip log.", "Provide the seal number at delivery."]',
    '["Maklumkan nombor seal kepada bahagian operasi.", "Terus bergerak ke pelabuhan.", "Rekodkan nombor seal hanya dalam log perjalanan sahaja.", "Berikan nombor seal semasa penghantaran."]',
    0,
    'Inform operations of the seal number for system update.',
    'Maklumkan nombor seal kepada bahagian operasi untuk kemas kini sistem.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b97ae117-89f8-4208-9656-bd36fed04a4f',
    0,
    'Following a collision, what photographic evidence should you collect?',
    'Selepas pelanggaran, bukti gambar apakah yang perlu anda ambil?',
    '["Photos of the scene and vehicles involved.", "Only your own vehicle damage.", "A photo after vehicles are moved.", "No photos if witnesses are present."]',
    '["Gambar lokasi kejadian dan kenderaan yang terlibat.", "Gambar kerosakan kenderaan anda sahaja.", "Gambar selepas kenderaan dialihkan.", "Tidak perlu ambil gambar jika ada saksi."]',
    0,
    'Take clear photos of the accident scene and vehicles.',
    'Ambil gambar yang jelas bagi lokasi kejadian dan kenderaan yang terlibat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b2f1c095-1aec-4da6-957e-3b5993145383',
    0,
    'After a road accident, the Emergency Response Team contacts you.',
    'Selepas kemalangan jalan raya, Pasukan Tindak Balas Kecemasan menghubungi anda.',
    '["Provide clear details of what happened, time, location, and vehicles involved.", "Inform them only that an accident occurred.", "Ask them to obtain details from witnesses.", "Provide information after returning to depot."]',
    '["Berikan maklumat jelas tentang apa yang berlaku, masa, lokasi dan kenderaan yang terlibat.", "Maklumkan bahawa kemalangan telah berlaku sahaja.", "Minta mereka mendapatkan maklumat daripada saksi.", "Berikan maklumat selepas kembali ke depot."]',
    0,
    'Provide clear and accurate accident details immediately.',
    'Berikan maklumat kemalangan yang jelas dan tepat dengan segera.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '291b3488-384e-4ebc-b075-751a32433b34',
    0,
    'You drive inside a terminal lane where RTG lifting and yard vehicles are moving.',
    'Anda memandu di laluan terminal di mana RTG beroperasi dan kenderaan yard sedang bergerak.',
    '["Maintain speed and pass while watching the RTG", "Reduce speed early and pass cautiously", "Continue at moderate speed and adjust if equipment moves closer", "Slow slightly but keep moving to avoid delaying traffic"]',
    '["Kekalkan kelajuan dan lalu sambil memerhati RTG", "Kurangkan kelajuan lebih awal dan lalu dengan berhati-hati", "Teruskan pada kelajuan sederhana dan laras jika RTG menghampiri", "Perlahankan sedikit tetapi terus bergerak untuk elakkan kelewatan trafik"]',
    1,
    'Reduce speed early near lifting activity to manage sudden equipment movement safely.',
    'Kurangkan kelajuan lebih awal berhampiran aktiviti jentera untuk mengendalikan pergerakan jentera secara selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'be8686b1-c889-48ea-afb9-348b7b92c75f',
    0,
    'You drive in slow traffic. A driver cuts in and brakes sharply.',
    'Anda memandu dalam trafik perlahan. Seorang pemandu memotong masuk dan membrek secara mengejut.',
    '["Reduce speed smoothly and keep a safe pace", "Maintain speed to avoid being pushed back", "Slow briefly, then speed up to create space", "Adjust speed after traffic settles"]',
    '["Kurangkan kelajuan secara lancar dan kekalkan kelajuan selamat", "Kekalkan kelajuan untuk mengelak daripada didorong ke belakang.", "Perlahankan seketika kemudian tambah kelajuan untuk mewujudkan ruang di hadapan", "Sesuaikan kelajuan selepas trafik kembali stabil"]',
    0,
    'Calm speed control prevents impulsive reactions in frustrating traffic.',
    'Kawalan kelajuan yang tenang membantu mengelakkan tindak balas impulsif dalam trafik.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.25, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2f0934b8-d4b1-4b2e-8c7d-09da721b6e2f',
    0,
    'You are in an active loading area during heavy rain. Surfaces are wet and equipment operates nearby.',
    'Anda berada di kawasan pemuatan aktif semasa hujan lebat. Permukaan basah dan jentera beroperasi berhampiran.',
    '["Stay clear of the loading area until conditions stabilise", "Proceed carefully while adjusting pace for the weather", "Move closer to monitor equipment movement", "Continue approaching so loading can proceed"]',
    '["Kekal jauh dari kawasan pemuatan sehingga keadaan stabil", "Teruskan dengan berhati-hati sambil laraskan kelajuan", "Bergerak lebih dekat untuk memantau pergerakan jentera", "Terus menghampiri supaya proses pemuatan boleh diteruskan"]',
    0,
    'Keep clear of loading activity when weather increases risk.',
    'Kekalkan jarak dari aktiviti pemuatan apabila keadaan cuaca meningkatkan risiko.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b62dd0f8-2c05-4b83-8e94-c620173c0e58',
    0,
    'You move from an internal roadway toward a loading area. Obstructions and movement change around you.',
    'Anda bergerak dari laluan dalaman menuju kawasan pemunggahan. Halangan dan pergerakan berubah di sekeliling.',
    '["Slow early and adjust your path to surrounding movement", "Maintain pace and react when a hazard appears", "Focus on the path ahead and reassess inside", "Follow vehicles ahead that pass smoothly"]',
    '["Perlahankan kenderaan lebih awal dan sesuaikan laluan mengikut pergerakan sekitar", "Kekalkan kelajuan dan bertindak apabila bahaya muncul", "Fokus pada laluan di hadapan dan nilai semula selepas masuk", "Ikut kenderaan di hadapan yang melalui kawasan dengan lancar"]',
    0,
    'Anticipate early and adjust space to avoid sudden reactions.',
    'Jangka lebih awal dan sesuaikan ruang untuk elakkan tindak balas mengejut.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '53d408e6-0965-48fc-8a47-f9c5b13cf267',
    0,
    'At a security checkpoint, the vehicle ahead is being cleared and the guard signals you to move closer.',
    'Di pusat pemeriksaan keselamatan, kenderaan di hadapan sedang diperiksa dan pengawal memberi isyarat supaya anda bergerak lebih dekat.',
    '["Close the gap to speed up clearance", "Keep a safe following distance", "Stop directly behind the vehicle", "Move slowly and rely on the guard to manage spacing"]',
    '["Rapatkan jarak untuk mempercepatkan pemeriksaan", "Kekalkan jarak selamat dengan kenderaan di hadapan", "Berhenti tepat di belakang kenderaan", "Bergerak perlahan dan bergantung pada pengawal untuk mengawal jarak"]',
    1,
    'Checkpoint instructions do not replace safe spacing.',
    'Arahan pusat pemeriksaan tidak menggantikan disiplin jarak selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fc6579d4-a2f4-489f-8824-1ef004ba1aa9',
    0,
    'After a delivery, you are stopped for inspection and asked to present your documents. One document was completed late but is accurate.',
    'Selepas penghantaran, anda ditahan untuk pemeriksaan dan diminta menunjukkan dokumen. Satu dokumen dilengkapkan lewat tetapi maklumatnya tepat.',
    '["Present the documents and clarify the late entry", "Hand over the documents without mentioning the late entry", "Say the document was completed earlier", "Offer to update the document later"]',
    '["Tunjukkan dokumen dan jelaskan tentang pengisian lewat", "Serahkan dokumen tanpa memaklumkan tentang kelewatan pengisian", "Nyatakan bahawa dokumen telah dilengkapkan lebih awal", "Tawarkan untuk mengemas kini dokumen kemudian"]',
    0,
    'Present accurate documents and clarify issues during inspections.',
    'Tunjukkan dokumen yang tepat dan jelaskan perkara berkaitan semasa pemeriksaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd66f8c56-7261-455b-b399-3fea55bb0ecd',
    0,
    'While driving inside a site, you see a posted speed limit.',
    'Semasa memandu di dalam tapak, anda melihat had laju yang dipaparkan.',
    '["Adjust speed to comply with the posted limit", "Maintain current speed since traffic is light", "Reduce speed slightly but continue comfortably", "Match the speed of other vehicles"]',
    '["Laraskan kelajuan untuk mematuhi had laju yang dipaparkan", "Kekalkan kelajuan kerana trafik ringan", "Kurangkan kelajuan sedikit tetapi teruskan dengan selesa", "Ikut kelajuan kenderaan lain"]',
    0,
    'Follow posted speed limits inside operational sites.',
    'Patuhi had laju yang ditetapkan di dalam kawasan operasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '063eaee4-dae2-492c-ae2c-f8968cb1dbd0',
    0,
    'After a pre-trip inspection, you feel an unusual vibration while driving.',
    'Selepas pemeriksaan sebelum perjalanan, anda merasakan getaran tidak biasa semasa memandu.',
    '["Stop and recheck the vehicle before continuing", "Continue driving since the inspection showed no problems", "Complete the trip and report it at the end of the shift", "Ignore it unless a warning indicator appears"]',
    '["Berhenti dan periksa semula kenderaan", "Terus memandu kerana pemeriksaan awalan dibuat", "Selesaikan perjalanan dan laporkan pada akhir syif", "Abaikan kecuali lampu amaran muncul"]',
    0,
    'Unusual vehicle behaviour requires immediate checking.',
    'Perubahan mekanikal kenderaan perlu diperiksa segera.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1be9a6e9-ccfa-4510-90d0-3c3434326f92',
    0,
    'At the end of your shift, the vehicle cabin is cluttered with items.',
    'Pada akhir syif, kabin kenderaan berselerak dengan barang.',
    '["Tidy the cabin and leave it ready for the next driver", "Leave the cabin since the shift has ended", "Remove personal items and clean it the next shift", "Clean only if the next driver is known"]',
    '["Kemas kabin dan sediakan untuk pemandu seterusnya", "Biarkan kabin kerana syif telah tamat", "Ambil barang peribadi dan kemakan kabin keesokan hari", "Bersihkan hanya jika pemandu seterusnya dikenali"]',
    0,
    'Leave the cabin orderly for the next user or the next shift',
    'Tinggalkan kabin dalam keadaan kemas untuk pengguna seterusnya.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '088f578d-65e4-4695-a15e-4bfeb896118b',
    0,
    'Before departure, you identify a cargo safety concern while another party pressures you to move immediately.',
    'Sebelum berlepas, anda mengenal pasti isu keselamatan muatan sementara pihak lain mendesak anda bergerak segera.',
    '["Proceed carefully to avoid further discussion", "Address the safety concern and explain the delay calmly", "Agree to move briefly to reduce tension", "Remain silent and delay action"]',
    '["Teruskan dengan berhati-hati untuk elakkan perbincangan lanjut", "Tangani isu keselamatan muatan dan jelaskan kelewatan dengan tenang", "Setuju bergerak seketika untuk mengurangkan ketegangan", "Berdiam diri dan tangguhkan tindakan"]',
    1,
    'Address safety concerns first while responding calmly to others.',
    'Utamakan keselamatan sambil bertindak balas dengan tenang kepada pihak lain.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8aad2f31-1150-4819-b215-cd07e4214843',
    0,
    'While reversing slowly inside a site, you notice steering response feels abnormal.',
    'Semasa mengundur perlahan di dalam tapak, anda merasakan tindak balas stereng tidak normal.',
    '["Continue reversing carefully to clear the area", "Stop the manoeuvre and assess the defect", "Complete the reverse and report afterward", "Reduce speed further and keep moving"]',
    '["Terus mengundur dengan berhati-hati untuk lepasi kawasan itu", "Hentikan manuver dan periksa keadaan", "Selesaikan undur dan laporkan selepas itu", "Kurangkan lagi kelajuan dan teruskan bergerak"]',
    1,
    'Stopping immediately when a defect is felt during manoeuvres prevents damage and injury.',
    'Hentikan kenderaan apabila terasa tanda tidak normal semasa manuver untuk elakkan kerosakan dan kecederaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a79ddd87-f270-416e-b2e2-5da5aded3980',
    0,
    'A customer becomes verbally aggressive after being told the delivery cannot proceed as requested.',
    'Seorang pelanggan bercakap secara agresif selepas dimaklumkan bahawa penghantaran tidak dapat diteruskan seperti diminta.',
    '["Respond firmly to assert your position", "Stay calm, acknowledge concerns, and explain the situation clearly", "End the conversation and walk away", "Repeat company policy without further engagement"]',
    '["Jawab dengan tegas untuk pertahankan pendirian", "Kekal tenang, dengar perkara yang dibangkitkan dan terangkan keadaan dengan jelas", "Tamatkan perbualan dan beredar", "Ulang dasar syarikat tanpa perbincangan lanjut"]',
    1,
    'Staying calm and acknowledging concerns helps prevent escalation and keeps the situation under control.',
    'Kekal tenang dan beri penjelasan yang jelas membantu elakkan keadaan menjadi lebih tegang dan kekalkan kawalan situasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'eff0aebd-a3c5-486e-8c6f-bde800ef76e9',
    0,
    'During unloading, a site worker suggests a small personal favour to speed up the process.',
    'Semasa proses memunggah, seorang pekerja tapak mencadangkan bantuan peribadi kecil untuk mempercepatkan proses.',
    '["Decline politely and continue unloading as required", "Agree briefly since it may help everyone finish faster", "Avoid responding directly and keep working to reduce attention", "Suggest handling the request later to keep things moving"]',
    '["Tolak dengan sopan dan teruskan proses memunggah seperti dikehendaki", "Setuju seketika kerana ia mungkin mempercepatkan kerja", "Elakkan memberi respons secara langsung dan teruskan kerja", "Cadangkan urus perkara itu kemudian supaya kerja berjalan"]',
    0,
    'Declining improper requests helps maintain integrity and fair working practices.',
    'Menolak permintaan yang tidak sesuai membantu kekalkan integriti dan amalan kerja yang adil.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c71f5540-ad11-4b3e-84af-6e0e691a944f',
    0,
    'During a delivery discussion, someone becomes upset after you refuse an improper request.',
    'Semasa perbincangan penghantaran, seseorang menjadi tidak puas hati selepas anda menolak permintaan yang tidak sesuai.',
    '["Restate your position calmly and keep the discussion respectful", "Explain in detail why the request is wrong and unacceptable", "End the discussion abruptly to avoid further disagreement", "Respond firmly to make it clear the matter is closed"]',
    '["Nyatakan semula pendirian anda dengan tenang dan kekalkan perbincangan secara hormat", "Terangkan dengan terperinci mengapa permintaan itu salah dan tidak boleh diterima", "Tamatkan perbincangan secara mendadak untuk elak pertelingkahan lanjut", "Beri respons dengan tegas supaya jelas perkara itu telah selesai"]',
    0,
    'Holding your position calmly helps resolve issues without escalating conflict.',
    'Kekalkan pendirian dengan tenang untuk selesaikan isu tanpa meningkatkan ketegangan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd4268f7f-6ebf-4557-a3ca-6ab63051877c',
    0,
    'A driver behind you flashes headlights repeatedly and gestures, appearing impatient with your speed.',
    'Seorang pemandu di belakang anda berulang kali memberi lampu tinggi dan membuat isyarat, kelihatan tidak sabar dengan kelajuan anda.',
    '["Keep your speed steady and avoid responding to the behaviour", "Speed up slightly so the situation does not turn into an argument", "Change lanes when possible to prevent further confrontation", "React briefly to signal you have noticed the other driver"]',
    '["Kekalkan kelajuan secara konsisten dan elakkan memberi respons", "Tambah sedikit kelajuan supaya keadaan tidak menjadi tegang", "Tukar lorong apabila selamat untuk mengelakkan konfrontasi", "Beri respons ringkas untuk menunjukkan anda sedar akan kehadirannya"]',
    0,
    'Maintaining steady driving and not reacting helps prevent conflicts from escalating.',
    'Pemanduan yang stabil dan tidak bertindak balas membantu mengelakkan situasi daripada menjadi tegang.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5c35d609-3f3a-4a3b-8d4c-b8092c500dea',
    0,
    'You slow to turn near pedestrians, and nearby road users appear unsure of your intention.',
    'Anda memperlahankan kenderaan untuk membelok berhampiran pejalan kaki, dan pengguna jalan lain kelihatan tidak pasti tentang niat anda.',
    '["Signal early and make the turn carefully", "Slow further to see how others react", "Turn once there is space without signalling", "Edge forward slightly to show what you intend to do"]',
    '["Beri isyarat awal dan belok secara cermat", "Perlahankan lagi untuk melihat reaksi orang lain", "Belok apabila ada ruang tanpa memberi isyarat", "Gerak sedikit ke hadapan untuk menunjukkan niat"]',
    0,
    'Early signalling helps pedestrians and other road users understand your intention and stay safe.',
    'Isyarat awal membantu pejalan kaki dan pengguna jalan lain memahami niat anda dan kekal selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9a167024-af60-4fc5-b379-d49f86a89171',
    0,
    'A vehicle cuts in sharply, making you angry. You need to change lanes while drivers around you are unsure of your intention.',
    'Sebuah kenderaan memotong masuk secara mengejut sehingga anda berasa marah. Anda perlu menukar lorong ketika pemandu lain di sekitar tidak pasti tentang niat anda.',
    '["Regain composure and signal clearly before changing lanes", "Change lanes quickly to get away from the situation", "Sound the horn briefly to express frustration", "Hold your lane without signalling until traffic settles"]',
    '["Tenangkan diri dan beri isyarat dengan jelas sebelum menukar lorong", "Tukar lorong dengan cepat untuk menjauhkan diri daripada situasi", "Bunyi hon seketika untuk meluahkan rasa tidak puas hati", "Kekalkan lorong tanpa memberi isyarat sehingga trafik kembali stabil"]',
    0,
    'Clear signalling after regaining composure helps others understand your intentions and keeps traffic moving safely.',
    'Isyarat yang jelas selepas menenangkan diri membantu pemandu lain memahami niat anda dan memastikan aliran trafik kekal selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '07bb6639-1800-4e26-bd06-f0842e5c27ce',
    0,
    'You have completed 8 hours of driving for the day and one nearby delivery remains.',
    'Anda telah memandu selama 8 jam pada hari tersebut dan satu penghantaran berhampiran masih belum selesai.',
    '["Continue driving to complete the final delivery.", "Stop driving and report reaching the daily limit.", "Drive for another 30 minutes before stopping.", "Reduce speed and complete the delivery carefully."]',
    '["Terus memandu untuk menyelesaikan penghantaran terakhir.", "Hentikan pemanduan dan laporkan bahawa had harian telah dicapai.", "Memandu lagi selama 30 minit sebelum berhenti.", "Kurangkan kelajuan dan selesaikan penghantaran dengan berhati-hati."]',
    1,
    'Follow driving hour limits to maintain safety and compliance.',
    'Patuhi had waktu pemanduan untuk menjaga keselamatan dan pematuhan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '61b54ab0-cc29-434d-9352-bd918810ccbd',
    0,
    'Your goods vehicle is experiencing failure at night and you need to step out.',
    'Kenderaan barangan anda mengalami kerosakan pada waktu malam dan anda perlu keluar dari kenderaan.',
    '["Exit quickly to place warning devices.", "Wear a safety vest before exiting.", "Stand beside the vehicle and observe traffic.", "Use your phone light while walking behind the vehicle."]',
    '["Keluar dengan segera untuk meletakkan alat amaran.", "Pakai jaket keselamatan sebelum keluar.", "Berdiri di sebelah kenderaan dan perhatikan trafik.", "Gunakan lampu telefon bimbit semasa berjalan di belakang kenderaan."]',
    1,
    'Ensure personal visibility before exiting to reduce roadside risk.',
    'Pastikan anda mudah dilihat sebelum keluar bagi mengurangkan risiko di tepi jalan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '79689bb2-e0f1-43d5-adae-7443e1c776f5',
    0,
    'During inspection, you notice the fire extinguisher has passed its expiry date.',
    'Semasa pemeriksaan, anda mendapati alat pemadam api telah melepasi tarikh luput.',
    '["Keep using it since it has not been discharged.", "Replace it with a compliant 9kg extinguisher within validity.", "Replace it with a compliant 6kg extinguisher within validity.", "Replace it with a compliant 12kg extinguisher within validity."]',
    '["Terus gunakan kerana ia belum pernah digunakan.", "Gantikan dengan alat pemadam api 9kg yang mematuhi spesifikasi dan masih dalam tempoh sah.", "Gantikan dengan alat pemadam api 6kg yang mematuhi spesifikasi dan masih dalam tempoh sah.", "Gantikan dengan alat pemadam api 12kg yang mematuhi spesifikasi dan masih dalam tempoh sah."]',
    1,
    'Ensure the required fire extinguisher meets the approved specification and validity.',
    'Pastikan alat pemadam api yang diperlukan mematuhi spesifikasi dan tempoh sah yang ditetapkan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd272621b-d959-4d41-b702-8407c73616c1',
    0,
    'You are asked to modify the vehicle''s GPS tracking or speedometer settings.',
    'Anda diminta untuk mengubah suai tetapan sistem GPS atau meter kelajuan kenderaan.',
    '["Make the adjustment if it improves convenience.", "Refuse any modification that violates safety or company protocol.", "Adjust the settings temporarily and restore them later.", "Modify only if other drivers have done so."]',
    '["Buat pelarasan jika ia memudahkan urusan.", "Tolak sebarang pengubahsuaian yang melanggar peraturan keselamatan atau prosedur syarikat.", "Ubah tetapan sementara dan pulihkan kemudian.", "Buat pengubahsuaian hanya jika pemandu lain pernah melakukannya."]',
    1,
    'Do not alter vehicle systems against safety rules or company protocol.',
    'Jangan mengubah suai sistem kenderaan yang bertentangan dengan peraturan keselamatan atau prosedur syarikat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e08c190f-d2a9-4373-9471-0b8d6f272d60',
    0,
    'You are selected for a random blood and urine test during duty.',
    'Anda dipilih untuk menjalani ujian darah dan air kencing secara rawak semasa bertugas.',
    '["Cooperate and undergo the test as required.", "Request to postpone the test to another day.", "Refuse the test because it is unlawful.", "Agree only if other drivers are tested first."]',
    '["Berikan kerjasama dan jalani ujian tersebut seperti yang dikehendaki.", "Minta supaya ujian ditangguhkan ke hari lain.", "Tolak ujian tersebut kerana ia tidak sah di sisi undang-undang.", "Bersetuju hanya jika pemandu lain diuji terlebih dahulu."]',
    0,
    'Comply with random substance testing as required.',
    'Patuhi ujian saringan bahan terlarang secara rawak seperti yang ditetapkan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '80ac2251-119e-43b1-b987-e2d78766b148',
    0,
    'You are starting your work shift for the day.',
    'Anda memulakan syif kerja pada hari tersebut.',
    '["Record your attendance at the end of the shift.", "Record your attendance at the beginning and end of the shift.", "Inform your supervisor.", "Record attendance only when requested."]',
    '["Rekodkan kehadiran pada akhir syif.", "Rekodkan kehadiran pada awal dan akhir syif.", "Maklumkan kepada penyelia.", "Rekodkan kehadiran hanya apabila diminta."]',
    1,
    'Record attendance properly at the start and end of duty.',
    'Rekod kehadiran dengan betul pada awal dan akhir tugas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'dffb8588-ad50-4452-9cdb-474496b6c020',
    0,
    'Before departing with a container, you notice visible damage on its exterior.',
    'Anda akan bertolak dengan sebuah kontena namun mendapati terdapat kerosakan yang jelas pada bahagian luarnya.',
    '["Proceed since the container is already sealed.", "Record the damage in the required document.", "Inform the customer verbally and continue.", "Proceed if the cargo inside appears intact."]',
    '["Teruskan perjalanan kerana kontena telah dimeterai.", "Rekodkan kerosakan dalam dokumen yang diperlukan.", "Maklumkan pelanggan secara lisan dan teruskan perjalanan.", "Teruskan jika muatan di dalam kelihatan baik."]',
    1,
    'Record any container damage before proceeding.',
    'Rekodkan sebarang kerosakan kontena sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '35042bf6-4184-4365-9020-58faf5092abe',
    0,
    'While inspecting a reefer import container, you notice the power cable appears damaged.',
    'Semasa memeriksa kontena import berpendingin, anda mendapati kabel kuasa kelihatan rosak.',
    '["Record the issue in the gate pass before exiting.", "Continue if temperature display is normal.", "Inform operations after delivery.", "Secure it temporarily and proceed."]',
    '["Catat isu tersebut pada gate pass sebelum keluar.", "Teruskan perjalanan jika paparan suhu normal.", "Maklumkan kepada bahagian operasi selepas penghantaran.", "Ikat sementara dan teruskan perjalanan."]',
    0,
    'Record any reefer equipment damage in the gate pass before departure.',
    'Catat sebarang kerosakan peralatan kontena import berpendingin pada gate pass sebelum berlepas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd748ff55-1e3d-417c-8aef-64a23528bae0',
    0,
    'Before departure, you notice there is no seal on the container.',
    'Sebelum bertolak, anda mendapati tiada seal pada kontena.',
    '["Install any available seal and continue.", "Report to operations and wait for instruction.", "Proceed if the cargo appears secured.", "Inform the customer after delivery."]',
    '["Pasang mana-mana seal yang ada dan teruskan perjalanan.", "Laporkan kepada bahagian operasi dan tunggu arahan lanjut.", "Teruskan perjalanan jika muatan kelihatan selamat.", "Maklumkan kepada pelanggan selepas penghantaran."]',
    1,
    'Report missing seals before moving the container.',
    'Laporkan seal yang tiada sebelum menggerakkan kontena.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4876abf3-5f57-46b1-b30b-ab528233c5f2',
    0,
    'You are hauling a loaded export container to the designated port.',
    'Anda sedang membawa kontena eksport yang telah dimuatkan ke pelabuhan yang ditetapkan.',
    '["Drive directly to the port without unnecessary stops.", "Stop briefly for personal errands.", "Park overnight and continue the next day.", "Divert to another site before heading to port."]',
    '["Pandu terus ke pelabuhan tanpa membuat hentian yang tidak perlu.", "Berhenti seketika untuk urusan peribadi.", "Parkir semalaman dan sambung perjalanan pada hari berikutnya.", "Singgah ke tapak lain sebelum ke pelabuhan."]',
    0,
    'Haul export containers directly to the designated port unless emergency arises.',
    'Bawa kontena eksport terus ke pelabuhan yang ditetapkan kecuali berlaku kecemasan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e53492c3-9349-4059-ae5c-928f76e6f074',
    0,
    'After ensuring safety at the accident scene, what should you do next?',
    'Selepas memastikan keselamatan di lokasi kemalangan, apakah tindakan seterusnya?',
    '["Report immediately to office.", "Complete delivery first and report later.", "Wait until returning to depot.", "Inform only if damage is serious."]',
    '["Laporkan segera kepada pejabat.", "Selesaikan penghantaran dahulu dan laporkan kemudian.", "Tunggu sehingga kembali ke depot.", "Maklumkan hanya jika kerosakan adalah serius."]',
    0,
    'Report the incident immediately and await instruction.',
    'Laporkan kejadian segera dan tunggu arahan lanjut.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '06f44932-1eb0-4ff4-9338-d2cb249b9082',
    0,
    'After a collision, operations asks for your location.',
    'Selepas pelanggaran, bahagian operasi meminta lokasi anda.',
    '["Provide the exact location using junctions or landmarks.", "Say you are \"near the highway\".", "Share the location after police arrival.", "Wait for GPS tracking to update automatically."]',
    '["Berikan lokasi tepat dengan menyatakan simpang atau mercu tanda.", "Berikan anggaran lokasi berdasarkan kawasan sekitar.", "Kongsi lokasi selepas polis tiba.", "Tunggu sistem GPS dikemas kini secara automatik."]',
    0,
    'Provide precise accident location details.',
    'Berikan butiran lokasi kemalangan dengan tepat dan jelas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ccce3a38-ee91-4891-b742-163e2db35b78',
    0,
    'You drive in steady multi-lane traffic. Motorcycles filter between lanes and traffic slows near an exit.',
    'Anda memandu dalam trafik berbilang lorong yang lancar. Motosikal bergerak di antara lorong dan trafik perlahan berhampiran susur keluar.',
    '["Maintain lane position and prepare for sudden movement", "Change lanes early to avoid slowing traffic", "Hold lane but move closer to the lane marking", "Continue normally and react only if traffic slows"]',
    '["Kekalkan kedudukan lorong dan bersedia untuk pergerakan mengejut", "Tukar lorong lebih awal untuk mengelakkan trafik perlahan", "Kekalkan lorong tetapi bergerak lebih dekat ke garisan lorong", "Teruskan seperti biasa dan bertindak hanya jika trafik perlahan"]',
    0,
    'Maintain stable lane position and anticipate sudden movement.',
    'Kekalkan kedudukan lorong yang stabil dan jangka pergerakan mengejut.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '27c308e3-1d8b-423b-9454-421eba4c7468',
    0,
    'You follow a slow vehicle on a busy road. Traffic flows on the adjacent lane.',
    'Anda mengekori kenderaan perlahan di jalan sibuk. Trafik bergerak di lorong sebelah.',
    '["Wait for a clear safe gap before overtaking", "Overtake quickly to avoid staying behind", "Move closer to signal your intent", "Begin overtaking and adjust as traffic responds"]',
    '["Tunggu ruang yang benar-benar selamat sebelum memotong", "Memotong dengan cepat supaya tidak terus terperangkap", "Bergerak lebih dekat untuk memberi isyarat niat", "Mulakan memotong dan sesuaikan kedudukan mengikut trafik"]',
    0,
    'Manage frustration and wait for a clear safe gap before overtaking.',
    'Kawal rasa marah dan tunggu ruang yang benar-benar selamat sebelum memotong.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a5240308-a907-4381-8086-0cfc99468b96',
    0,
    'You are inside a terminal yard. A marshal signals you to hold while equipment moves in your path.',
    'Anda berada di dalam kawasan terminal. Seorang marshal memberi isyarat supaya berhenti sementara jentera bergerak di laluan anda.',
    '["Remain stationary until the marshal signals to proceed", "Ease forward slightly to improve visibility", "Hold briefly, then advance once equipment clears", "Follow the vehicle ahead if it begins moving"]',
    '["Kekal berhenti sehingga marshal memberi isyarat untuk bergerak", "Bergerak sedikit ke hadapan untuk meningkatkan jarak penglihatan", "Berhenti seketika kemudian bergerak apabila jentera beredar", "Ikut kenderaan di hadapan jika ia mula bergerak"]',
    0,
    'Follow marshal instructions and keep distance from operating equipment.',
    'Patuhi arahan marshal dan kekalkan jarak daripada jentera yang sedang beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1ef573d3-2a51-4325-836a-4545586c67b7',
    0,
    'You approach a junction inside an industrial site. Internal lanes intersect and site rules require vehicles to yield.',
    'Anda menghampiri persimpangan di dalam kawasan industri. Laluan dalaman bersilang dan peraturan tapak memerlukan kenderaan memberi laluan.',
    '["Slow down and follow the site junction rule", "Roll forward and proceed when the path looks clear", "Edge into the junction to signal intention", "Enter if nearby vehicles move through safely"]',
    '["Perlahankan kenderaan dan ikut peraturan persimpangan tapak", "Bergerak perlahan dan masuk apabila laluan kelihatan jelas", "Masuk sedikit ke persimpangan untuk memberi isyarat niat", "Masuk jika kenderaan berhampiran kelihatan melalui dengan selamat"]',
    0,
    'Apply site junction rules to prevent conflicts at internal intersections.',
    'Patuhi peraturan persimpangan tapak untuk mengelakkan konflik di persimpangan dalaman.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '585e975f-44fb-46f1-bc0d-432cff30e9cf',
    0,
    'You drive inside a container terminal. RTGs and reach stackers operate nearby and containers restrict visibility.',
    'Anda memandu di dalam terminal kontena. RTG dan reach stacker beroperasi berhampiran dan kontena menghadkan pandangan.',
    '["Reduce speed early and proceed cautiously", "Maintain normal speed and rely on operators to yield", "Accelerate briefly to clear the area", "Match the speed of nearby terminal vehicles"]',
    '["Kurangkan kelajuan lebih awal dan teruskan dengan berhati-hati", "Kekalkan kelajuan biasa dan bergantung pada pengendali untuk memberi laluan", "Tambah kelajuan seketika untuk melepasi kawasan itu", "Ikut kelajuan kenderaan terminal berhampiran"]',
    0,
    'Reduce speed near operating terminal equipment.',
    'Kurangkan kelajuan berhampiran jentera terminal yang beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '48bb055a-085f-4c00-9304-8e39c11aefbe',
    0,
    'During a roadside inspection, an officer approaches and you realise you are not wearing a safety vest.',
    'Semasa pemeriksaan di tepi jalan, seorang pegawai menghampiri dan anda sedar anda tidak memakai vest keselamatan.',
    '["Put on the safety vest and cooperate with the inspection", "Continue the inspection and wear it if instructed", "Answer the officer''s questions and address it later", "Remain where you are until the inspection ends"]',
    '["Pakai vest keselamatan dan beri kerjasama semasa pemeriksaan", "Teruskan pemeriksaan dan pakai jika diarahkan", "Jawab soalan pegawai dan uruskan kemudian", "Kekal di tempat anda sehingga pemeriksaan selesai"]',
    0,
    'Wear required safety equipment during inspections.',
    'Pakai peralatan keselamatan yang diperlukan semasa pemeriksaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd92fd6f2-d092-4e74-a7f0-8476434246c9',
    0,
    'While driving inside a site, you encounter uneven surfaces and hazards along the route. You are within the speed limit.',
    'Semasa memandu di dalam tapak, anda menghadapi permukaan tidak rata dan bahaya di laluan. Anda masih dalam had laju dibenarkan.',
    '["Reduce speed to suit the hazards", "Maintain speed since it is within the limit", "Adjust speed only near visible obstacles", "Continue at normal speed and rely on steering"]',
    '["Kurangkan kelajuan mengikut keadaan", "Kekalkan kelajuan kerana masih dalam had laju", "Sesuaikan kelajuan hanya berhampiran halangan yang jelas", "Teruskan pada kelajuan biasa dan bergantung pada kawalan stereng"]',
    0,
    'Adjust speed to suit conditions even within the limit.',
    'Sesuaikan kelajuan mengikut keadaan walaupun masih dalam had laju.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9d521376-6094-49e7-953f-77dd1b07b976',
    0,
    'After a pre-trip inspection, the vehicle behaves differently once you begin moving.',
    'Selepas pemeriksaan sebelum perjalanan, kenderaan menunjukkan keadaan tidak biasa apabila anda mula bergerak.',
    '["Continue driving to see if it settles", "Stop safely and reassess the vehicle", "Adjust driving style to compensate", "Complete the trip and report later"]',
    '["Terus memandu untuk melihat sama ada keadaan kembali normal", "Berhenti dengan selamat dan periksa semula kenderaan", "Laraskan cara pemanduan untuk menyesuaikan keadaan", "Selesaikan perjalanan dan laporkan kemudian"]',
    1,
    'Vehicle behaviour should match inspection results.',
    'Jika kenderaan menunjukkan keadaan tidak biasa, berhenti dan periksa semula sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a0075e25-88ec-466b-ab67-9c355320a22b',
    0,
    'While preparing for delivery, you notice the cargo is not fully secured and the customer is waiting.',
    'Semasa bersedia untuk penghantaran, anda mendapati muatan tidak dikunci dengan sempurna dan pelanggan sedang menunggu.',
    '["Pause and secure the cargo before proceeding", "Continue carefully and address it afterward", "Proceed to avoid delay and handle carefully", "Proceed while explaining the situation to the customer"]',
    '["Berhenti seketika dan pastikan muatan dikunci dengan betul sebelum meneruskan", "Teruskan dengan berhati-hati dan selesaikan isu kemudian", "Teruskan untuk mengelakkan kelewatan dan kendalikan dengan berhati-hati", "Teruskan sambil menerangkan keadaan kepada pelanggan"]',
    0,
    'Secure cargo before delivery despite time pressure.',
    'Pastikan muatan selamat sebelum meneruskan penghantaran walaupun terdapat tekanan masa.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '804dcf06-2536-4d15-ad5c-cbe41e9a99a7',
    0,
    'Before entering an industrial site, you have not completed the required pre-trip inspection.',
    'Sebelum memasuki tapak industri, anda belum melengkapkan pemeriksaan pra-perjalanan kenderaan.',
    '["Enter the site carefully and complete checks later", "Complete the inspection and follow site entry rules", "Rely on previous checks and proceed as directed", "Ask site staff to guide you inside immediately"]',
    '["Masuk ke tapak dengan berhati-hati dan lakukan pemeriksaan kemudian", "Lengkapkan pemeriksaan dan patuhi peraturan kemasukan tapak", "Bergantung pada pemeriksaan sebelumnya dan teruskan seperti diarahkan", "Minta kakitangan tapak membimbing anda masuk segera"]',
    1,
    'Complete inspections before site entry to ensure readiness and compliance.',
    'Lengkapkan pemeriksaan sebelum memasuki tapak untuk memastikan kesiapsiagaan dan pematuhan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '930aa0d3-a99b-431d-a280-52e35893c886',
    0,
    'While waiting inside a confined site area, the vehicle is idling near structures and pedestrians.',
    'Semasa menunggu di kawasan tapak yang sempit, enjin masih hidup berhampiran struktur dan pejalan kaki.',
    '["Keep the engine idling so you can move off quickly", "Switch off the engine while waiting", "Keep idling until instructed to move", "Remain stationary with the engine running"]',
    '["Biarkan enjin hidup supaya boleh bergerak segera", "Matikan enjin semasa menunggu", "Terus biarkan enjin hidup sehingga diarahkan bergerak", "Kekal berhenti dengan enjin masih hidup"]',
    1,
    'Switching off the engine when stationary reduces risk and unnecessary exposure in confined areas.',
    'Matikan enjin semasa berhenti untuk kurangkan risiko dan pendedahan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '05ea5b64-657c-488b-8d68-d52ef54d7172',
    0,
    'During a delivery, a customer begins recording your interaction on a mobile phone.',
    'Semasa penghantaran, seorang pelanggan mula merakam interaksi anda menggunakan telefon bimbit.',
    '["Continue the discussion calm and professional", "Ask the customer to stop recording before continuing", "Keep responses brief and focus on completing the task", "Proceed with the delivery without acknowledging the recording"]',
    '["Teruskan perbincangan dengan tenang dan profesional", "Minta pelanggan berhenti merakam sebelum meneruskan", "Jawab secara ringkas dan fokus untuk selesaikan tugas", "Teruskan penghantaran tanpa mengendahkan rakaman"]',
    0,
    'Maintaining professional behaviour protects your image when interactions are visible or recorded.',
    'Kekalkan tingkah laku profesional apabila interaksi dirakam atau dilihat orang lain.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4ddf6c58-4980-4519-b444-4638ae2d8150',
    0,
    'During unloading, a disagreement with site staff begins to escalate over the unloading sequence.',
    'Semasa proses memunggah, berlaku perbezaan pendapat dengan kakitangan tapak mengenai turutan memunggah muatan dan keadaan mula menjadi tegang.',
    '["Pause briefly, acknowledge the concern, and suggest resolving it calmly", "Explain in detail why your unloading sequence is correct and safer", "Continue unloading quietly to avoid making the situation worse", "Justify your approach so everyone understands your reasoning"]',
    '["Berhenti seketika dan bincang dengan tenang", "Terangkan dengan panjang lebar mengapa turutan anda lebih betul dan selamat", "Teruskan proses memunggah secara senyap untuk elak keadaan menjadi lebih tegang", "Pertahankan cara anda supaya semua faham sebabnya"]',
    0,
    'Pausing and responding calmly helps defuse tension.',
    'Berhenti seketika dan beri respons dengan tenang membantu redakan ketegangan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4c2b0a90-9bb2-4da1-b4de-49efed2cb735',
    0,
    'After unloading, someone pressures you to change delivery records so the issue does not escalate.',
    'Selepas proses memunggah, seseorang menekan anda supaya mengubah rekod penghantaran agar isu tersebut tidak menjadi lebih besar.',
    '["Say the records must stay as they are and continue calmly", "Change the records slightly so the discussion can end", "Leave the records for now to avoid further disagreement", "Explain repeatedly why the records cannot be changed"]',
    '["Nyatakan rekod mesti kekal seperti sedia ada dan teruskan dengan tenang", "Ubah sedikit rekod supaya perbincangan boleh dihentikan", "Biarkan rekod dahulu untuk elak pertelingkahan lanjut", "Terangkan berulang kali mengapa rekod tidak boleh diubah"]',
    0,
    'Keeping records accurate while staying calm helps prevent conflict from escalating.',
    'Kekalkan rekod yang tepat sambil bersikap tenang untuk elakkan keadaan menjadi lebih tegang.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '43b7e7f0-0b21-4c9f-a5fa-ea75355fffb9',
    0,
    'While driving through a community area, people nearby gesture for you to slow down as you pass.',
    'Semasa melalui kawasan komuniti, orang di sekitar memberi isyarat supaya anda memperlahankan kenderaan.',
    '["Reduce speed and continue driving considerately", "Maintain your speed since you are within the limit", "Slow briefly, then resume your previous speed", "Focus ahead and avoid reacting to the gestures"]',
    '["Kurangkan kelajuan dan teruskan pemanduan dengan penuh pertimbangan", "Kekalkan kelajuan kerana masih dalam had yang dibenarkan", "Perlahankan seketika, kemudian sambung semula kelajuan asal", "Fokus ke hadapan dan abaikan isyarat tersebut"]',
    0,
    'Adjusting speed in response to community signals shows courtesy and respect for local conditions.',
    'Melaras kelajuan mengikut keadaan setempat menunjukkan sikap hormat dan prihatin terhadap komuniti.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '25252e58-a955-4233-b12a-bda0b9a289af',
    0,
    'In a local area, another driver gestures courteously for you to merge while traffic slows.',
    'Di kawasan tempatan, seorang pemandu memberi isyarat sopan untuk membenarkan anda masuk ketika trafik semakin perlahan.',
    '["Signal clearly and merge when safe", "Merge promptly to return the courtesy", "Hesitate briefly to avoid appearing disrespectful", "Acknowledge the gesture and continue moving"]',
    '["Beri isyarat dengan jelas dan masuk apabila selamat", "Masuk segera untuk membalas kesopanan tersebut", "Tangguh seketika supaya tidak kelihatan tidak menghormati", "Balas isyarat tersebut dan teruskan bergerak"]',
    0,
    'Clear signalling should guide merging decisions, even when courtesy is shown by others.',
    'Isyarat yang jelas dan pertimbangan keselamatan perlu menjadi panduan walaupun diberi laluan oleh pemandu lain.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f32e617b-4f3b-4d50-8eef-dbde5ba11cd5',
    0,
    'You plan to install a sun shade, dark tint film, or stickers on the company truck windscreen.',
    'Anda bercadang memasang pelindung matahari, filem gelap, atau pelekat pada cermin hadapan lori syarikat.',
    '["Install them if they do not block the main driving view.", "Do not install them without company approval.", "Use removable shades only during daytime driving.", "Check whether other drivers have done similar modifications."]',
    '["Pasang jika tidak menghalang pandangan utama ketika memandu.", "Jangan pasang tanpa kelulusan syarikat.", "Gunakan pelindung yang boleh ditanggalkan pada waktu siang sahaja.", "Periksa sama ada pemandu lain pernah membuat perubahan yang sama."]',
    1,
    'Avoid unauthorised vehicle modifications that may affect safety or compliance.',
    'Elakkan pengubahsuaian kenderaan tanpa kelulusan yang boleh menjejaskan keselamatan atau pematuhan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '117ff62a-3273-4683-8c21-15edf9e3293f',
    0,
    'You have been on duty for 10 hours and are asked to continue working.',
    'Anda telah bertugas selama 10 jam dan diminta untuk terus bekerja.',
    '["Continue if the remaining task is short.", "Stop working after reaching the 10-hour limit.", "Work another hour and rest later.", "Continue if traffic conditions are light."]',
    '["Teruskan jika baki tugasan adalah singkat.", "Hentikan bekerja selepas mencapai had 10 jam.", "Bekerja satu jam lagi dan berehat kemudian.", "Teruskan jika keadaan trafik tidak sibuk."]',
    1,
    'Adhere to the maximum daily working hour limit.',
    'Patuhi had maksimum waktu kerja harian.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c557f142-e116-44ff-ba79-af840ece4f8e',
    0,
    'Your goods vehicle is experiencing failure on a highway and you are placing safety cones behind it.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda sedang meletakkan kon keselamatan di belakangnya.',
    '["Place cones a few metres behind the vehicle to alert nearby traffic.", "Position cones to the rear, spaced about 10 metres apart.", "Place one cone directly behind the vehicle as a marker.", "Set the cones beside the vehicle to save time."]',
    '["Letakkan kon beberapa meter di belakang kenderaan untuk memberi amaran kepada trafik berhampiran.", "Letakkan kon di bahagian belakang dengan jarak kira-kira 10 meter antara satu sama lain.", "Letakkan satu kon tepat di belakang kenderaan sebagai penanda.", "Letakkan kon di sisi kenderaan untuk menjimatkan masa."]',
    1,
    'Position warning devices correctly to provide clear rear hazard warning.',
    'Letakkan alat amaran dengan jarak yang sesuai untuk memberi amaran yang jelas kepada trafik dari belakang.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ebebdba0-8c7e-446d-904c-7f1a3948b000',
    0,
    'During inspection, you realise the vehicle has no working torchlight.',
    'Semasa pemeriksaan, anda mendapati tiada lampu suluh yang berfungsi di dalam kenderaan.',
    '["Proceed if driving is during daytime only.", "Replace the torchlight before operating the vehicle.", "Use your phone light if needed.", "Continue since other safety items are present."]',
    '["Teruskan perjalanan jika pemanduan hanya pada waktu siang.", "Gantikan lampu suluh tersebut sebelum mengendalikan kenderaan.", "Gunakan lampu telefon bimbit jika perlu.", "Teruskan kerana peralatan keselamatan lain masih ada."]',
    1,
    'Ensure required safety equipment is present and functional.',
    'Pastikan peralatan keselamatan yang diperlukan tersedia dan berfungsi dengan baik.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '78645ef4-cfda-42b3-8b32-ff6e539e8596',
    0,
    'Before starting your trip, you review the vehicle''s licensing documents.',
    'Sebelum memulakan perjalanan, anda menyemak dokumen lesen kenderaan.',
    '["Proceed if the documents were checked last month.", "Verify that all required vehicle licences are valid.", "Continue driving and check only if stopped.", "Rely on the office to monitor document validity."]',
    '["Teruskan perjalanan jika dokumen telah diperiksa bulan lepas.", "Pastikan semua lesen kenderaan yang diperlukan masih sah.", "Terus memandu dan semak hanya jika ditahan.", "Bergantung kepada pejabat untuk memantau tempoh sah dokumen."]',
    1,
    'Ensure vehicle licensing documents are valid before operating.',
    'Pastikan semua dokumen lesen kenderaan masih sah sebelum mengendalikan kenderaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '98f0d12f-ebac-4157-a1d8-965174b9d402',
    0,
    'You are scheduled to begin duty at 5:00 AM.',
    'Anda dijadualkan untuk memulakan tugas pada pukul 8:00 pagi.',
    '["Arrive early to prepare before starting duty.", "Arrive exactly at 8:00 AM and prepare afterward.", "Arrive a few minutes late if traffic is light.", "Inform colleagues to cover while you arrive."]',
    '["Tiba lebih awal untuk membuat persediaan sebelum bertugas.", "Tiba tepat pukul 8:00 pagi dan buat persediaan selepas itu.", "Tiba lewat beberapa minit jika trafik lancar.", "Maklumkan rakan sekerja untuk mengambil alih tugas sementara anda tiba."]',
    0,
    'Arrive early to prepare and start duty on time.',
    'Tiba lebih awal untuk membuat persediaan dan memulakan tugas tepat pada masanya.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fde6c700-1b21-4d07-9ae0-ff3e7d276aa1',
    0,
    'Before starting a trip, you check the prime mover and trailer documents.',
    'Sebelum memulakan perjalanan, anda menyemak dokumen kepala lori dan treler.',
    '["Ensure the permit, road tax, and inspection certificate are valid.", "Proceed if the road tax is still valid.", "Check only the prime mover documents.", "Verify documents only when stopped by enforcement."]',
    '["Pastikan permit, cukai jalan dan sijil pemeriksaan masih sah.", "Teruskan perjalanan jika cukai jalan masih sah.", "Periksa dokumen kepala lori sahaja.", "Sahkan dokumen hanya apabila ditahan penguat kuasa."]',
    0,
    'Ensure all required vehicle documents are valid before operating.',
    'Pastikan semua dokumen kenderaan yang diperlukan masih sah sebelum beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd4026daa-9bb6-4a9a-b4d2-21dfb1ed4e59',
    0,
    'Before leaving the port, you check the container seal.',
    'Sebelum meninggalkan pelabuhan, anda memeriksa seal kontena.',
    '["Proceed if the seal appears attached.", "Ensure the seal is properly locked before departure.", "Leave immediately if the container door is closed.", "Rely on port staff to confirm the seal."]',
    '["Teruskan perjalanan jika seal kelihatan terpasang.", "Pastikan seal dikunci dengan betul sebelum bertolak.", "Bertolak segera jika pintu kontena telah ditutup.", "Bergantung kepada kakitangan pelabuhan untuk mengesahkan seal."]',
    1,
    'Ensure the container seal is securely locked before departure.',
    'Pastikan seal kontena dikunci dengan selamat sebelum bertolak.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e2620346-f2a2-4ae2-8fa0-9c7ab4cba465',
    0,
    'Before leaving the port, you find the container door slightly misaligned.',
    'Sebelum meninggalkan pelabuhan, anda mendapati pintu kontena sedikit tidak sejajar.',
    '["Record the door condition in the gate pass.", "Proceed since it can still be locked.", "Deliver first and update later.", "Ignore if seal is intact."]',
    '["Rekodkan keadaan pintu pada gate pass.", "Teruskan perjalanan kerana pintu masih boleh dikunci.", "Hantar dahulu dan kemas kini kemudian.", "Abaikan keadaan jika seal masih baik."]',
    0,
    'Record any container door defect in the gate pass before exit.',
    'Rekodkan sebarang kecacatan pintu kontena pada gate pass sebelum keluar.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6bcff4b2-0d72-4b45-bc49-39c04be730f4',
    0,
    'You notice damage on the container but are unsure whether the cargo inside is affected.',
    'Anda mendapati terdapat kerosakan pada kontena dan tidak pasti sama ada muatan di dalamnya terjejas.',
    '["Inform operations and wait for instruction.", "Proceed if the seal is intact.", "Deliver first and inspect at destination.", "Continue if external damage appears minor."]',
    '["Maklumkan bahagian operasi dan tunggu arahan lanjut.", "Teruskan perjalanan jika seal masih utuh.", "Hantar dahulu dan periksa di lokasi penghantaran.", "Teruskan perjalanan jika kerosakan luar kelihatan kecil."]',
    0,
    'Report uncertain damage before moving the container.',
    'Laporkan kerosakan yang tidak pasti sebelum menggerakkan kontena.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '367904d0-78fd-4abf-9189-31bb28fe7e56',
    0,
    'During a delivery, a customer raises their voice and provokes you.',
    'Semasa membuat penghantaran, seorang pelanggan meninggikan suara dan memprovokasi anda.',
    '["Respond firmly to defend your position.", "Avoid confrontation and report to operations.", "Leave the site immediately without informing anyone.", "Continue arguing until the issue is resolved."]',
    '["Bertindak balas dengan tegas untuk mempertahankan diri.", "Elakkan pertelingkahan dan laporkan kepada bahagian operasi.", "Tinggalkan tapak serta-merta tanpa memaklumkan kepada sesiapa.", "Terus berdebat sehingga isu selesai."]',
    1,
    'Do not engage in confrontation; report the matter to operations.',
    'Elakkan pertelingkahan dan laporkan perkara tersebut kepada bahagian operasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'edaf9afd-c05f-4637-82b7-075dc8e21a62',
    0,
    'After a collision, the third party offers to settle repair costs privately.',
    'Selepas pelanggaran, pihak ketiga menawarkan untuk menyelesaikan kos pembaikan secara persendirian.',
    '["Accept the offer to avoid paperwork.", "Inform operations and wait for instruction.", "Negotiate and settle on the spot.", "Accept payment and continue duty."]',
    '["Terima tawaran untuk mengelakkan urusan dokumentasi.", "Maklumkan bahagian operasi dan tunggu arahan selanjutnya.", "Berunding dan selesaikan di tempat kejadian.", "Terima bayaran dan teruskan tugas."]',
    1,
    'Do not agree to private settlements without company instruction.',
    'Jangan bersetuju dengan penyelesaian persendirian tanpa arahan syarikat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bf53d2f0-05d0-4ca1-b59f-a4d41581ceb0',
    0,
    'Your vehicle is carrying chemical cargo and is involved in an accident.',
    'Kenderaan anda membawa muatan bahan kimia dan terlibat dalam kemalangan.',
    '["Inform operations of the cargo type and any hazard risk.", "Report the vehicle damage.", "Wait for emergency responders to identify the cargo.", "Mention cargo details when asked."]',
    '["Maklumkan kepada bahagian operasi jenis muatan dan sebarang risiko bahaya.", "Laporkan kerosakan kenderaan.", "Tunggu pasukan kecemasan mengenal pasti jenis muatan.", "Nyatakan butiran muatan bila ditanya."]',
    0,
    'Communicate cargo hazards immediately during an accident.',
    'Maklumkan risiko bahaya muatan dengan segera semasa kemalangan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7390e42c-d6ef-48fa-bd97-6e1ef5b5547d',
    0,
    'You drive at cruising speed. Vehicles ahead brake intermittently and motorcycles filter between lanes.',
    'Anda memandu pada kelajuan tetap. Kenderaan di hadapan membrek dan motosikal bergerak di antara lorong.',
    '["Increase following distance for sudden slowing", "Maintain distance and brake if traffic slows", "Move closer to match the pace ahead", "Change lanes to avoid unpredictable movement"]',
    '["Tambah jarak kenderaan untuk lebih bersedia", "Kekalkan jarak dan brek jika trafik perlahan", "Bergerak lebih dekat untuk ikut kelajuan di hadapan", "Tukar lorong untuk elakkan pergerakan tidak menentu"]',
    0,
    'Extra space gives more time to respond to hazards ahead.',
    'Ruang tambahan memberi lebih masa untuk bertindak terhadap bahaya di hadapan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a49355bd-ceb7-4442-8c4e-310da8da2648',
    0,
    'You drive at night in heavy rain. Spray from vehicles ahead reduces visibility.',
    'Anda memandu pada waktu malam dalam keadaan hujan lebat. Percikan air dari kenderaan di hadapan mengurangkan pandangan.',
    '["Increase following distance for more reaction time", "Maintain distance since traffic speed is steady", "Close the gap to keep sight of the vehicle ahead", "Keep the same distance and react if traffic slows"]',
    '["Tambah jarak kenderaan untuk lebih masa bertindak", "Kekalkan jarak kerana kelajuan trafik stabil", "Rapatkan jarak untuk mengekalkan pandangan kenderaan di hadapan", "Kekalkan jarak dan bertindak jika trafik perlahan"]',
    0,
    'Increase spacing in poor visibility to manage sudden slowing safely.',
    'Tingkatkan jarak antara kenderaan ketika penglihatan terhad bagi menangani tindakan brek mengejut dengan selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ae63528c-c3c9-4b16-8567-a82c6ae24c22',
    0,
    'You are inside a container terminal where RTGs operate across marked lanes with clear zones.',
    'Anda berada di dalam terminal kontena di mana RTG beroperasi merentasi lorong bertanda dengan zon larangan.',
    '["Remain outside the clear zone until access is given", "Move along the lane edge while staying alert", "Advance slowly when the RTG appears to reposition", "Follow the vehicle ahead past the RTG"]',
    '["Kekal di luar zon larangan sehingga laluan dibenarkan", "Bergerak di tepi lorong sambil kekal peka", "Bergerak perlahan apabila RTG kelihatan beralih", "Ikut kenderaan di hadapan melepasi RTG"]',
    0,
    'Respect clear zones and wait for safe access near lifting equipment.',
    'Hormati zon larangan dan tunggu laluan selamat berhampiran jentera angkat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'dd9cb230-1a61-47b3-bae3-763128c19d33',
    0,
    'Inside a site yard, you merge into an internal lane while equipment operates nearby.',
    'Di dalam kawasan tapak, anda perlu masuk ke lorong dalaman sementara jentera beroperasi berhampiran.',
    '["Wait for a clear gap with safe equipment clearance", "Merge when a small gap appears to maintain flow", "Move forward gradually to secure space", "Follow the vehicle ahead into the lane"]',
    '["Tunggu ruang jelas dengan jarak selamat daripada jentera", "Masuk apabila terdapat ruang kecil untuk kekalkan aliran trafik", "Bergerak ke hadapan secara beransur untuk mendapatkan ruang", "Ikut kenderaan di hadapan masuk ke lorong"]',
    0,
    'Choose a clear gap and keep safe distance from operating equipment.',
    'Tunggu ruang yang jelas dan kekalkan jarak selamat dari jentera beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b58b03a9-b26b-4d13-9bf7-23ede82024d4',
    0,
    'You approach an area where containers are being lifted and repositioned. Equipment movement is ongoing.',
    'Anda menghampiri kawasan di mana kontena sedang dialihkan. Jentera masih beroperasi.',
    '["Stop outside the lifting zone until operations are complete", "Proceed slowly while monitoring the lifting activity", "Continue moving and adjust if equipment comes closer", "Follow another vehicle that enters the zone"]',
    '["Berhenti di luar zon pengangkatan sehingga operasi selesai", "Terus bergerak perlahan sambil memantau aktiviti pengangkatan", "Terus bergerak dan sesuaikan kedudukan jika jentera menghampiri", "Ikut kenderaan lain yang memasuki zon tersebut"]',
    0,
    'Keep clear of active lifting zones.',
    'Jauhi zon pengangkatan yang sedang aktif.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '635a06dd-cb5d-4f32-8e98-7db6aaa057df',
    0,
    'After a delivery, you park in a designated area where idling is prohibited.',
    'Selepas penghantaran, anda parkir di kawasan yang ditetapkan di mana enjin tidak dibenarkan hidup.',
    '["Switch off the engine and follow the parking procedure", "Leave the engine running briefly to save time", "Complete the procedure and address the engine later", "Wait in the vehicle with the engine on"]',
    '["Matikan enjin dan ikut prosedur parkir", "Biarkan enjin hidup seketika untuk menjimatkan masa", "Lengkapkan prosedur dahulu dan matikan enjin kemudian", "Tunggu di dalam kenderaan dengan enjin masih hidup"]',
    0,
    'Follow procedures and switch off the engine where idling is prohibited.',
    'Ikut prosedur dan matikan enjin di kawasan yang melarang melahu enjin.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd535df41-bad4-456f-bf12-dd1720d1414e',
    0,
    'While driving inside a site with pedestrians and equipment moving nearby, your phone receives a message.',
    'Semasa memandu di dalam tapak dengan pekerja dan jentera bergerak berhampiran, telefon anda menerima mesej.',
    '["Ignore the message and maintain full attention", "Check the message briefly since speed is low", "Slow down and glance when the area looks clear", "Respond quickly."]',
    '["Abaikan mesej dan kekalkan tumpuan penuh", "Periksa mesej seketika kerana kelajuan rendah", "Perlahankan dan lihat mesej apabila kawasan kelihatan selamat", "Balas mesej dengan cepat."]',
    0,
    'Avoid distractions in mixed-movement areas.',
    'Elakkan gangguan di kawasan pergerakan bercampur.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f7588c58-07bb-4319-9107-26d8b63d3a87',
    0,
    'After a pre-trip inspection, you notice a twist lock is not fully secured though the container appears stable.',
    'Selepas pemeriksaan sebelum perjalanan, anda mendapati twist lock tidak dikunci sepenuhnya walaupun kontena kelihatan stabil.',
    '["Secure the twist lock before departing", "Start the trip but drive carefully", "Proceed since the container appears stable", "Monitor the load and act if it shifts"]',
    '["Pastikan twist lock dikunci dengan betul sebelum bergerak", "Mulakan perjalanan tetapi memandu dengan berhati-hati", "Teruskan kerana kontena kelihatan stabil", "Pantau muatan semasa perjalanan dan bertindak jika ia bergerak"]',
    0,
    'Correct load security issues before moving.',
    'Pastikan keselamatan muatan disahkan sebelum bergerak.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '08912a74-6b64-472a-bc02-0f2cabe60132',
    0,
    'During a slow loading manoeuvre in a confined space, a nearby worker offers guidance.',
    'Semasa manuver perlahan untuk pemuatan di ruang sempit, seorang pekerja memberi panduan.',
    '["Pause and coordinate clearly with the worker before continuing", "Continue manoeuvring slowly and rely on hand signals as they appear", "Proceed carefully without engaging to avoid confusion", "Continue cautiously while listening for instructions and adjusting if needed"]',
    '["Berhenti seketika dan sesuaikan komunikasi dengan pekerja sebelum meneruskan", "Teruskan manuver perlahan dan bergantung pada isyarat tangan yang diberi", "Teruskan dengan berhati-hati tanpa berinteraksi untuk elakkan kekeliruan", "Teruskan dengan berhati-hati sambil mendengar arahan dan melaras jika perlu"]',
    0,
    'Clear coordination during manoeuvres helps prevent damage and supports safe cooperation.',
    'Koordinasi yang jelas semasa manuver membantu mencegah kerosakan dan menyokong kerjasama yang selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c8c45333-7245-425f-8825-ab3f94b52a1e',
    0,
    'While moving through a busy site, you feel abnormal resistance and hear a new mechanical sound.',
    'Semasa bergerak di tapak yang sibuk, anda merasakan rintangan tidak normal dan bunyi mekanikal baharu.',
    '["Continue moving slowly to clear the area", "Stop safely, assess the issue, and proceed only when clear", "Adjust steering and throttle to maintain site flow", "Complete the movement and report the issue afterward"]',
    '["Terus bergerak perlahan untuk keluar dari kawasan itu", "Berhenti di tempat selamat, periksa keadaan, dan teruskan hanya apabila jelas selamat", "Laraskan stereng dan pendikit untuk mengekalkan aliran pergerakan tapak", "Selesaikan pergerakan dan laporkan masalah selepas itu"]',
    1,
    'Respond promptly to mechanical cues and ensure the area is safe before proceeding.',
    'Bertindak segera terhadap tanda mekanikal dan pastikan kawasan selamat sebelum meneruskan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '79ecb32f-8766-4823-afc1-dc3c7f70dd9b',
    0,
    'At a site gate, you notice a wheel chock and tool left unsecured on the vehicle before entry.',
    'Di pintu masuk tapak, anda perasan pengadang tayar dan peralatan tidak diikat kemas pada kenderaan sebelum masuk.',
    '["Enter the site and secure them at the first parking point", "Secure the items before entering the site", "Proceed inside since the items are not in use", "Ask security to allow entry first"]',
    '["Masuk tapak dan kemaskan di tempat parkir pertama", "Kemaskan dahulu sebelum masuk tapak", "Terus masuk kerana alat itu tidak digunakan", "Minta kebenaran masuk daripada pengawal dahulu"]',
    1,
    'Securing loose equipment before entry prevents avoidable risks inside controlled areas.',
    'Kemaskan peralatan sebelum masuk tapak untuk elakkan risiko.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0d8abb46-e70e-4767-8b0e-d6f7cefb308e',
    0,
    'A customer asks you to change delivery details on the paperwork.',
    'Seorang pelanggan meminta anda mengubah butiran penghantaran dalam dokumen.',
    '["Complete the paperwork accurately and explain the situation", "Adjust the delivery details as requested by the customer", "Leave the paperwork unchanged and submit it later", "Submit the paperwork as requested without explanation"]',
    '["Lengkapkan dokumen dengan tepat dan jelaskan keadaan sebenar", "Ubah butiran penghantaran seperti diminta", "Biarkan dokumen seperti itu dan serahkan kemudian", "Serahkan dokumen seperti diminta tanpa penjelasan"]',
    0,
    'Accurate documentation ensures transparency and protects everyone involved.',
    'Dokumentasi yang tepat memastikan ketelusan dan melindungi semua pihak.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '844e3b04-f0d1-435a-ad1c-fd18711a3c81',
    0,
    'During unloading, a tense exchange with site staff starts attracting attention from people nearby.',
    'Semasa proses memunggah, perbualan tegang dengan kakitangan tapak mula menarik perhatian orang di sekeliling.',
    '["Keep your tone calm and behaviour professional", "Explain your actions in detail so observers understand your position", "Continue the task while limiting further interaction", "Justify your response to avoid appearing at fault"]',
    '["Kekalkan nada tenang dan tingkah laku profesional", "Terangkan tindakan anda dengan terperinci supaya orang lain faham", "Teruskan tugas sambil hadkan interaksi lanjut", "Jelaskan respons anda untuk elak kelihatan bersalah"]',
    0,
    'Maintaining calm, professional behaviour protects your image when situations draw public attention.',
    'Kekalkan sikap tenang dan profesional apabila situasi menarik perhatian orang ramai.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd25dd73e-0a3b-4edd-81f4-295ac482d748',
    0,
    'During a delivery, a customer explains that a small personal gift is customary in their culture.',
    'Semasa penghantaran, seorang pelanggan menjelaskan bahawa pemberian kecil peribadi adalah amalan dalam budayanya.',
    '["Decline respectfully and continue with the delivery as planned", "Accept briefly to avoid appearing disrespectful", "Delay responding and see how others handle it", "Explain carefully why such gifts can cause problems"]',
    '["Tolak dengan hormat dan teruskan penghantaran seperti dirancang", "Terima seketika supaya tidak kelihatan tidak hormat", "Tangguhkan respons dan lihat bagaimana orang lain bertindak", "Terangkan dengan teliti mengapa pemberian itu boleh menimbulkan isu"]',
    0,
    'Respecting culture does not require accepting gifts that compromise integrity.',
    'Menghormati budaya tidak bermaksud menerima pemberian yang boleh menjejaskan integriti.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '13ace5b5-f396-4b0b-b9f0-6ea61f79f39b',
    0,
    'You approach a road section with temporary cones where pedestrians are crossing near your lane.',
    'Anda menghampiri laluan yang dipasang kon sementara dengan pejalan kaki melintas berhampiran lorong anda.',
    '["Maintain correct lane position and proceed cautiously past the area", "Move closer to the lane edge to pass through more quickly", "Adjust position to follow vehicles ahead without slowing", "Focus on traffic flow and avoid reacting to people nearby"]',
    '["Kekalkan kedudukan lorong yang betul dan pandu dengan berhati-hati melalui kawasan tersebut", "Rapat ke tepi lorong untuk melepasi kawasan dengan lebih cepat", "Laraskan kedudukan mengikut kenderaan di hadapan tanpa memperlahankan", "Fokus pada aliran trafik dan abaikan orang di sekitar"]',
    0,
    'Maintaining lane discipline and caution protects pedestrians and reflects responsible public conduct.',
    'Disiplin lorong dan pemanduan berhati-hati melindungi pejalan kaki serta mencerminkan sikap bertanggungjawab di tempat awam.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a6ee772d-e1f8-4f30-bffe-5ffdd08eb491',
    0,
    'You prepare to merge into a moving lane when another driver accelerates and blocks the available gap.',
    'Anda bersedia untuk masuk ke lorong yang sedang bergerak apabila seorang pemandu lain memecut dan menutup ruang yang ada.',
    '["Hold back and wait for a clearer gap", "Force the merge to assert your position", "Move closer to pressure the other driver to yield", "Gesture briefly to signal dissatisfaction"]',
    '["Tahan dan tunggu ruang yang lebih jelas serta selamat", "Paksa masuk untuk mempertahankan kedudukan anda", "Rapatkan kenderaan untuk memberi tekanan supaya pemandu lain mengalah", "Buat isyarat ringkas tanda tidak puas hati"]',
    0,
    'Waiting for a safe gap and avoiding confrontation reduces risk and prevents unnecessary conflict.',
    'Menunggu ruang yang selamat dan mengelakkan konfrontasi membantu mengurangkan risiko serta ketegangan di jalan raya.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ba730a3c-d473-4956-9fea-415aa544e508',
    0,
    'You have completed 8 hours of driving for the day and one nearby delivery remains.',
    'Anda telah memandu selama 8 jam pada hari itu dan satu penghantaran berhampiran masih belum selesai.',
    '["Continue driving to complete the final delivery.", "Stop driving and report reaching the daily limit.", "Drive for another 30 minutes before stopping.", "Reduce speed and complete the delivery carefully."]',
    '["Terus memandu untuk menyelesaikan penghantaran terakhir.", "Hentikan pemanduan dan laporkan bahawa had harian telah dicapai.", "Memandu lagi selama 30 minit sebelum berhenti.", "Kurangkan kelajuan dan selesaikan penghantaran dengan berhati-hati."]',
    1,
    'Follow driving hour limits to maintain safety and compliance.',
    'Patuhi had waktu pemanduan untuk menjaga keselamatan dan pematuhan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd7f76814-7ce7-4320-a836-dc58cf95fcfd',
    0,
    'You have worked six consecutive days and are scheduled for another duty.',
    'Anda telah bekerja selama enam hari berturut-turut dan dijadualkan untuk bertugas lagi.',
    '["Continue working if you feel fit.", "Take one rest day after six working days.", "Work half a day before taking leave.", "Swap shifts without taking a rest day."]',
    '["Terus bekerja jika anda berasa cergas.", "Ambil satu hari rehat selepas enam hari bekerja.", "Bekerja separuh hari sebelum mengambil cuti.", "Tukar syif tanpa mengambil hari rehat."]',
    1,
    'Take the required rest day after six consecutive working days.',
    'Ambil hari rehat yang ditetapkan selepas bekerja enam hari berturut-turut.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd85379c6-c18a-4c5f-828e-dfa87b78aacc',
    0,
    'Your goods vehicle is experiencing failure on a highway and you are placing a warning triangle.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda sedang meletakkan segi tiga amaran.',
    '["Place it a few metres behind the vehicle for quick visibility.", "Place it about 50 metres to the rear of the vehicle.", "Place it beside the vehicle near the shoulder.", "Hold it while standing near traffic to alert drivers."]',
    '["Letakkan beberapa meter di belakang kenderaan supaya mudah dilihat dengan cepat.", "Letakkan kira-kira 50 meter di belakang kenderaan.", "Letakkan di sisi kenderaan berhampiran bahu jalan.", "Pegang sambil berdiri berhampiran trafik untuk memberi amaran."]',
    1,
    'Position warning devices at a safe rear distance to alert approaching traffic early.',
    'Letakkan alat amaran pada jarak selamat di belakang kenderaan untuk memberi amaran awal kepada trafik yang menghampiri.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '15e34a8c-a9b0-40bd-9043-3a416a07b5d0',
    0,
    'You check the vehicle and the warning triangle is missing.',
    'Anda memeriksa kenderaan dan mendapati segi tiga amaran tiada.',
    '["Continue driving if hazard lights are working.", "Replace the safety triangle before departure.", "Borrow one only when needed.", "Use cones instead of a triangle."]',
    '["Terus memandu jika lampu kecemasan berfungsi.", "Gantikan segi tiga amaran sebelum memulakan perjalanan.", "Pinjam satu hanya apabila diperlukan.", "Gunakan kon sebagai ganti segi tiga amaran."]',
    1,
    'Carry the required warning triangle before operating.',
    'Bawa segi tiga amaran yang diperlukan sebelum mengendalikan kenderaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '92e32f07-5a3f-4d79-900e-f8303f54e1f5',
    0,
    'During inspection, you check the engine system before departure.',
    'Semasa pemeriksaan, anda memeriksa sistem enjin sebelum memulakan perjalanan.',
    '["Skip the check if the engine started normally.", "Verify the engine system as part of the safety inspection.", "Check only when warning lights appear.", "Inspect the engine only during scheduled servicing."]',
    '["Abaikan pemeriksaan jika enjin dapat dihidupkan seperti biasa.", "Sahkan sistem enjin sebagai sebahagian daripada pemeriksaan keselamatan.", "Periksa hanya apabila lampu amaran menyala.", "Periksa enjin hanya semasa servis berjadual."]',
    1,
    'Include engine system checks in daily safety inspections.',
    'Periksa sistem enjin setiap hari sebagai sebahagian daripada pemeriksaan keselamatan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9dbfb2dc-ff27-4294-bcf1-a0bc825e14e3',
    0,
    'You are starting and completing a delivery trip.',
    'Anda memulakan dan menamatkan satu perjalanan penghantaran.',
    '["Record the meter reading only at the end of the trip.", "Record the meter reading before and after the trip.", "Record it only if fuel usage seems unusual.", "Estimate the reading based on distance travelled."]',
    '["Catat bacaan meter hanya pada akhir perjalanan.", "Catat bacaan meter sebelum dan selepas perjalanan.", "Catat hanya jika penggunaan bahan api kelihatan luar biasa.", "Anggarkan bacaan berdasarkan jarak perjalanan."]',
    1,
    'Record meter readings before and after each trip.',
    'Catat bacaan meter sebelum dan selepas setiap perjalanan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '37203b60-63f7-4bd4-85df-551aad5efee1',
    0,
    'Before departure, you review the prime mover and trailer documents. One document has expired.',
    'Sebelum memulakan perjalanan, anda menyemak dokumen kepala lori dan treler. Salah satu dokumen telah tamat tempoh.',
    '["Proceed if the other documents are still valid.", "Inform operations and do not operate until resolved.", "Continue the trip and update after delivery.", "Drive and renew the document at the next service."]',
    '["Teruskan perjalanan jika dokumen lain masih sah.", "Maklumkan bahagian operasi dan jangan beroperasi sehingga diselesaikan.", "Teruskan perjalanan dan kemas kini selepas penghantaran selesai.", "Memandu dahulu dan perbaharui dokumen pada servis seterusnya."]',
    1,
    'Do not operate if required vehicle documents have expired and inform operations immediately.',
    'Jangan beroperasi jika dokumen kenderaan yang diperlukan telah tamat tempoh dan maklumkan kepada bahagian operasi segera.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bec41cd3-46d8-4ebd-a078-7df067f3f861',
    0,
    'Before exiting the port, you compare the seal number with the gate pass.',
    'Sebelum keluar dari pelabuhan, anda membandingkan nombor seal dengan maklumat pada gate pass.',
    '["Proceed if the seal is intact.", "Confirm the seal number matches the document.", "Check the number only at delivery point.", "Ignore minor number differences."]',
    '["Teruskan perjalanan jika seal kelihatan baik.", "Pastikan nombor seal sepadan dengan dokumen.", "Semak nombor hanya apabila tiba di lokasi penghantaran.", "Abaikan perbezaan kecil pada nombor."]',
    1,
    'Verify that the seal number matches the documented record.',
    'Pastikan nombor seal sepadan dengan rekod dalam dokumen sebelum berlepas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '498f6509-5849-4a8b-ac4e-43b68af09189',
    0,
    'You collect a container from a customer premise and notice exterior damage.',
    'Anda mengambil sebuah kontena dari premis pelanggan dan mendapati terdapat kerosakan pada bahagian luarnya.',
    '["Record it internally and inform operations.", "Inform the customer and proceed.", "Continue if the container is sealed.", "Deliver first and update later."]',
    '["Catat dalam rekod dalaman dan maklumkan bahagian operasi.", "Maklumkan pelanggan dan teruskan perjalanan.", "Teruskan jika kontena telah dimeterai.", "Hantar dahulu dan kemas kini kemudian."]',
    0,
    'Record and report container damage before movement.',
    'Rekodkan dan laporkan kerosakan kontena sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6d19883a-f9ec-4fc1-be77-41256ee3ef51',
    0,
    'You are uncertain about the extent of container or cargo damage.',
    'Anda tidak pasti tahap kerosakan pada kontena atau muatan di dalamnya.',
    '["Proceed cautiously and monitor during transit.", "Seek operations approval before movement.", "Inform the customer and continue.", "Move the container to a nearby safe area first."]',
    '["Teruskan perjalanan dengan berhati-hati dan pantau semasa perjalanan.", "Dapatkan kelulusan daripada bahagian operasi sebelum bergerak.", "Maklumkan kepada pelanggan dan teruskan perjalanan.", "Alihkan kontena ke kawasan selamat berhampiran terlebih dahulu."]',
    1,
    'Do not move the container without operations approval when damage is unclear.',
    'Jangan gerakkan kontena tanpa kelulusan bahagian operasi apabila tahap kerosakan tidak jelas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '840e3a7b-a461-490c-9d0c-c84efcd30f21',
    0,
    'While driving, a member of the public provokes you aggressively.',
    'Semasa memandu, seorang orang awam bertindak agresif dan memprovokasi anda.',
    '["React quickly to assert your position.", "Remain calm and report the incident.", "Stop and confront the person.", "Follow the person to clarify the issue."]',
    '["Bertindak segera untuk mempertahankan pendirian anda.", "Kekal tenang dan laporkan kejadian tersebut.", "Berhenti dan bersemuka dengan individu tersebut.", "Ikut individu tersebut untuk menjelaskan keadaan."]',
    1,
    'Avoid impulsive actions and report the incident appropriately.',
    'Kekal tenang dan laporkan kejadian dengan cara yang sesuai.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '365b3e18-8361-4d89-ab99-b09866303517',
    0,
    'While driving on a highway, you notice smoke coming from the trailer.',
    'Semasa memandu di lebuh raya, anda mendapati asap keluar dari treler.',
    '["Stop at a safe roadside area without blocking traffic.", "Continue slowly to reach the nearest rest area.", "Stop immediately in the current lane.", "Park close to nearby buildings for assistance."]',
    '["Berhenti di kawasan tepi jalan yang selamat tanpa menghalang trafik.", "Teruskan memandu perlahan untuk sampai ke kawasan rehat terdekat.", "Berhenti serta-merta di lorong semasa.", "Parkir berhampiran bangunan untuk mendapatkan bantuan."]',
    0,
    'Stop in a safe open area that does not obstruct traffic.',
    'Berhenti di kawasan terbuka yang selamat dan tidak menghalang trafik.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9279607d-aced-4737-a7d2-8353ce76c8e0',
    0,
    'After an accident, operations asks about injuries.',
    'Selepas kemalangan, bahagian operasi bertanya tentang kecederaan.',
    '["Confirm injuries to yourself and others involved.", "Say everyone seems fine without checking.", "Wait for medical staff to assess first.", "Report injuries after confirmed by hospital."]',
    '["Sahkan kecederaan kepada diri sendiri dan pihak yang terlibat.", "Maklumkan semua kelihatan baik tanpa membuat pemeriksaan.", "Tunggu petugas perubatan membuat penilaian terlebih dahulu.", "Laporkan kecederaan selepas disahkan oleh pihak hospital."]',
    0,
    'Provide accurate injury status information promptly.',
    'Berikan maklumat status kecederaan dengan tepat dan segera.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '32c0eb48-5bf7-425e-9e8a-91035181cef5',
    0,
    'You prepare to change lanes in steady traffic. Motorcycles filter between lanes and traffic slows near an exit.',
    'Anda bersedia untuk menukar lorong dalam trafik lancar. Motosikal bergerak di antara lorong dan trafik perlahan berhampiran susur keluar.',
    '["Signal early and complete full mirror checks before moving", "Signal as you move and rely on others to adjust", "Check mirrors quickly and move when the lane looks clear", "Wait for traffic to stabilise before signalling"]',
    '["Beri isyarat awal dan periksa cermin sepenuhnya sebelum bergerak", "Beri isyarat semasa bergerak dan harap pemandu lain menyesuaikan diri", "Periksa cermin dengan cepat dan bergerak apabila lorong kelihatan jelas", "Tunggu trafik stabil sebelum memberi isyarat"]',
    0,
    'Signal early and complete full checks before changing lanes.',
    'Beri isyarat awal dan lakukan pemeriksaan penuh sebelum menukar lorong.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '722f9263-0213-418c-a45a-6921cb1b5f92',
    0,
    'You drive inside a depot with marked lanes. Equipment operates nearby and stacked loads restrict visibility.',
    'Anda memandu di dalam depot dengan lorong bertanda. Jentera beroperasi berhampiran dan susunan muatan menghadkan pandangan.',
    '["Keep to the marked lane and slow until movement is clear", "Adjust position to see past the equipment", "Continue moving so you do not block equipment behind", "Proceed as usual and rely on operators"]',
    '["Kekalkan lorong bertanda dan perlahankan sehingga pergerakan jelas", "Sesuaikan kedudukan untuk melihat melepasi jentera", "Terus bergerak supaya tidak menghalang jentera di belakang", "Teruskan seperti biasa dan bergantung pada pengendali jentera"]',
    0,
    'Keep lane discipline and reduce speed near operating equipment.',
    'Amalkan disiplin lorong dan kurangkan kelajuan berhampiran peralatan beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '751bc27b-89c8-465e-ba96-9d8f72d0ad23',
    0,
    'At a container terminal, lifting operations are in progress. Vehicles and personnel move nearby.',
    'Di terminal kontena, operasi mengangkat kontena sedang dijalankan. Kenderaan dan pekerja bergerak berhampiran.',
    '["Keep clear of the lifting zone until the operation ends", "Move closer to observe the lift and prepare to move", "Wait nearby and approach when the container is almost down", "Move forward carefully to avoid delaying trucks behind"]',
    '["Jauhi zon pengangkatan sehingga operasi selesai", "Bergerak lebih dekat untuk memerhati operasi pengangkatan dan bersedia bergerak", "Tunggu berhampiran dan hampiri apabila kontena hampir diturunkan", "Bergerak ke hadapan dengan berhati-hati supaya tidak melambatkan lori di belakang"]',
    0,
    'Stay clear of lifting zones to avoid sudden movement and falling objects.',
    'Kekalkan jarak dari zon pengangkatan untuk elakkan pergerakan mengejut dan risiko objek jatuh.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '892feb32-fc0f-4d01-ad16-c1fb2d9b359e',
    0,
    'You approach an industrial access road. Surfaces are uneven, obstructions present, and visibility is reduced.',
    'Anda menghampiri laluan masuk kawasan industri. Permukaan jalan tidak rata, terdapat halangan, dan pandangan terhad.',
    '["Reduce speed early and adjust your path for hazards", "Maintain a cautious pace and react if conditions worsen", "Proceed steadily while focusing on the access route", "Follow the vehicle ahead navigating the area"]',
    '["Kurangkan kelajuan lebih awal dan sesuaikan laluan untuk elakkan bahaya", "Kekalkan kelajuan berhati-hati dan bertindak jika keadaan bertambah buruk", "Terus bergerak secara stabil sambil fokus pada laluan utama", "Ikut kenderaan di hadapan yang melalui kawasan itu"]',
    0,
    'Adjust early to surface and visibility risks to maintain control.',
    'Sesuaikan pemanduan lebih awal terhadap risiko permukaan dan pandangan untuk kekalkan kawalan kenderaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '10fd96b3-f4ef-4396-a142-ca73fd0eaeb4',
    0,
    'You prepare to park and deploy trailer landing legs on uneven ground.',
    'Anda bersedia untuk parkir dan menurunkan kaki sokongan treler di permukaan tidak rata.',
    '["Stop and ensure the ground is stable before deploying", "Deploy slowly and monitor for sinking", "Proceed as usual since the area is commonly used", "Rely on visual checks and adjust if movement appears"]',
    '["Berhenti dan pastikan permukaan stabil sebelum menurunkan kaki sokongan treler", "Turunkan secara perlahan dan pantau jika berlaku mendapan", "Teruskan seperti biasa kerana kawasan tersebut biasa digunakan", "Bergantung pada pemeriksaan visual dan pelarasan jika pergerakan berlaku"]',
    0,
    'Assess ground stability before deploying landing legs.',
    'Periksa kestabilan permukaan sebelum menurunkan kaki sokongan treler.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '30001f70-2fcb-47bd-bd13-4bd41c7918d0',
    0,
    'At a container terminal, lifting operations are in progress and you enter a marked lifting zone without a safety helmet.',
    'Di terminal kontena, operasi pengangkatan kontena sedang dijalankan dan anda memasuki zon pengangkatan tanpa topi keselamatan.',
    '["Put on the required PPE and remain clear of lifting", "Stay where you are since equipment is not moving toward you", "Move quickly through the area to minimise time", "Wait for terminal staff instructions before addressing PPE"]',
    '["Pakai PPE yang diperlukan dan kekal jauh dari operasi loading", "Kekal di tempat kerana jentera tidak bergerak ke arah anda", "Bergerak cepat melalui kawasan itu untuk kurangkan masa", "Tunggu arahan kakitangan terminal sebelum mengurus PPE"]',
    0,
    'Wear required PPE and keep clear of lifting zones.',
    'Pakai PPE yang diperlukan dan kekalkan jarak dari zon loading.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bf6589e3-2c97-4649-a991-8bcb56f61313',
    0,
    'While reversing to park, your phone receives a message.',
    'Semasa mengundur untuk parkir, telefon anda menerima mesej.',
    '["Ignore the message and complete the manoeuvre", "Pause and check the message before continuing", "Continue reversing while glancing at the phone", "Stop midway and respond to the message"]',
    '["Abaikan mesej dan selesaikan manuver", "Berhenti seketika dan periksa mesej sebelum meneruskan", "Terus mengundur sambil melihat telefon", "Berhenti di tengah dan balas mesej"]',
    0,
    'Avoid device use during manoeuvres.',
    'Elakkan penggunaan telefon semasa manuver.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5f6ee6de-7dbc-414c-a126-9405ca50f445',
    0,
    'After completing your trip, you notice a minor defect that developed during the drive.',
    'Selepas selesai perjalanan, anda mendapati kerosakan kecil berlaku semasa memandu.',
    '["Report the defect and ensure the vehicle is checked before reuse", "Note the defect later since the trip is completed", "Mention it informally to the next driver", "Leave the vehicle available since it still operates"]',
    '["Laporkan kerosakan dan pastikan kenderaan diperiksa sebelum digunakan semula", "Catat kerosakan kemudian kerana perjalanan telah selesai", "Beritahu secara tidak rasmi kepada pemandu seterusnya", "Biarkan kenderaan digunakan kerana masih boleh beroperasi"]',
    0,
    'Report defects promptly to prevent risk in the next operation.',
    'Laporkan kerosakan dengan segera untuk mengelakkan risiko dalam operasi seterusnya.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a9efde18-0a25-40b0-9710-961d423c14e4',
    0,
    'After a trip, you identify a minor defect before completing the handover documentation.',
    'Selepas tamat perjalanan, anda mengesan kerosakan kecil sebelum melengkapkan dokumentasi serahan kenderaan.',
    '["Record the defect accurately and submit the documentation", "Submit the documentation first and update the defect record later", "Delay recording the defect until the next scheduled inspection", "Note the defect informally and proceed with documentation"]',
    '["Rekodkan kerosakan dengan tepat dan serahkan dokumentasi", "Serahkan dokumentasi dahulu dan kemas kini rekod kerosakan kemudian", "Tangguhkan merekod kerosakan sehingga pemeriksaan seterusnya", "Catat kerosakan secara tidak rasmi dan teruskan dokumentasi"]',
    0,
    'Defects must be formally recorded to ensure proper documentation and accountability.',
    'kerosakan mesti direkod secara rasmi untuk memastikan dokumentasi dan akauntabiliti yang betul.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1ed66bfc-c35b-48de-824a-32d7bc5269ad',
    0,
    'While moving on a wet, uneven surface, you notice abnormal vibration and reduced vehicle response.',
    'Semasa bergerak di permukaan basah dan tidak rata, anda merasakan getaran tidak normal dan tindak balas kenderaan berkurang.',
    '["Maintain steady movement to avoid wheel slip", "Stop and assess before continuing", "Adjust speed slightly and continue through the area", "Complete the movement and report the issue later"]',
    '["Kekalkan pergerakan stabil untuk elakkan gelinciran tayar", "Berhenti dan periksa sebelum meneruskan", "Laraskan kelajuan sedikit dan teruskan melalui kawasan itu", "Selesaikan pergerakan dan laporkan masalah kemudian"]',
    1,
    'Pause to assess mechanical signals under challenging surface conditions.',
    'Berhenti dan periksa isu mekanikal dalam keadaan permukaan yang mencabar.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f4d5f9a2-437b-4007-91fa-73946e4a3abc',
    0,
    'While parked inside a site, an emergency alarm sounds and evacuation routes must be kept clear.',
    'Semasa parkir di dalam tapak, penggera kecemasan berbunyi dan laluan keluar mesti dikekalkan bebas halangan.',
    '["Remain in the cabin and wait for instructions", "Secure cabin items and clear the evacuation path immediately", "Leave the vehicle as it is and exit quickly", "Move the vehicle slightly to create more space"]',
    '["Kekal di dalam kabin dan tunggu arahan", "Pastikan barang dalam kabin tidak bergerak dan kosongkan laluan keluar segera", "Tinggalkan kenderaan seperti sedia ada dan keluar dengan cepat", "Gerakkan kenderaan sedikit untuk beri lebih ruang"]',
    1,
    'Secure loose items and clear evacuation routes immediately.',
    'Pastikan barang tidak bergerak dan kekalkan laluan keluar jelas dengan segera.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1671d87b-1244-4df0-95de-db477f430042',
    0,
    'During a delivery, a customer follows cultural practices unfamiliar to you.',
    'Semasa membuat penghantaran, seorang pelanggan mengikut amalan budaya yang tidak biasa bagi anda.',
    '["Acknowledge the practice and respond respectfully", "Continue the task without engaging further", "Question the practice to clarify expectations", "Follow your usual approach and proceed"]',
    '["Hormati amalan tersebut dan beri respons dengan sesuai", "Teruskan tugas tanpa melibatkan diri", "Persoalkan amalan itu untuk jelaskan jangkaan", "Ikut cara biasa anda dan teruskan"]',
    0,
    'Respecting cultural differences helps maintain positive and professional interactions.',
    'Menghormati perbezaan budaya membantu kekalkan interaksi yang profesional dan baik.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7421585e-431a-41f2-a454-e036084db5b6',
    0,
    'During unloading, site staff suggest recording different details on the delivery documents to save time.',
    'Semasa proses memunggah, kakitangan tapak mencadangkan supaya butiran pada dokumen penghantaran direkod berbeza untuk jimat masa.',
    '["Record the actual details accurately", "Adjust the details slightly so unloading can finish smoothly", "Note the change later to keep the paperwork acceptable", "Leave the documents for someone else to complete"]',
    '["Catat butiran yang sebenarnya dengan tepat", "Ubah sedikit butiran supaya proses memunggah selesai dengan lancar", "Catat perubahan kemudian supaya dokumen masih kelihatan boleh diterima", "Biarkan dokumen untuk disiapkan oleh orang lain"]',
    0,
    'Recording accurate details supports accountability and prevents issues later.',
    'Merekod butiran dengan tepat membantu pastikan tanggungjawab jelas dan elakkan masalah pada masa akan datang.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '18f5aa02-dcdd-4987-9126-56208c47772b',
    0,
    'During a delivery, a cultural misunderstanding causes tension between you and the customer.',
    'Semasa penghantaran, berlaku salah faham berkaitan budaya yang menyebabkan ketegangan antara anda dan pelanggan.',
    '["Acknowledge the concern respectfully and respond calmly", "Explain your intentions in detail to clear the misunderstanding", "Step back from the discussion to prevent further discomfort", "Defend your position to avoid being seen as disrespectful"]',
    '["Ambil maklum dengan hormat dan beri respons dengan tenang", "Terangkan niat anda dengan terperinci untuk jelaskan salah faham", "Undur diri daripada perbincangan untuk elak keadaan menjadi lebih tidak selesa", "Pertahankan pendirian supaya tidak dianggap tidak hormat"]',
    0,
    'Respectful acknowledgement and calm response help ease tension caused by misunderstandings.',
    'Pengakuan yang hormat dan respons yang tenang membantu redakan ketegangan akibat salah faham.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5fb28d42-f2bb-466e-9eda-e13d171ea3f9',
    0,
    'You are holding your lane in slow traffic when another driver begins tailgating and sounding the horn.',
    'Anda mengekalkan lorong dalam trafik perlahan apabila pemandu di belakang mula mengekori rapat dan membunyikan hon.',
    '["Maintain your lane position and avoid reacting to the behaviour", "Shift position slightly to signal cooperation and reduce tension", "Change lanes quickly to get away from the situation", "Gesture briefly to show you have noticed the other driver"]',
    '["Kekalkan kedudukan lorong dan elakkan memberi respons", "Ubah sedikit kedudukan untuk menunjukkan kerjasama dan mengurangkan ketegangan", "Tukar lorong dengan cepat untuk menjauhkan diri daripada situasi", "Buat isyarat ringkas untuk menunjukkan anda sedar akan kehadirannya"]',
    0,
    'Holding lane discipline and not reacting helps prevent aggressive situations from escalating.',
    'Mengekalkan disiplin lorong dan tidak bertindak balas membantu mengelakkan situasi agresif daripada menjadi lebih tegang.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fe9f3180-daeb-426a-88ef-d591a5ebff0a',
    0,
    'You spot debris ahead and slow early, while vehicles behind continue approaching at speed.',
    'Anda terlihat objek di atas jalan di hadapan lalu memperlahankan kenderaan lebih awal, sementara kenderaan di belakang masih menghampiri dengan laju.',
    '["Ease off smoothly and press brakes smoothly to warn others", "Maintain speed to avoid confusing traffic behind", "Brake later so following vehicles react together", "Slow suddenly once the debris is closer"]',
    '["Perlahankan kenderaan secara beransur supaya lampu brek memberi amaran kepada kenderaan belakang", "Kekalkan kelajuan supaya tidak mengelirukan trafik di belakang", "Brek kemudian supaya kenderaan belakang bertindak serentak", "Perlahankan kenderaan secara mengejut apabila objek semakin hampir"]',
    0,
    'Early slowing with clear signals helps other drivers adjust safely to hazards ahead.',
    'Memperlahankan kenderaan lebih awal membantu memberi amaran awal kepada pemandu lain dan membolehkan mereka menyesuaikan diri dengan selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.25, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a3848474-c519-4c4c-aa4e-dd170ef783ae',
    0,
    'You have been on duty for 10 hours and are asked to continue working.',
    'Anda telah bertugas selama 10 jam dan diminta untuk terus bekerja.',
    '["Continue if the remaining task is short.", "Stop working after reaching the 10-hour limit.", "Work another hour and rest later.", "Continue if traffic conditions are light."]',
    '["Teruskan jika baki tugasan adalah singkat.", "Hentikan kerja selepas mencapai had 10 jam.", "Bekerja satu jam lagi dan berehat kemudian.", "Teruskan jika keadaan trafik ringan."]',
    1,
    'Adhere to the maximum daily working hour limit.',
    'Patuhi had maksimum waktu kerja harian.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '67c028c7-c171-4f7b-92e7-ca6419696f2a',
    0,
    'While driving, you notice the sun shade and stickers on the windscreen reduce your side visibility.',
    'Semasa memandu, anda mendapati pelindung matahari dan pelekat pada cermin hadapan mengurangkan penglihatan sisi.',
    '["Continue driving carefully despite reduced visibility.", "Stop at a safe location and remove or adjust the obstruction.", "Reduce speed and rely more on mirrors.", "Adjust your lane position to compensate for the blind area."]',
    '["Terus memandu dengan berhati-hati walaupun penglihatan terhad.", "Berhenti di lokasi yang selamat dan tanggalkan/laraskan halangan tersebut.", "Kurangkan kelajuan dan lebih bergantung pada cermin sisi.", "Laraskan kedudukan lorong untuk mengimbangi kawasan yang terhalang."]',
    1,
    'Ensure full visibility before continuing to drive safely.',
    'Pastikan penglihatan jelas sepenuhnya sebelum meneruskan pemanduan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f11a67ea-53b7-4579-9b49-bc297515ec6b',
    0,
    'Your goods vehicle is experiencing failure on a highway and assistance has arrived.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan bantuan telah tiba.',
    '["Leave the vehicle where it stopped since help is present.", "Move the vehicle to a safer location when possible.", "Wait until traffic reduces before relocating.", "Relocate only if other drivers signal it is safe."]',
    '["Biarkan kenderaan di tempat ia berhenti kerana bantuan telah tiba.", "Alihkan kenderaan ke lokasi yang lebih selamat jika keadaan mengizinkan.", "Tunggu sehingga trafik berkurangan sebelum mengalihkan kenderaan.", "Alihkan hanya jika pemandu lain memberi isyarat selamat."]',
    1,
    'Relocate the vehicle to minimise continued traffic exposure.',
    'Alihkan kenderaan ke lokasi lebih selamat untuk mengurangkan pendedahan berterusan kepada trafik.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4e56bce3-464d-4abd-b1fe-2cc78d892a03',
    0,
    'You find that the first aid kit is incomplete.',
    'Anda mendapati kit pertolongan cemas tidak lengkap.',
    '["Continue if no emergency is expected.", "Replenish the first aid kit before operating.", "Rely on site facilities if needed.", "Inform later after completing the trip."]',
    '["Teruskan perjalanan jika tiada kecemasan dijangka berlaku.", "Lengkapkan kit pertolongan cemas sebelum mengendalikan kenderaan.", "Bergantung kepada kemudahan di lokasi jika perlu.", "Maklumkan kemudian selepas menamatkan perjalanan."]',
    1,
    'Maintain a complete and ready first aid kit at all times.',
    'Pastikan kit pertolongan cemas sentiasa lengkap dan sedia digunakan pada setiap masa.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '582b2213-0f70-4257-bcb7-47daa07e643d',
    0,
    'Before departure, you conduct a safety inspection.',
    'Sebelum memulakan perjalanan, anda menjalankan pemeriksaan keselamatan.',
    '["Focus only on tyres since they wear faster.", "Check brakes, tyres, steering, and vehicle lights.", "Inspect brakes only if carrying heavy cargo.", "Check lights after beginning the journey."]',
    '["Periksa tayar sahaja kerana ia lebih cepat haus.", "Periksa brek, tayar, stereng dan lampu kenderaan.", "Periksa brek hanya jika membawa muatan berat.", "Periksa lampu selepas memulakan perjalanan."]',
    1,
    'Inspect all critical control and lighting systems before driving.',
    'Periksa semua sistem kawalan dan lampu sebelum memandu.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3ff69ea9-5fe8-40ce-979c-f056483c0145',
    0,
    'Your driving document will expire in three weeks.',
    'Dokumen pemanduan anda akan tamat tempoh dalam tiga minggu.',
    '["Renew it two weeks before expiry.", "Renew it on your next off day.", "Renew it when you have free time.", "Renew it during the expiry week."]',
    '["Perbaharui dua minggu sebelum tamat tempoh.", "Perbaharui pada hari cuti anda yang seterusnya.", "Perbaharui apabila ada masa lapang.", "Perbaharui pada minggu tamat tempoh."]',
    0,
    'Renew required documents at least two weeks before expiry.',
    'Perbaharui dokumen yang diperlukan sekurang-kurangnya dua minggu sebelum tamat tempoh.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e9a54771-43f4-47a9-9e8f-f367bd58f2b5',
    0,
    'After completing your assignment, you are returning the vehicle.',
    'Selepas menamatkan tugasan, anda hendak memulangkan kenderaan.',
    '["Park the truck at any available space nearby.", "Park the truck at the company''s designated area.", "Leave the truck where it is most convenient.", "Park outside temporarily and inform later."]',
    '["Parkir lori di mana-mana ruang yang tersedia berhampiran.", "Parkir lori di kawasan yang ditetapkan oleh syarikat.", "Tinggalkan lori di tempat yang paling mudah.", "Parkir di luar buat sementara dan maklumkan kemudian."]',
    1,
    'Park company vehicles only at approved locations.',
    'Parkir kenderaan syarikat hanya di lokasi yang diluluskan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '98a1db3a-cc47-49d1-bcc3-12ee7b2283b5',
    0,
    'You review the container number, type, and size against the gate pass and delivery note.',
    'Anda menyemak nombor kontena, jenis dan saiz dengan membandingkannya kepada gate pass dan nota penghantaran.',
    '["Proceed if the container looks correct.", "Confirm all container details match the documents.", "Check only the container number.", "Deliver first and update discrepancies later."]',
    '["Teruskan jika kontena kelihatan betul.", "Pastikan semua butiran kontena sepadan dengan dokumen.", "Periksa nombor kontena sahaja.", "Hantar dahulu dan kemas kini perbezaan kemudian."]',
    1,
    'Ensure all container details match the official documents.',
    'Pastikan semua butiran kontena sepadan dengan dokumen rasmi sebelum berlepas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '50baed52-1b0a-48e5-b320-4033854f824c',
    0,
    'You collect a reefer container and observe a worn power cable.',
    'Anda mengambil kontena berpendingin dari premis pelanggan dan mendapati terdapat kerosakan pada bahagian luar.',
    '["Record it internally and inform operations.", "Secure the cable and continue.", "Inform operations after delivery.", "Proceed if cooling is active."]',
    '["Catat dalam rekod dalaman dan maklumkan bahagian operasi.", "Amankan kabel dan teruskan perjalanan.", "Maklumkan kepada bahagian operasi selepas penghantaran selesai.", "Teruskan perjalanan jika sistem penyejukan masih berfungsi."]',
    0,
    'Document and report equipment defects before departure.',
    'Rekodkan dan laporkan kerosakan kontena sebelum meneruskan pergerakan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ccf914e8-10dd-40ce-bbd9-49ed433924cc',
    0,
    'You arrive at the customer site to position the container.',
    'Anda tiba di tapak pelanggan untuk meletakkan kontena.',
    '["Position it at the nearest available space.", "Obtain customer approval before positioning.", "Follow previous delivery practice.", "Place it where it is easiest to exit."]',
    '["Letakkan di ruang terdekat yang tersedia.", "Dapatkan kelulusan pelanggan sebelum meletakkan kontena.", "Ikut amalan penghantaran sebelum ini.", "Letakkan di tempat yang paling mudah untuk keluar."]',
    1,
    'Obtain customer approval before positioning the container.',
    'Dapatkan kelulusan pelanggan sebelum meletakkan kontena.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3314a44d-5ca8-4bb0-a02c-766eb1e691ed',
    0,
    'A roadside altercation with a member of the public escalates and feels unsafe.',
    'Berlaku pertelingkahan di tepi jalan dengan orang awam dan keadaan menjadi tidak selamat.',
    '["Handle the matter personally.", "Go to the nearest police station and report.", "Ignore it and continue driving.", "Confront the individual to settle it."]',
    '["Uruskan sendiri situasi tersebut.", "Pergi ke balai polis terdekat dan buat laporan.", "Abaikan dan teruskan pemanduan.", "Bersemuka untuk menyelesaikan isu."]',
    1,
    'Seek police assistance when safety is threatened.',
    'Dapatkan bantuan polis apabila keselamatan terancam.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2258eeac-2d94-4542-ac38-07ef46b6aa10',
    0,
    'While stopped due to a fire on the trailer, flames are visible near the rear section.',
    'Semasa berhenti akibat kebakaran pada treler, api kelihatan di bahagian belakang.',
    '["Separate the prime mover from the trailer if safe.", "Keep the unit connected to maintain stability.", "Move the vehicle slightly before taking action.", "Wait to confirm the exact fire source."]',
    '["Pisahkan kepala lori daripada treler jika keadaan selamat.", "Kekalkan sambungan untuk mengekalkan kestabilan.", "Gerakkan kenderaan sedikit sebelum mengambil tindakan.", "Tunggu untuk mengesahkan punca kebakaran."]',
    0,
    'Separate units when safe to reduce fire spread.',
    'Pisahkan unit jika keadaan selamat untuk mengurangkan risiko api merebak.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e7bf8212-f33e-4be6-8c60-513e1e26f080',
    0,
    'After a collision, operations asks whether the vehicle can be moved.',
    'Selepas pelanggaran, bahagian operasi bertanya sama ada kenderaan boleh dialihkan.',
    '["Inform whether the vehicle can be moved or is blocking traffic.", "Move the vehicle without informing anyone.", "Leave it as it is and end the call.", "Decide later after completing documentation."]',
    '["Maklumkan sama ada kenderaan boleh dialihkan atau sedang menghalang trafik.", "Alihkan kenderaan tanpa memaklumkan kepada sesiapa.", "Biarkan sahaja dan tamatkan panggilan.", "Buat keputusan kemudian selepas melengkapkan dokumen."]',
    0,
    'Inform operations about vehicle condition and obstruction status.',
    'Maklumkan keadaan kenderaan dan sama ada ia menghalang trafik.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '06eb2412-038b-43fd-bff7-6aab2886d420',
    0,
    'While driving at the posted speed, you see motorcycles filtering between lanes and uneven braking ahead.',
    'Anda memandu pada kelajuan dibenarkan. Motosikal bergerak di antara lorong dan brek tidak sekata berlaku di hadapan.',
    '["Maintain speed and brake if traffic slows suddenly", "Reduce speed early and increase following distance", "Change lanes to avoid slower traffic ahead", "Maintain speed and focus on the vehicle ahead"]',
    '["Kekalkan kelajuan dan brek jika trafik perlahan secara tiba-tiba", "Kurangkan kelajuan lebih awal dan tambah jarak kenderaan", "Tukar lorong untuk mengelakkan trafik perlahan", "Kekalkan kelajuan dan fokus pada kenderaan di hadapan"]',
    1,
    'Reduce speed early to create time and space for sudden road changes.',
    'Kurangkan kelajuan lebih awal untuk memberi masa dan ruang apabila keadaan jalan berubah.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '990b7419-84ee-4315-a15e-b8f9ea3d67a7',
    0,
    'You merge from a slip road onto a busy highway. Vehicles ahead brake unevenly and motorcycles pass between lanes.',
    'Anda memasuki lebuh raya dari laluan masuk. Kenderaan di hadapan membrek tidak sekata dan motosikal bergerak di antara lorong.',
    '["Wait for a clearly safe gap before merging", "Merge and adjust speed once on the highway", "Use the gap quickly before traffic closes", "Move forward to signal intent and merge when traffic slows"]',
    '["Tunggu jarak/ruang yang benar-benar selamat sebelum masuk", "Masuk dahulu dan ubah kelajuan di lebuh raya", "Gunakan ruang dengan cepat sebelum trafik menjadi padat/sesak", "Bergerak ke hadapan untuk beri isyarat niat dan masuk apabila trafik perlahan"]',
    0,
    'Choose a safe gap to avoid sudden braking and conflict during merging.',
    'Pilih jarak yang selamat untuk mengelakkan brek mengejut dan konflik semasa masuk ke lebuh raya.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4ea911b7-9088-42db-8dd1-9d8562d1a02d',
    0,
    'You need to reverse into a marked bay inside a site. Space is tight, visibility is limited, and vehicles move nearby.',
    'Anda perlu mengundur ke petak bertanda di dalam tapak. Ruang sempit, pandangan terhad, dan kenderaan bergerak berhampiran.',
    '["Stop and reverse only when visibility and clearance are confirmed", "Reverse slowly while checking mirrors and adjusting position", "Continue reversing to avoid delaying vehicles behind", "Reverse carefully and rely on others to keep clear"]',
    '["Berhenti dan undur hanya apabila pandangan dan ruang selamat dipastikan", "Undur perlahan sambil periksa cermin dan sesuaikan kedudukan", "Terus undur untuk elakkan melambatkan kenderaan di belakang", "Undur dengan berhati-hati dan harap orang lain menjauh"]',
    0,
    'Confirm visibility and clearance before reversing in confined areas.',
    'Pastikan pandangan dan ruang selamat sebelum mengundur di kawasan sempit.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '969c9919-2105-4bcd-9823-dc41db9c83c4',
    0,
    'You approach a terminal gate where vehicles queue across multiple lanes.',
    'Anda menghampiri pintu masuk terminal. Kenderaan beratur di beberapa lorong.',
    '["Remain in the assigned lane and follow the gate process", "Shift to a faster lane when another vehicle is processed", "Move forward gradually as space opens ahead", "Follow the vehicle ahead through the gate"]',
    '["Kekal di lorong yang ditetapkan dan ikut proses di pintu masuk", "Tukar ke lorong lebih laju apabila kenderaan lain sedang diproses", "Bergerak ke hadapan secara beransur-ansur apabila ruang terbuka", "Ikut kenderaan di hadapan melalui pintu masuk"]',
    0,
    'Remain in your lane and follow gate instructions to keep entry orderly.',
    'Kekalkan lorong dan patuhi arahan pintu masuk untuk memastikan kemasukan teratur.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7e1deeca-063c-40fa-ac8b-3b34ab20661b',
    0,
    'Inside a site yard, a marshal instructs you to hold while vehicles reposition nearby.',
    'Di kawasan tapak, seorang marshal mengarahkan anda supaya berhenti sementara kenderaan berhampiran sedang mengubah kedudukan.',
    '["Hold position and continue checking mirrors and blind spots", "Signal and edge forward slightly to prepare to move", "Adjust position gradually while watching the marshal", "Follow nearby vehicles once they begin moving"]',
    '["Kekal berhenti dan terus periksa cermin serta titik buta", "Beri isyarat dan bergerak sedikit ke hadapan sebagai persediaan bergerak", "Sesuaikan kedudukan secara beransur sambil memerhati marshal", "Ikut pergerakan kenderaan berhampiran apabila ia mula bergerak"]',
    0,
    'Follow marshal instructions while maintaining situational awareness.',
    'Patuhi arahan marshal sambil kekalkan kesedaran persekitaran.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '818d3094-a9cc-4528-a060-b5896919a1fd',
    0,
    'You approach a terminal gate where entry requires credential verification. One credential is no longer valid.',
    'Anda menghampiri pintu masuk terminal yang memerlukan pengesahan pas akses. Satu akses tidak lagi sah.',
    '["Stop the entry process and report the issue", "Proceed with entry and resolve the issue inside", "Wait to see if the gate allows access", "Continue toward the gate since the trip is scheduled"]',
    '["Hentikan proses masuk dan laporkan masalah tersebut", "Teruskan masuk dan selesaikan isu di dalam terminal", "Tunggu untuk melihat sama ada pintu membenarkan masuk", "Terus menuju ke pintu masuk kerana perjalanan telah dijadualkan"]',
    0,
    'Valid credentials are required before terminal entry.',
    'Dokumen akses yang sah diperlukan sebelum memasuki terminal.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'cea2c56d-f66b-4c4a-b1e5-31ab1c94aa4f',
    0,
    'At a checkpoint, you are asked to present documents and notice the delivery time was recorded inaccurately.',
    'Di tempat pemeriksaan, anda diminta menunjukkan dokumen dan menyedari masa penghantaran direkod tidak tepat.',
    '["Present the document and clarify the timing if asked", "Hand over the document without mentioning the timing", "Explain verbally that the details are correct", "Ask for time to update the document before presenting it"]',
    '["Serahkan dokumen dan jelaskan masa jika ditanya", "Serahkan dokumen tanpa menyebut tentang masa", "Jelaskan secara lisan bahawa butiran adalah betul", "Minta masa untuk mengemas kini dokumen sebelum menyerahkannya"]',
    0,
    'Accurate documents and cooperation support smooth inspections.',
    'Dokumen yang tepat dan kerjasama membantu pemeriksaan berjalan lancar.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e5ff7929-6a70-4dec-a4ff-2489ac5ff4e3',
    0,
    'While driving, the engine feels strained during acceleration though no warning lights appear.',
    'Semasa memandu, enjin terasa kurang responsive semasa memecut walaupun tiada lampu amaran menyala.',
    '["Ease acceleration and monitor the condition", "Maintain normal acceleration since no lights show", "Increase engine output to test the response", "Continue driving and act only if it worsens"]',
    '["Kurangkan pecutan dan pantau keadaan", "Kekalkan pecutan kerana tiada lampu amaran", "Tingkatkan kuasa enjin untuk menguji tindak balas", "Terus memandu dan bertindak hanya jika keadaan bertambah teruk"]',
    0,
    'Respond early to unusual vehicle performance.',
    'Bertindak awal apabila prestasi kenderaan tidak biasa.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '659bc20e-a18f-4c01-8e4d-b58179c120ae',
    0,
    'During pre-trip inspection, you discover a brake defect before departure.',
    'Semasa pemeriksaan pra-perjalanan, anda menemui masalah pada brek sebelum berlepas.',
    '["Proceed carefully and monitor the defect during the journey", "Delay reporting until after completing the delivery", "Report the defect immediately and follow required procedures", "Ignore the defect to avoid operational delays"]',
    '["Teruskan dengan berhati-hati dan pantau masalah sepanjang perjalanan", "Tangguhkan laporan sehingga penghantaran selesai", "Laporkan masalah segera dan ikut prosedur yang ditetapkan", "Abaikan masalah untuk elakkan kelewatan operasi"]',
    2,
    'Defects must be reported before departure to ensure safety and integrity.',
    'Masalah mesti dilaporkan sebelum berlepas untuk memastikan keselamatan dan integriti.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '855edc8d-a5eb-48e7-adca-c77a272cdd85',
    0,
    'While waiting in an active loading zone, you notice cargo movement that may affect load stability.',
    'Semasa menunggu di zon pemuatan aktif, anda melihat pergerakan muatan yang boleh menjejaskan kestabilan muatan.',
    '["Remain in position and allow loading to continue", "Stop the process and alert site staff to address the cargo risk", "Move the vehicle slightly to reduce exposure", "Monitor the situation and proceed once loading appears stable"]',
    '["Kekal di tempat dan biarkan proses pemuatan diteruskan", "Hentikan proses dan maklumkan kakitangan tapak tentang risiko muatan", "Gerakkan kenderaan sedikit untuk mengurangkan pendedahan", "Pantau keadaan dan teruskan apabila pemuatan kelihatan stabil"]',
    1,
    'Address cargo instability promptly to prevent incidents in loading areas.',
    'Tangani ketidakstabilan muatan dengan segera untuk mengelakkan insiden di kawasan pemuatan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0b2e2cf5-a0c4-4d37-aad7-ee36262ed565',
    0,
    'A customer questions a delivery delay and speaks to you in a frustrated tone.',
    'Seorang pelanggan mempersoalkan kelewatan penghantaran dan bercakap dengan nada tidak puas hati.',
    '["Respond briefly and focus on completing the delivery", "Explain the situation calmly and confirm the next steps", "Defend your actions and point out factors beyond your control", "Avoid discussion and direct the customer to the office"]',
    '["Jawab secara ringkas dan fokus untuk selesaikan penghantaran", "Terangkan keadaan dengan tenang dan sahkan langkah seterusnya", "Pertahankan tindakan anda dan jelaskan faktor di luar kawalan", "Elakkan perbincangan dan arahkan pelanggan ke pejabat"]',
    1,
    'Calm, clear explanation helps reduce frustration and keeps the interaction professional.',
    'Penjelasan yang tenang dan jelas membantu kurangkan ketegangan dan kekalkan profesionalisme.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '496253bc-dcb5-48cb-903b-6445e8060e9d',
    0,
    'A colleague suggests you keep quiet about a major issue to avoid attention from management.',
    'Seorang rakan sekerja mencadangkan supaya anda berdiam diri tentang satu isu besar untuk elakkan perhatian pihak pengurusan.',
    '["Explain clearly why the issue should be reported", "Agree to stay quiet to keep things smooth", "Avoid responding and let the matter pass", "Say little and continue with your work"]',
    '["Jelaskan dengan terang mengapa isu itu perlu dilaporkan", "Setuju untuk berdiam diri supaya keadaan kekal tenang", "Elakkan memberi respons dan biarkan perkara itu berlalu", "Kurangkan bercakap dan teruskan kerja anda"]',
    0,
    'Clear communication and honesty help prevent larger problems later.',
    'Komunikasi yang jelas dan jujur membantu elakkan masalah menjadi lebih besar.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7a197f60-a996-49bb-8681-37f56189a6b2',
    0,
    'While parked in a public area, a bystander hints that a small payment could allow special access.',
    'Semasa parkir di kawasan awam, seorang individu menyatakan bahawa bayaran kecil boleh membolehkan akses khas.',
    '["Decline politely and continue following normal procedures", "Consider the request since it may avoid inconvenience to others", "Delay responding and see if the situation resolves itself", "Suggest discussing the matter later to keep things moving"]',
    '["Tolak dengan sopan dan ikut prosedur biasa", "Pertimbangkan permintaan itu kerana mungkin elakkan kesulitan", "Tangguhkan respons dan lihat perkembangan keadaan", "Cadangkan bincang perkara itu kemudian supaya urusan dapat diteruskan"]',
    0,
    'Refusing improper offers protects integrity and maintains public trust.',
    'Menolak tawaran yang tidak sesuai membantu kekalkan integriti dan kepercayaan orang awam.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'cf870b64-7673-4671-b8b5-9974e7c68b4c',
    0,
    'During a delivery, a culturally sensitive interaction is happening while people nearby are watching or recording.',
    'Semasa penghantaran, berlaku interaksi sensitif berkaitan budaya dan orang sekeliling sedang melihat dan merakam.',
    '["Maintain respectful behaviour and continue professionally", "Explain your actions carefully so others do not misinterpret them", "Limit the interaction to avoid drawing further attention", "Adjust your response to match how others expect you to behave"]',
    '["Kekalkan tingkah laku yang hormat dan teruskan secara profesional", "Terangkan tindakan anda dengan teliti supaya tidak disalah tafsir", "Hadkan interaksi untuk elak menarik lebih perhatian", "Ubah respons anda mengikut jangkaan orang sekeliling"]',
    0,
    'Maintaining respectful, professional behaviour protects your image during visible interactions.',
    'Sikap hormat dan profesional membantu melindungi imej anda apabila situasi diperhatikan orang lain.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9856c9d2-5ae4-4d48-a1e8-5f97c3aa2e60',
    0,
    'Traffic ahead is moving, but you keep extra distance. A customer messages asking why progress feels slow.',
    'Trafik di hadapan bergerak, namun anda mengekalkan jarak yang lebih selamat. Pelanggan menghantar mesej bertanya mengapa pergerakan agak lambat.',
    '["Maintain safe following distance and explain the situation calmly", "Close the gap slightly so movement appears faster", "Reassure the customer and focus on keeping pace", "Ignore the message and continue driving"]',
    '["Kekalkan jarak selamat dan jelaskan keadaan dengan tenang", "Rapatkan sedikit jarak supaya pergerakan nampak lebih cepat", "Yakinkan pelanggan dan cuba kekalkan kelajuan trafik", "Abaikan mesej dan teruskan pemanduan"]',
    0,
    'Keeping a safe following distance while explaining the reason supports safety and customer confidence.',
    'Mengekalkan jarak selamat sambil memberi penjelasan membantu menjaga keselamatan dan keyakinan pelanggan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'efea6e51-fd8d-4a8b-92e7-6ecab554e0b6',
    0,
    'You slow early after spotting a hazard ahead. The driver behind reacts angrily and closes in.',
    'Anda memperlahankan kenderaan lebih awal selepas melihat bahaya di hadapan. Pemandu di belakang bertindak marah dan merapat.',
    '["Keep your speed steady and avoid engaging", "Speed up slightly to reduce pressure from behind", "Brake again to show there is a hazard ahead", "Gesture briefly to discourage the tailgating"]',
    '["Kekalkan kelajuan yang stabil dan elakkan memberi respons", "Tambah sedikit kelajuan untuk mengurangkan tekanan dari belakang", "Tekan brek sekali lagi untuk menunjukkan terdapat bahaya di hadapan", "Buat isyarat ringkas untuk menghalang tingkah laku tersebut"]',
    0,
    'Maintaining steady driving and avoiding engagement helps manage hazards without escalating conflict.',
    'Mengekalkan pemanduan yang stabil dan tidak bertindak balas membantu mengurus risiko tanpa menambahkan ketegangan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ae8325b2-1566-4810-b82e-4fa69d42e48e',
    0,
    'You have worked six consecutive days and are scheduled for another duty.',
    'Anda telah bekerja selama enam hari berturut-turut dan dijadualkan untuk bertugas lagi.',
    '["Continue working if you feel fit.", "Take one rest day after six working days.", "Work half a day before taking leave.", "Swap shifts without taking a rest day."]',
    '["Terus bekerja jika anda berasa cergas.", "Ambil satu hari rehat selepas enam hari bekerja.", "Bekerja separuh hari sebelum mengambil cuti.", "Tukar syif tanpa mengambil hari rehat."]',
    1,
    'Take the required rest day after six consecutive working days.',
    'Ambil hari rehat yang ditetapkan selepas enam hari bekerja berturut-turut.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '406fe321-2b59-483b-a2cd-802b572ecf37',
    0,
    'Before starting your shift, you notice dark tint film and stickers on part of the windscreen.',
    'Sebelum memulakan syif, anda mendapati terdapat filem gelap dan pelekat pada sebahagian cermin hadapan.',
    '["Leave them since they were already installed.", "Remove or report them because they may obstruct visibility.", "Start driving and adjust your seating position instead.", "Ignore them as long as the road ahead is visible."]',
    '["Biarkan kerana ia telah dipasang sebelum ini.", "Tanggalkan atau laporkan kerana ia boleh menghalang penglihatan.", "Mulakan pemanduan dan laraskan kedudukan tempat duduk.", "Abaikan selagi jalan di hadapan masih kelihatan."]',
    1,
    'Address unauthorised modifications to protect visibility and vehicle safety.',
    'Tangani pengubahsuaian tanpa kelulusan untuk menjaga penglihatan dan keselamatan kenderaan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b14946e1-44d9-4963-91cf-65c77278cd9e',
    0,
    'A colleague asks to ride in your cabin as a second driver for convenience.',
    'Seorang rakan sekerja meminta untuk menaiki kabin anda sebagai pemandu kedua atas alasan kemudahan.',
    '["Allow the ride if the journey is short.", "Decline unless company authorisation is given.", "Allow the ride if the colleague is an employee.", "Permit the ride if no customers are affected."]',
    '["Benarkan jika perjalanan adalah singkat.", "Tolak kecuali terdapat kebenaran daripada syarikat.", "Benarkan jika rakan tersebut ialah pekerja syarikat.", "Benarkan jika tiada pelanggan yang terjejas."]',
    1,
    'Do not carry passengers without proper company authorisation.',
    'Jangan membawa penumpang tanpa kebenaran rasmi daripada syarikat.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7bad2828-6fbb-404f-86de-7cac2c648370',
    0,
    'You notice only three safety cones are available in the vehicle.',
    'Anda mendapati hanya tiga kon keselamatan tersedia di dalam kenderaan.',
    '["Proceed since cones are rarely used.", "Ensure five compliant safety cones are available.", "Carry additional cones only for highway trips.", "Proceed since 3 cones is enough."]',
    '["Teruskan perjalanan kerana kon jarang digunakan.", "Pastikan lima kon keselamatan yang mematuhi spesifikasi tersedia.", "Bawa kon tambahan hanya untuk perjalanan di lebuh raya.", "Teruskan kerana 3 kon sudah mencukupi."]',
    1,
    'Ensure the required number of compliant safety cones is carried.',
    'Pastikan bilangan kon keselamatan yang mematuhi spesifikasi dibawa seperti yang ditetapkan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '380e7b9d-7935-40d8-9a8d-9dc0baff350a',
    0,
    'You are verifying the vehicle before loading cargo.',
    'Anda sedang mengesahkan keadaan kenderaan sebelum memuatkan kargo.',
    '["Confirm the permitted load limit before loading.", "Load first and check weight later.", "Estimate weight based on experience.", "Accept the customer''s estimate without verification."]',
    '["Sahkan had muatan yang dibenarkan sebelum memuatkan kargo.", "Muatkan terlebih dahulu dan periksa berat kemudian.", "Anggarkan berat berdasarkan pengalaman.", "Terima anggaran pelanggan tanpa pengesahan."]',
    0,
    'Confirm the permitted load limit before carrying cargo.',
    'Sahkan had muatan yang dibenarkan sebelum membawa kargo.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5c25b478-d291-4dce-b36d-571715145921',
    0,
    'You are preparing for duty.',
    'Anda sedang membuat persediaan untuk bertugas.',
    '["Wear a collared shirt before reporting for duty.", "Wear any casual T-shirt as long as it is clean.", "Wear a sleeveless shirt in hot weather.", "Change only if instructed by a supervisor."]',
    '["Pakai baju berkolar sebelum melapor diri untuk bertugas.", "Pakai mana-mana baju T kasual asalkan bersih.", "Pakai baju tanpa lengan ketika cuaca panas.", "Tukar pakaian hanya jika diarahkan oleh penyelia."]',
    0,
    'Wear proper collared attire as required for duty.',
    'Pakai pakaian berkolar yang sesuai seperti yang ditetapkan semasa bertugas.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '150db9b7-aff3-4199-8424-b1a190cac7f1',
    0,
    'After completing your task, you still have the prime mover key.',
    'Selepas menamatkan tugasan, anda masih memegang kunci kepala lori.',
    '["Take the key home for the next shift.", "Return the key to the company as required.", "Leave the key inside the vehicle.", "Keep the key until requested."]',
    '["Bawa pulang kunci untuk syif seterusnya.", "Pulangkan kunci kepada syarikat seperti yang ditetapkan.", "Tinggalkan kunci di dalam kenderaan.", "Simpan kunci sehingga diminta."]',
    1,
    'Return vehicle keys to the company after duty.',
    'Pulangkan kunci kenderaan kepada syarikat selepas bertugas.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ae65904a-e84f-4603-ac4d-148161a4b74c',
    0,
    'After a road collision, what should you record first?',
    'Selepas berlaku pelanggaran jalan raya, apakah yang perlu anda catat terlebih dahulu?',
    '["The exact accident location.", "The damages.", "The estimated repair cost.", "The traffic condition."]',
    '["Lokasi kemalangan yang tepat.", "Kerosakan yang berlaku.", "Anggaran kos pembaikan.", "Keadaan trafik."]',
    0,
    'Record the accident location accurately.',
    'Catat lokasi kemalangan dengan tepat.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9a121c50-c00f-4f43-a049-f11d745bc477',
    0,
    'Your vehicle catches fire during transit.',
    'Kenderaan anda terbakar semasa dalam perjalanan.',
    '["Inform operations or the company safety team immediately.", "Attempt to control the fire fully before reporting.", "Inform the customer first.", "Report only if damage is severe."]',
    '["Maklumkan kepada bahagian operasi atau pasukan keselamatan syarikat dengan segera.", "Cuba kawal kebakaran sepenuhnya sebelum melaporkan.", "Maklumkan kepada pelanggan terlebih dahulu.", "Laporkan hanya jika kerosakan adalah serius."]',
    0,
    'Report fire incidents immediately for further instruction.',
    'Laporkan kejadian kebakaran dengan segera untuk arahan lanjut.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9a89eee9-e008-4c45-aa00-7d733cdf8c1d',
    0,
    'During initial reporting, what should you do if additional relevant details arise?',
    'Semasa laporan awal dibuat, apakah yang perlu anda lakukan jika terdapat maklumat tambahan yang berkaitan?',
    '["Share any information that supports the initial report.", "Limit information to basic facts only.", "Provide extra details only if requested later.", "Wait until writing a formal report."]',
    '["Kongsikan maklumat yang menyokong laporan awal.", "Hadkan maklumat kepada fakta asas sahaja.", "Berikan butiran tambahan hanya jika diminta kemudian.", "Tunggu sehingga menyediakan laporan rasmi."]',
    0,
    'Provide all relevant information for the initial response.',
    'Berikan semua maklumat yang berkaitan untuk tindakan awal yang tepat.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2b115aa9-a972-414d-bb31-73ec55bccca8',
    0,
    'You position your vehicle in a loading area where forklifts are operating.',
    'Anda meletakkan kenderaan di kawasan memuat/memunggah barang di mana forklift sedang beroperasi.',
    '["Move forward quickly and stop near loading", "Stop at a safe distance and proceed when clear", "Continue moving and rely on forklift guidance", "Park as close as possible despite limited space"]',
    '["Bergerak cepat ke hadapan dan berhenti berhampiran kawasan memuat/memunggah barang", "Berhenti pada jarak selamat dan bergerak apabila laluan sudah jelas", "Terus bergerak dan bergantung pada panduan forklift", "Parkir sedekat mungkin walaupun ruang terhad"]',
    1,
    'Keep a safe distance from active loading zones to reduce collision risk.',
    'Kekalkan jarak selamat dari kawasan kawasan pemuatan aktif untuk mengurangkan risiko pelanggaran.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '82ef6afa-ca6d-493f-b476-1c56a91a369a',
    0,
    'You approach a busy junction. Traffic slows and visibility is partly blocked by surrounding vehicles.',
    'Anda menghampiri persimpangan yang sibuk. Trafik perlahan dan sebahagian pandangan terhalang oleh kenderaan sekeliling.',
    '["Reduce speed early and prepare to stop", "Maintain speed and brake only if needed", "Slow slightly and move when the vehicle ahead moves", "Keep moving to clear the junction quickly"]',
    '["Kurangkan kelajuan lebih awal dan bersedia untuk berhenti", "Kekalkan kelajuan dan brek hanya jika perlu", "Perlahankan sedikit dan bergerak apabila kenderaan di hadapan bergerak", "Terus bergerak untuk melepasi persimpangan dengan cepat"]',
    0,
    'Reduce speed before junctions to respond safely to unexpected movement.',
    'Kurangkan kelajuan sebelum persimpangan untuk bertindak balas dengan selamat terhadap pergerakan mengejut.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3b0343b6-1ae2-4564-899f-de90772de789',
    0,
    'You are on foot near your vehicle in an active loading area. Forklifts operate and stacked goods restrict visibility.',
    'Anda berjalan berhampiran kenderaan di kawasan pemunggahan aktif. Forklift beroperasi dan susunan barangan menghadkan pandangan.',
    '["Keep clear of loading paths and wait until movement settles", "Move closer to observe equipment movement", "Walk through quickly to minimise time in the area", "Stand where operators can see you and keep moving"]',
    '["Kekal jauh dari laluan pemunggahan dan tunggu sehingga pergerakan reda", "Bergerak lebih dekat untuk memerhati pergerakan jentera", "Berjalan cepat untuk kurangkan masa di kawasan itu", "Berdiri di tempat pengendali boleh nampak dan terus bergerak"]',
    0,
    'Keep clear of loading activity to avoid sudden equipment movement and blind spots.',
    'Kekalkan jarak dari aktiviti pemunggahan untuk elakkan pergerakan jentera mengejut dan kawasan titik buta.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '26b9f64b-c096-4d9b-9542-102d858670b1',
    0,
    'You drive inside an industrial site where equipment operates near the roadway.',
    'Anda memandu di dalam kawasan industri di mana jentera beroperasi berhampiran laluan.',
    '["Reduce speed early and keep extra clearance from equipment", "Maintain pace and adjust if equipment enters your path", "Continue slowly to pass before equipment repositions", "Follow the vehicle ahead past the equipment"]',
    '["Kurangkan kelajuan lebih awal dan kekalkan jarak daripada jentera", "Kekalkan kelajuan dan sesuaikan jika jentera memasuki laluan anda", "Terus bergerak perlahan untuk melepasi sebelum jentera beralih", "Ikut kenderaan di hadapan melepasi jentera"]',
    0,
    'Reduce speed early and keep clear of operating equipment.',
    'Kurangkan kelajuan lebih awal dan kekalkan jarak dari jentera beroperasi.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fd755a35-e1f5-43a0-80df-ad74af0f5d24',
    0,
    'Inside a site yard, equipment operates near your path when another vehicle cuts across.',
    'Di kawasan tapak, jentera beroperasi berhampiran laluan anda dan tiba-tiba sebuah kenderaan melintas di hadapan.',
    '["Slow down, keep distance from equipment, and continue calmly", "Adjust position to regain progress while watching equipment", "Proceed steadily to clear the area quickly", "Follow the vehicle ahead closely to avoid delay"]',
    '["Perlahankan, kekalkan jarak dari jentera, dan teruskan dengan tenang", "Laraskan kedudukan untuk meneruskan pergerakan sambil memerhati jentera", "Terus bergerak untuk melepasi kawasan itu dengan cepat", "Ikut kenderaan di hadapan dengan rapat untuk elakkan kelewatan"]',
    0,
    'Maintain composure and distance near operating equipment.',
    'Kekalkan ketenangan dan jarak selamat berhampiran jentera beroperasi.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '94531231-d941-413b-bad3-4574d33763fd',
    0,
    'Before starting duty, you have not completed the required rest and are still under medication.',
    'Sebelum memulakan tugas, anda belum mendapat rehat yang cukup dan masih di bawah kesan ubat.',
    '["Delay starting duty and report the issue", "Start the trip carefully since the route is familiar", "Begin driving and stop later if you feel affected", "Proceed and take rest after your shift"]',
    '["Tangguhkan tugas dan laporkan keadaan tersebut", "Mulakan perjalanan dengan berhati-hati kerana laluan sudah biasa", "Mula memandu dan berhenti kemudian jika terasa terjejas", "Teruskan dan ambil rehat selepas tamat syif"]',
    0,
    'Confirm fitness for duty before driving.',
    'Pastikan kecergasan untuk bertugas sebelum memandu.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '26bf9578-1c44-472c-9862-80c541485909',
    0,
    'At a site entrance, valid driving credentials are required. One required credential has expired.',
    'Di pintu masuk tapak, kelayakan memandu yang sah diperlukan. Satu kelayakan telah tamat tempoh.',
    '["Stop the entry process and report the issue", "Complete the safety induction and resolve it later", "Proceed since rules will be explained during induction", "Wait to see if access is granted"]',
    '["Hentikan proses masuk dan laporkan masalah tersebut", "Selesaikan taklimat keselamatan dan uruskan kemudian", "Teruskan masuk kerana peraturan akan diterangkan semasa taklimat", "Tunggu untuk melihat sama ada akses dibenarkan"]',
    0,
    'Valid credentials are required before site entry.',
    'Kelayakan yang sah diperlukan sebelum memasuki tapak.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3efd16f3-665e-4825-9382-41402a10cdc2',
    0,
    'After loading at a site, procedure requires using a designated exit route.',
    'Selepas selesai memunggah keluar di tapak, prosedur memerlukan anda menggunakan laluan keluar yang ditetapkan.',
    '["Follow the designated exit route and site rules", "Take a shorter route since no traffic is visible", "Adjust your exit path to save time", "Exit based on familiarity rather than instructions"]',
    '["Ikut laluan keluar dan peraturan pergerakan tapak", "Ambil laluan lebih pendek kerana tiada trafik kelihatan", "Laraskan laluan keluar untuk menjimatkan masa", "Keluar berdasarkan kebiasaan dan bukan arahan"]',
    0,
    'Follow site exit routes and movement rules.',
    'Ikut laluan keluar dan peraturan pergerakan tapak.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '294a7843-28fe-4cdc-a4b7-a2b278e2192b',
    0,
    'While manoeuvring at low speed in a confined space, you notice resistance and a faint scraping sound.',
    'Semasa membuat manuver pada kelajuan rendah di ruang sempit, anda merasakan rintangan dan bunyi geseran ringan.',
    '["Stop and reassess clearance before continuing", "Proceed slowly and rely on steering to clear the space", "Apply more throttle to finish quickly", "Continue and inspect the vehicle after the manoeuvre"]',
    '["Berhenti dan semak semula ruang sebelum meneruskan", "Terus bergerak perlahan dan bergantung pada stereng", "Tekan minyak lebih untuk menyelesaikan manuver dengan cepat", "Teruskan dan periksa kenderaan selepas manuver selesai"]',
    0,
    'Stop when unusual resistance or sounds occur.',
    'Berhenti apabila terdapat rintangan atau bunyi tidak biasa.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '331bfedb-a441-4fac-a5d0-436e4fae92b7',
    0,
    'During a rest stop, you notice rubbish and food containers inside the truck cabin.',
    'Semasa berhenti rehat, anda melihat sampah dan bekas makanan di dalam kabin lori.',
    '["Leave the cabin unchanged since cleanliness does not affect vehicle operation", "Clean the cabin later when the schedule is less demanding", "Clean and tidy the cabin immediately", "Remove only items that may interfere with driving controls"]',
    '["Biarkan kabin seperti itu kerana kebersihan tidak menjejaskan operasi kenderaan", "Bersihkan kabin kemudian apabila jadual kurang sibuk", "Bersihkan dan kemaskan kabin segera", "Buang hanya barang yang boleh mengganggu kawalan pemanduan"]',
    2,
    'Maintaining cabin cleanliness supports safe operation and professional standards.',
    'Menjaga kebersihan kabin menyokong operasi selamat dan mencerminkan profesionalisme.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f752b9f9-fcc2-4942-87c0-cb58684e11a9',
    0,
    'While reversing slowly in a tight site area, you lose clear sight of one rear corner.',
    'Semasa mengundur perlahan di kawasan tapak yang sempit, anda hilang pandangan jelas pada satu sudut belakang.',
    '["Continue reversing slowly using mirrors", "Stop the vehicle and reassess the situation", "Turn the steering slightly and keep moving", "Rely on previous experience and continue"]',
    '["Terus mengundur perlahan menggunakan cermin", "Berhenti dan nilai semula keadaan", "Pusing stereng sedikit dan terus bergerak", "Bergantung pada pengalaman lalu dan teruskan"]',
    1,
    'Stop when visibility is uncertain to prevent damage and protect people and property.',
    'Berhenti apabila pandangan tidak jelas untuk mengelakkan kerosakan dan melindungi orang serta harta benda.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd99b26d9-6668-4984-ab67-02286d1988d3',
    0,
    'During unloading, site staff give instructions abruptly while you are positioning the vehicle.',
    'Semasa memunggah muatan, kakitangan tapak memberi arahan secara tiba-tiba ketika anda sedang memposisikan kenderaan.',
    '["Respond minimally and focus only on vehicle positioning", "Acknowledge the instructions and coordinate calmly", "Challenge the tone and clarify who is responsible", "Proceed without engaging further"]',
    '["Jawab secara minimum dan fokus pada posisi kenderaan sahaja", "Akui arahan tersebut dan bekerjasama dengan tenang", "Persoalkan nada arahan dan jelaskan siapa bertanggungjawab", "Teruskan tanpa melibatkan diri"]',
    1,
    'Calm coordination helps tasks run smoothly, even when instructions are delivered abruptly.',
    'Bekerjasama dengan tenang membantu kerja berjalan lancar walaupun arahan diberi secara tiba-tiba.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ed9a6fbd-15d0-41d5-a792-7d5d86acc11a',
    0,
    'A disagreement arises on site, and the discussion starts to become tense.',
    'Berlaku perbezaan pendapat di tapak dan perbincangan mula menjadi tegang.',
    '["Speak calmly, acknowledge concerns, and clarify next steps", "Restate your position firmly to end the discussion", "Reduce interaction and wait for the situation to pass", "Continue the task without engaging further"]',
    '["Bercakap dengan tenang dan jelaskan langkah seterusnya", "Tegaskan pendirian anda untuk tamatkan perbincangan", "Kurangkan interaksi dan tunggu keadaan reda", "Teruskan tugas tanpa melibatkan diri"]',
    0,
    'Calm acknowledgement and clear steps help prevent disagreements from escalating.',
    'Pendekatan yang tenang dan langkah yang jelas membantu elakkan keadaan menjadi lebih tegang.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9828717b-16e8-4322-b00a-83455eb6e295',
    0,
    'In a public area, a bystander becomes upset about where your vehicle is stopped.',
    'Di kawasan awam, seorang individu berasa tidak puas hati tentang lokasi kenderaan anda berhenti.',
    '["Respond calmly, acknowledge the concern, and explain briefly", "Explain in detail why the stop is necessary and allowed", "Avoid engagement and continue the task to prevent escalation", "Justify your position firmly so the complaint does not continue"]',
    '["Beri respons tenang, ambil maklum dan jelaskan secara ringkas", "Terangkan dengan terperinci mengapa berhenti di situ perlu dan dibenarkan", "Elakkan berinteraksi dan teruskan tugas", "Pertahankan posisi anda dengan tegas supaya aduan tidak berlanjutan"]',
    0,
    'Calm acknowledgement helps ease public tension and prevents situations from escalating.',
    'Respons yang tenang dan jelas membantu redakan ketegangan dan elakkan keadaan menjadi lebih serius.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b3b392d8-f4c8-4806-bc74-8ff39c19e4e0',
    0,
    'A customer calls you during the trip and urges you to arrive faster due to a delay.',
    'Seorang pelanggan menelefon semasa perjalanan dan mendesak anda tiba lebih cepat kerana berlaku kelewatan.',
    '["Maintain a safe speed and explain your expected arrival time", "Increase speed slightly to show effort and responsiveness", "Reassure the customer and focus on reaching sooner", "Shorten the conversation and continue driving as planned"]',
    '["Kekalkan kelajuan selamat dan maklumkan anggaran masa ketibaan", "Tambah sedikit kelajuan untuk tunjuk usaha dan responsif", "Yakinkan pelanggan dan cuba sampai lebih awal", "Pendekkan perbualan dan teruskan perjalanan seperti biasa"]',
    0,
    'Maintaining safe speed while giving a clear update supports both safety and customer trust.',
    'Kekalkan kelajuan selamat sambil beri maklumat jelas bagi menjaga keselamatan dan kepercayaan pelanggan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6e46ec20-aa1e-44c9-a2db-b745a4ed7d95',
    0,
    'Traffic ahead slows sharply. You increase following distance while vehicles behind close in without warning.',
    'Trafik di hadapan menjadi perlahan secara mendadak. Anda menambah jarak hadapan sementara kenderaan di belakang semakin menghampiri tanpa amaran.',
    '["Ease off early and activate brake lights to signal slowing", "Maintain speed to avoid confusing drivers behind", "Close the gap to match traffic flow", "Brake later so others are forced to react"]',
    '["Lepaskan pedal awal dan hidupkan lampu brek untuk memberi isyarat memperlahankan kenderaan", "Kekalkan kelajuan supaya tidak mengelirukan pemandu di belakang", "Rapatkan jarak untuk mengikut aliran trafik", "Tekan brek secara mengejut supaya pemandu lain terpaksa bertindak balas"]',
    0,
    'Creating space early and signalling clearly helps others adjust safely to changing traffic conditions.',
    'Mewujudkan ruang lebih awal dan memberi isyarat dengan jelas membantu pemandu lain menyesuaikan diri dengan selamat.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3d56f5f2-5585-44f0-8e83-698e483e1ac1',
    0,
    'At a junction, you prepare to turn while another vehicle approaches from the side and appears unsure of your intention.',
    'Di simpang jalan, anda bersedia untuk membelok apabila sebuah kenderaan dari sisi kelihatan tidak pasti tentang niat anda.',
    '["Signal early and complete the turn when it is safe", "Roll forward slightly to indicate you intend to go", "Wait longer to see how the other driver reacts", "Turn once there is space to avoid delaying traffic behind"]',
    '["Beri isyarat awal dan belok apabila selamat", "Gerak sedikit ke hadapan untuk menunjukkan niat", "Tunggu lebih lama untuk melihat reaksi pemandu lain", "Belok apabila ada ruang untuk mengelakkan kelewatan di belakang"]',
    0,
    'Clear signalling at junctions helps other drivers understand your intention and reduces uncertainty.',
    'Isyarat yang jelas di simpang membantu pemandu lain memahami niat anda dan mengurangkan ketidakpastian.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bf033c21-c55e-402a-8e16-06d207e753bd',
    0,
    'While driving, you notice the sun shade and stickers on the windscreen reduce your side visibility.',
    'Semasa memandu, anda mendapati pelindung matahari dan pelekat pada cermin hadapan mengurangkan penglihatan sisi.',
    '["Continue driving carefully despite reduced visibility.", "Stop at a safe location and remove or adjust the obstruction.", "Reduce speed and rely more on mirrors.", "Adjust your lane position to compensate for the blind area."]',
    '["Terus memandu dengan berhati-hati walaupun penglihatan berkurang.", "Berhenti di lokasi selamat dan tanggalkan/laraskan halangan tersebut.", "Kurangkan kelajuan dan lebih bergantung pada cermin sisi.", "Laraskan kedudukan lorong untuk mengimbangi kawasan yang terhalang."]',
    1,
    'Ensure full visibility before continuing to drive safely.',
    'Pastikan penglihatan jelas sepenuhnya sebelum meneruskan pemanduan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8be753e0-5881-4cac-970a-11e74964abea',
    0,
    'You arrive at a customer site to uncouple the trailer on uneven, soft ground.',
    'Anda tiba di tapak pelanggan untuk membuka sambungan treler di atas permukaan tanah yang tidak rata dan lembut.',
    '["Lower the landing legs carefully and check stability after uncoupling.", "Place strong wooden planks under the landing legs before uncoupling.", "Adjust the trailer position slightly to find firmer ground before uncoupling.", "Ask site staff to observe the trailer during the process."]',
    '["Turunkan kaki sokongan dengan berhati-hati dan periksa kestabilan selepas membuka sambungan.", "Letakkan papan kayu yang kukuh di bawah kaki sokongan sebelum membuka sambungan.", "Laraskan sedikit kedudukan treler untuk mencari tanah yang lebih kukuh sebelum membuka sambungan.", "Minta kakitangan tapak memerhati treler semasa proses tersebut."]',
    1,
    'Ensure stable ground support before uncoupling to prevent trailer instability.',
    'Pastikan sokongan tanah stabil sebelum membuka sambungan bagi mengelakkan treler menjadi tidak stabil.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ecc84c1b-4406-42ec-800d-86430737235c',
    0,
    'You are preparing to start your trip and will return later the same day.',
    'Anda sedang bersedia untuk memulakan perjalanan dan akan kembali pada hari yang sama.',
    '["Conduct inspection only before starting the trip.", "Conduct inspection only after completing the trip.", "Conduct inspections both before and after the trip.", "Conduct inspection only if a defect is suspected."]',
    '["Lakukan pemeriksaan sebelum memulakan perjalanan sahaja.", "Lakukan pemeriksaan selepas menamatkan perjalanan sahaja.", "Lakukan pemeriksaan sebelum dan selepas perjalanan.", "Lakukan pemeriksaan hanya jika terdapat tanda kerosakan."]',
    2,
    'Perform required inspections before and after every trip.',
    'Lakukan pemeriksaan yang ditetapkan sebelum dan selepas setiap perjalanan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3eac4031-2b81-44ea-b3a7-4b90e91cae3d',
    0,
    'The reflective string delineators are damaged and no longer reflective.',
    'Tali delineator reflektif rosak dan tidak lagi memantulkan cahaya.',
    '["Continue if cones are available.", "Replace them with compliant reflective delineators.", "Use hazard lights instead.", "Keep them until the next inspection cycle."]',
    '["Teruskan perjalanan jika kon keselamatan tersedia.", "Gantikan dengan delineator reflektif yang mematuhi spesifikasi.", "Gunakan lampu kecemasan sebagai ganti.", "Kekalkan penggunaannya sehingga pemeriksaan seterusnya."]',
    1,
    'Maintain compliant reflective equipment for roadside safety.',
    'Pastikan peralatan reflektif yang mematuhi spesifikasi sentiasa tersedia untuk keselamatan di tepi jalan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '803403b2-b87a-483e-8dcc-1ef71cd92d3c',
    0,
    'During inspection, you review emergency and fire equipment in the vehicle.',
    'Semasa pemeriksaan, anda menyemak peralatan kecemasan dan pemadam api di dalam kenderaan.',
    '["Check only for long-distance trips.", "Ensure emergency and fire equipment is complete and valid.", "Assume it is sufficient if previously used.", "Check after starting the trip."]',
    '["Periksa hanya untuk perjalanan jarak jauh.", "Pastikan peralatan kecemasan dan pemadam api lengkap dan masih sah untuk digunakan.", "Anggap mencukupi jika pernah digunakan sebelum ini.", "Periksa selepas memulakan perjalanan."]',
    1,
    'Ensure emergency and fire equipment is complete and valid before driving.',
    'Pastikan peralatan kecemasan dan pemadam api lengkap dan masih sah untuk digunakan sebelum memandu.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '22b0f45d-def7-4b0e-ab90-c397d8c8eef5',
    0,
    'You are dressing for your driving shift.',
    'Anda sedang berpakaian untuk syif pemanduan.',
    '["Wear long trousers as required.", "Wear shorts if the weather is hot.", "Wear track pants for comfort.", "Wear any trousers only when visiting customer sites."]',
    '["Pakai seluar panjang seperti yang ditetapkan.", "Pakai seluar pendek jika cuaca panas.", "Pakai seluar trek untuk keselesaan.", "Pakai apa-apa seluar hanya apabila melawat tapak pelanggan."]',
    0,
    'Wear long trousers as part of required duty attire.',
    'Pakai seluar panjang seperti yang ditetapkan semasa bertugas.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7c520d99-67dd-4a29-85da-d3f8492825a6',
    0,
    'As a driver, you must remain aware of the expiry and renewal dates of vehicle and operating documents.',
    'Sebagai seorang pemandu, anda perlu peka terhadap tarikh tamat tempoh dan pembaharuan dokumen kenderaan serta operasi.',
    '["Monitor the dates and arrange renewal before expiry.", "Wait for reminders from the office.", "Check the dates only during inspections.", "Rely on company personnel to identify expiry."]',
    '["Pantau tarikh tersebut dan uruskan pembaharuan sebelum tamat tempoh.", "Tunggu peringatan daripada pejabat.", "Semak tarikh hanya semasa pemeriksaan.", "Bergantung kepada pegawai syarikat untuk mengenal pasti tarikh tamat tempoh."]',
    0,
    'Be aware of expiry dates and renew documents before they lapse.',
    'Sentiasa peka terhadap tarikh tamat tempoh dan perbaharui dokumen sebelum tempoh sahnya berakhir.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0ef02301-0262-4557-adb8-3bfae5cac5da',
    0,
    'You are involved in a road collision.',
    'Anda terlibat dalam pelanggaran jalan raya.',
    '["Record the third party''s vehicle type and registration number.", "Record only the third party''s phone number.", "Take photos of the damage without recording vehicle details.", "Ask someone help to record the information for you."]',
    '["Catat jenis kenderaan dan nombor pendaftaran pihak ketiga.", "Catat nombor telefon pihak ketiga sahaja.", "Ambil gambar kerosakan tanpa merekod butiran kenderaan.", "Minta pertolongan orang lain mencatat maklumat bagi pihak anda."]',
    0,
    'Record vehicle type and registration details.',
    'Catat jenis kenderaan dan nombor pendaftaran dengan tepat.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2863910e-db1a-4925-b9dd-27a2ebb4593b',
    0,
    'A small fire starts near the engine compartment while parked.',
    'Semasa parkir, kebakaran kecil bermula berhampiran ruang enjin.',
    '["Use the ABC fire extinguisher if safe.", "Wait for others to assist before acting.", "Pour available water to reduce flames.", "Observe briefly before deciding."]',
    '["Gunakan alat pemadam api jenis ABC jika keadaan selamat.", "Tunggu bantuan sebelum mengambil tindakan.", "Tuang air yang ada untuk mengurangkan api.", "Perhatikan keadaan seketika sebelum membuat keputusan."]',
    0,
    'Use the appropriate extinguisher if the fire is manageable.',
    'Gunakan alat pemadam api yang sesuai jika kebakaran masih boleh dikawal dan keadaan selamat.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ab427947-a533-480f-b680-94903eb162ca',
    0,
    'You position your vehicle in a loading area where forklifts and pedestrians are moving.',
    'Anda meletakkan kenderaan di kawasan pemunggahan di mana forklift dan pejalan kaki sedang bergerak.',
    '["Move forward quickly before equipment approaches", "Position only when the area is clear of movement", "Continue moving slowly and watch for operator signals", "Stop close to the loading area to reduce walking"]',
    '["Bergerak cepat ke hadapan sebelum peralatan menghampiri", "Letakkan kenderaan hanya apabila kawasan itu tiada pergerakan", "Terus bergerak perlahan sambil perhatikan isyarat pengendali", "Berhenti dekat kawasan pemunggahan untuk kurangkan berjalan"]',
    1,
    'Keep clear of active loading zones to reduce collision and injury risk.',
    'Kekalkan jarak dari kawasan pemunggahan aktif untuk mengurangkan risiko pelanggaran dan kecederaan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '37c15c30-a454-4c85-9114-8e11fc9f2f02',
    0,
    'You approach a busy junction. Traffic slows unevenly and vehicles from the side edge forward.',
    'Anda menghampiri persimpangan sibuk. Trafik perlahan secara tidak sekata dan kenderaan dari sisi bergerak ke hadapan.',
    '["Hold your lane and approach at reduced speed", "Shift slightly within your lane to improve visibility", "Edge closer to discourage other vehicles", "Maintain speed and react only if a vehicle enters"]',
    '["Kekalkan lorong dan hampiri pada kelajuan rendah", "Bergerak sedikit dalam lorong untuk tingkatkan pandangan", "Bergerak lebih dekat untuk menghalang kenderaan lain", "Kekalkan kelajuan dan bertindak hanya jika kenderaan masuk"]',
    0,
    'Clear lane position and early speed control reduce conflict at junctions.',
    'Kedudukan lorong yang jelas dan kawalan kelajuan awal mengurangkan konflik di persimpangan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '33231fbe-b44b-47b6-92f7-e23de5a209f8',
    0,
    'You approach a checkpoint inside a facility. Vehicles queue unevenly and lanes split toward inspection points.',
    'Anda menghampiri pusat pemeriksaan di dalam fasiliti. Kenderaan beratur tidak sekata dan lorong berpecah ke beberapa laluan pemeriksaan.',
    '["Remain in your lane and wait for checkpoint direction", "Shift early to a less congested lane", "Move forward and adjust position near the checkpoint", "Follow the vehicle ahead if its lane clears faster"]',
    '["Kekalkan lorong dan tunggu arahan pusat pemeriksaan", "Tukar awal ke lorong yang kurang sesak", "Bergerak ke hadapan dan sesuaikan kedudukan berhampiran pusat pemeriksaan", "Ikut kenderaan di hadapan jika lorongnya bergerak lebih cepat"]',
    0,
    'Remain orderly and wait for checkpoint direction in controlled zones.',
    'Kekalkan pergerakan teratur dan tunggu arahan pusat pemeriksaan di kawasan kawalan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7423d207-cc3d-4180-b930-5c2aea13413a',
    0,
    'You need to reverse into a tight space in a site yard. Vehicles and equipment move nearby.',
    'Anda perlu mengundur ke ruang sempit di kawasan tapak. Kenderaan dan jentera bergerak berhampiran.',
    '["Stop and reverse only when space and visibility are clear", "Reverse slowly and adjust speed as conditions change", "Complete the manoeuvre to minimise disruption", "Follow nearby vehicles to guide your reversing speed"]',
    '["Berhenti dan undur hanya apabila ruang dan pandangan jelas", "Undur perlahan dan sesuaikan kelajuan mengikut keadaan", "Selesaikan manuver untuk kurangkan gangguan kepada orang lain", "Ikut pergerakan kenderaan berhampiran untuk panduan kelajuan mengundur"]',
    0,
    'Confirm space and visibility before reversing in busy yards.',
    'Pastikan ruang dan pandangan jelas sebelum mengundur di kawasan tapak sibuk.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3c8643d5-e8fa-410f-adf1-277a2672d9cb',
    0,
    'You approach a narrow access point inside a facility. Visibility is limited and vehicles may enter from the opposite direction.',
    'Anda menghampiri laluan masuk sempit di dalam fasiliti. Pandangan terhad dan kenderaan mungkin masuk dari arah bertentangan.',
    '["Slow early and wait until the access path is clear", "Continue forward cautiously and adjust if a vehicle appears", "Enter the access point to hold position", "Follow the vehicle ahead through the access"]',
    '["Perlahankan kenderaan lebih awal dan tunggu sehingga laluan benar-benar jelas", "Terus bergerak dengan berhati-hati dan sesuaikan jika kenderaan muncul", "Masuk ke laluan untuk menunggu", "Ikut kenderaan di hadapan melalui laluan"]',
    0,
    'Slow early and confirm the path is clear before entering.',
    'Perlahankan kenderaan lebih awal dan pastikan laluan jelas sebelum masuk.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1664212d-624e-4cfc-bd67-51ee0183c2be',
    0,
    'While driving, your phone receives a message and you are slightly above the speed limit.',
    'Semasa memandu, telefon anda menerima mesej dan anda memandu sedikit melebihi had laju.',
    '["Slow to the legal speed and ignore the message", "Maintain speed and quickly check the message", "Reduce speed slightly and read when traffic allows", "Keep speed steady and reply briefly"]',
    '["Kurangkan kelajuan ke had yang dibenarkan dan abaikan mesej tersebut", "Kekalkan kelajuan dan periksa mesej dengan cepat", "Kurangkan sedikit kelajuan dan baca apabila keadaan sesuai", "Kekalkan kelajuan dan balas mesej secara ringkas"]',
    0,
    'Follow speed limits and avoid device use while driving.',
    'Patuhi had laju dan elakkan penggunaan telefon semasa memandu.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f416618b-7fd1-46c3-80a8-8e3778289180',
    0,
    'At a controlled checkpoint, valid credentials are required and one credential has expired.',
    'Di pusat pemeriksaan kawalan, kelayakan yang sah diperlukan dan satu kelayakan telah tamat tempoh.',
    '["Stop at the checkpoint and report the issue", "Proceed slowly and resolve it afterward", "Wait to see if access is granted without it", "Continue forward since monitoring appears light"]',
    '["Berhenti di pusat pemeriksaan dan laporkan masalah tersebut", "Terus bergerak perlahan dan selesaikan kemudian", "Tunggu untuk melihat sama ada akses dibenarkan tanpa kelayakan", "Terus bergerak kerana pemantauan kelihatan kurang ketat"]',
    0,
    'Stop and meet credential requirements before proceeding.',
    'Berhenti dan pastikan kelayakan dipenuhi sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4ff48723-7d48-4154-bffc-879c6da27319',
    0,
    'At a site with active loading operations, you step out of your vehicle in the loading area without a safety helmet.',
    'Di tapak dengan operasi pemuatan aktif, anda keluar dari kenderaan di kawasan pemuatan tanpa topi keselamatan.',
    '["Put on the required PPE and keep clear of loading", "Remain where you are and rely on operators", "Move quickly through the area to reduce time", "Wait for instructions before addressing PPE"]',
    '["Pakai PPE yang diperlukan dan kekal jauh dari operasi pemuatan", "Kekal di tempat dan bergantung pada pengendali", "Bergerak cepat melalui kawasan itu untuk kurangkan masa", "Tunggu arahan dan kemudian pakai PPE"]',
    0,
    'Wear required PPE and keep clear of loading zones.',
    'Pakai PPE yang diperlukan dan kekalkan jarak dari kawasan pemuatan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '75e6eea2-1909-47ee-8c47-2479b0278583',
    0,
    'While manoeuvring at low speed with a load, you feel the load shift and notice the vehicle is closer than expected to an obstacle.',
    'Semasa membuat manuver pada kelajuan rendah dengan muatan, anda merasakan muatan bergerak dan menyedari kenderaan lebih dekat daripada jangkaan kepada halangan.',
    '["Stop and assess if it is safe to proceed", "Proceed slowly and adjust steering to maintain clearance", "Complete the manoeuvre and check the load afterward", "Continue moving and secure the load once clear"]',
    '["Berhenti dan pastikan selamat sebelum meneruskan", "Terus bergerak perlahan dan laraskan stereng untuk kekalkan jarak", "Selesaikan manuver dan periksa muatan selepas itu", "Terus bergerak dan periksa di tempat perhentian"]',
    0,
    'Stop and reassess when load shift or clearance risk appears.',
    'Berhenti dan nilai semula apabila muatan bergerak atau jarak menjadi sempit.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '604d7150-31d1-4772-8f23-fde68b7f2d58',
    0,
    'While parked at a public roadside stop, your engine is running near pedestrians and nearby premises.',
    'Semasa parkir di tepi jalan awam, enjin kenderaan masih hidup berhampiran pejalan kaki dan premis berdekatan.',
    '["Keep the engine running to maintain cabin comfort", "Shut down the engine while parked", "Keep the engine running and remain inside the vehicle", "Leave the engine running briefly before moving off"]',
    '["Biarkan enjin hidup untuk keselesaan kabin", "Matikan enjin semasa parkir", "Biarkan enjin hidup dan kekal di dalam kenderaan", "Biarkan enjin hidup seketika sebelum bergerak"]',
    1,
    'Shutting down the engine when parked protects company assets and shows respect for the public.',
    'Mematikan enjin semasa parkir melindungi aset syarikat dan menunjukkan hormat kepada orang awam.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b90fd2b0-d647-4246-bb30-ae73f2ce67fa',
    0,
    'Inside a site, you approach a junction where parked equipment limits turning space.',
    'Di dalam tapak, anda menghampiri simpang dan jentera parkir mengehadkan ruang membelok.',
    '["Continue forward and adjust steering during the turn", "Stop early and reposition for a wider, safer turn", "Follow the shortest path to clear the junction", "Move closer before deciding how to turn"]',
    '["Teruskan ke hadapan dan laras stereng semasa membelok", "Berhenti awal dan ubah posisi untuk belokan yang lebih luas dan selamat", "Ikut laluan paling pendek untuk lepasi simpang", "Bergerak lebih dekat sebelum tentukan cara membelok"]',
    1,
    'Early positioning inside sites prevents tight turns, damage, and unnecessary corrections.',
    'Posisi awal yang betul di dalam tapak membantu elakkan belokan sempit, kerosakan dan pembetulan yang tidak perlu.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '91cb58f5-7223-46f8-af6c-2e7f8833045c',
    0,
    'While making a delivery, members of the public are nearby and watching your interaction with the customer.',
    'Semasa membuat penghantaran, orang awam berada berdekatan dan memerhati interaksi anda dengan pelanggan.',
    '["Focus only on the customer and ignore the surroundings", "Maintain calm, respectful behaviour mindful of the public presence", "Keep the exchange short to avoid attention", "Let the customer lead the interaction tone"]',
    '["Fokus pada pelanggan sahaja dan abaikan keadaan sekeliling", "Kekalkan tingkah laku tenang dan hormat dengan mengambil kira kehadiran orang awam", "Pendekkan perbualan untuk elak perhatian", "Biarkan pelanggan tentukan nada interaksi"]',
    1,
    'Professional behaviour matters not only to the customer, but also to the public observing the interaction.',
    'Tingkah laku profesional penting bukan sahaja kepada pelanggan tetapi juga kepada orang awam yang memerhati.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0de6e9f3-23ab-4304-a4c7-115dcd4fa2ea',
    0,
    'During a site discussion, you realise the conversation may be overheard or recorded.',
    'Semasa perbincangan di tapak, anda sedar perbualan mungkin didengar atau dirakam.',
    '["Speak carefully and keep the discussion professional", "Lower your voice and limit further discussion", "End the conversation and return to work", "Continue speaking as you normally would"]',
    '["Bercakap dengan berhati-hati dan kekalkan profesionalisme", "Rendahkan suara dan hadkan perbincangan", "Tamatkan perbualan dan kembali bekerja", "Terus bercakap seperti biasa"]',
    0,
    'Choosing words carefully helps protect your professional image in visible situations.',
    'Pilih kata dengan cermat untuk lindungi imej profesional di tempat umum.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fd265194-a891-4e9c-bc59-d7ad60d120e4',
    0,
    'In a public area, people nearby are watching and filming while you interact with others.',
    'Di kawasan awam, orang di sekeliling memerhati dan merakam semasa anda berinteraksi dengan orang lain.',
    '["Keep your behaviour calm and professional throughout", "Explain your actions clearly so observers understand your position", "Limit interaction and focus on finishing the task", "Respond firmly to avoid appearing uncertain"]',
    '["Kekalkan tingkah laku tenang dan profesional sepanjang masa", "Terangkan tindakan anda supaya orang yang memerhati faham", "Hadkan interaksi dan fokus selesaikan tugas", "Beri respons dengan tegas supaya tidak kelihatan ragu-ragu"]',
    0,
    'Professional behaviour matters most when actions are visible to the public.',
    'Tingkah laku profesional amat penting apabila tindakan anda dapat dilihat oleh orang awam.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'afdb646c-c773-4c56-91a6-e65b714b4869',
    0,
    'Traffic slows unexpectedly, and a supervisor asks if you can make up time on the road.',
    'Trafik tiba-tiba menjadi perlahan dan penyelia bertanya sama ada anda boleh mengejar semula masa di jalan raya.',
    '["Keep to a safe speed and give a clear, realistic update", "Say you will try to make up time where possible", "Reassure them and focus on pushing ahead", "Keep the call short and continue driving"]',
    '["Kekalkan kelajuan selamat dan beri maklumat yang jelas serta realistik", "Beritahu bahawa anda akan cuba mengejar masa jika boleh", "Yakinkan penyelia dan fokus untuk bergerak lebih laju", "Pendekkan panggilan dan teruskan perjalanan"]',
    0,
    'Clear updates and safe driving help manage expectations without increasing risk.',
    'Maklumat yang jelas dan pemanduan selamat membantu urus jangkaan tanpa menambah risiko.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '698571d1-36a5-4199-b3f7-62192a10d216',
    0,
    'You increase following distance in slow traffic. The driver behind closes in and flashes headlights repeatedly.',
    'Anda menambah jarak kenderaan dalam trafik perlahan. Pemandu di belakang merapat dan berulang kali memberi lampu tinggi.',
    '["Keep your distance and continue without responding", "Ease closer to avoid further confrontation behind you", "Acknowledge the other driver briefly so they know you noticed", "Adjust your driving to discourage the behaviour"]',
    '["Kekalkan jarak dan teruskan tanpa memberi respons", "Rapatkan sedikit jarak untuk mengelakkan ketegangan di belakang", "Beri isyarat ringkas supaya pemandu lain tahu anda sedar", "Sesuaikan cara pemanduan untuk menghalang tingkah laku tersebut"]',
    0,
    'Maintaining safe distance and not reacting helps prevent tension from escalating in traffic.',
    'Mengekalkan jarak selamat dan tidak bertindak balas membantu mengelakkan ketegangan di jalan raya.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8db1f053-ede4-4e3c-89fe-ed8fdd363972',
    0,
    'You enter a narrow roadworks zone with barriers while members of the public are standing nearby.',
    'Anda memasuki kawasan pembaikan jalan yang sempit dengan penghadang, sementara orang awam berada berhampiran.',
    '["Reduce speed early and proceed cautiously", "Maintain speed to clear the zone quickly", "Follow the vehicle ahead closely to avoid delay", "Focus on steering accuracy and ignore people nearby"]',
    '["Kurangkan kelajuan lebih awal dan lalui kawasan dengan berhati-hati", "Kekalkan kelajuan untuk melepasi kawasan dengan cepat", "Ikut rapat kenderaan di hadapan supaya tidak lewat", "Fokus pada kawalan stereng dan abaikan orang di sekitar"]',
    0,
    'Reducing speed early in high-risk areas helps protect the public and reduces potential harm.',
    'Mengurangkan kelajuan lebih awal di kawasan berisiko membantu melindungi orang awam dan mengurangkan potensi bahaya.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0d9cc892-89c6-4c72-a31c-937ae98c85a6',
    0,
    'Before starting your shift, you notice dark tint film and stickers on part of the windscreen.',
    'Sebelum memulakan syif, anda mendapati terdapat filem gelap dan pelekat pada sebahagian cermin hadapan.',
    '["Leave them since they were already installed.", "Remove or report them because they may obstruct visibility.", "Start driving and adjust your seating position instead.", "Ignore them as long as the road ahead is visible."]',
    '["Biarkan kerana ia telah dipasang sebelum ini.", "Tanggalkan atau laporkan kerana ia boleh menghalang penglihatan.", "Mulakan pemanduan dan laraskan kedudukan tempat duduk.", "Abaikan selagi jalan di hadapan masih kelihatan."]',
    1,
    'Address unauthorised modifications to protect visibility and vehicle safety.',
    'Tangani pengubahsuaian tanpa kelulusan untuk menjaga penglihatan dan keselamatan kenderaan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '85fb6e22-e27a-42d3-acb3-6a9333e6c4ec',
    0,
    'Your goods vehicle is experiencing failure on a highway and there is no nearby exit.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan tiada susur keluar berhampiran.',
    '["Stop in the current lane and switch on hazard lights.", "Move the vehicle to the far left shoulder before stopping.", "Stop immediately and place warning devices behind the vehicle.", "Slow down and remain in the lane until assistance arrives."]',
    '["Berhenti di lorong semasa dan hidupkan lampu kecemasan.", "Gerakkan kenderaan ke bahu kiri paling luar sebelum berhenti.", "Berhenti serta-merta dan letakkan alat amaran di belakang kenderaan.", "Perlahankan kenderaan dan kekal di lorong sehingga bantuan tiba."]',
    1,
    'Move to a safer shoulder area to reduce exposure to traffic.',
    'Gerakkan kenderaan ke bahu jalan yang lebih selamat untuk mengurangkan risiko terdedah kepada trafik.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9e098321-9cc0-457e-905b-dc66b6cf13da',
    0,
    'You are loading cargo and the total weight is close to the vehicle''s permitted limit.',
    'Anda sedang memuatkan kargo dan jumlah beratnya hampir mencapai had yang dibenarkan untuk kenderaan.',
    '["Load slightly above the limit if the distance is short.", "Ensure the load remains within the permitted weight limit.", "Proceed since the excess weight is minimal.", "Accept the customer''s weight figure without verification."]',
    '["Muatkan sedikit melebihi had jika jarak adalah dekat.", "Pastikan muatan kekal dalam had berat yang dibenarkan.", "Teruskan perjalanan kerana lebihan berat adalah kecil.", "Terima angka berat pelanggan tanpa pengesahan."]',
    1,
    'Always operate within the approved weight limit.',
    'Sentiasa pastikan kenderaan beroperasi dalam had berat yang diluluskan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0149ee54-aa36-4f03-8c8f-1122669c2474',
    0,
    'You notice there is no compliant safety vest in the vehicle.',
    'Anda mendapati tiada vest keselamatan yang mematuhi spesifikasi di dalam kenderaan.',
    '["Proceed if you remain inside the vehicle.", "Ensure a compliant safety vest is available before departure.", "Wear any bright-coloured clothing instead.", "Borrow one only when entering a site."]',
    '["Teruskan perjalanan jika anda kekal berada di dalam kenderaan.", "Pastikan vest keselamatan yang mematuhi spesifikasi tersedia sebelum memulakan perjalanan.", "Pakai sebarang pakaian berwarna terang sebagai ganti.", "Pinjam vest hanya apabila memasuki tapak."]',
    1,
    'Carry the required safety vest before operating.',
    'Pastikan vest keselamatan yang diperlukan dibawa sebelum beroperasi.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '73fadec6-162a-4d9d-b4ae-0d8b9dc97be4',
    0,
    'You arrive at a site and the nearest space is marked as a prohibited parking area.',
    'Anda tiba di tapak dan ruang terdekat ditanda sebagai kawasan larangan parkir.',
    '["Park there briefly if unloading is quick.", "Find a permitted parking space.", "Park there if other vehicles are doing the same.", "Stop there with hazard lights switched on."]',
    '["Parkir seketika jika proses menurunkan muatan adalah cepat.", "Cari ruang parkir yang dibenarkan.", "Parkir di situ jika kenderaan lain melakukan perkara yang sama.", "Berhenti di situ dengan lampu kecemasan dihidupkan."]',
    1,
    'Do not park in prohibited areas.',
    'Parkir hanya di kawasan yang dibenarkan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '88df287c-5f71-4583-a682-7bb1d7960b52',
    0,
    'Before starting duty, you are choosing your footwear.',
    'Sebelum memulakan tugas, anda memilih kasut untuk dipakai.',
    '["Wear covered shoes for duty.", "Wear slippers for short-distance trips.", "Wear sandals if driving locally.", "Change into shoes only when entering a site."]',
    '["Pakai kasut bertutup semasa bertugas.", "Pakai selipar untuk perjalanan jarak dekat.", "Pakai sandal jika memandu di kawasan setempat.", "Tukar kepada kasut hanya apabila memasuki tapak."]',
    0,
    'Wear proper shoes while on duty.',
    'Pakai kasut yang sesuai semasa bertugas.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '486642ff-dfcb-405c-8d8b-6ca6af9715d2',
    0,
    'You have completed a delivery at a customer site.',
    'Anda telah menyelesaikan penghantaran di tapak pelanggan.',
    '["Obtain the receiver''s signature only.", "Obtain signature, company stamp, time received, and receiver''s name.", "Take a photo of the unloaded goods as proof.", "Record the delivery details after returning to the office."]',
    '["Dapatkan tandatangan penerima sahaja.", "Dapatkan tandatangan, cap syarikat, masa terima dan nama penerima.", "Ambil gambar barang yang telah diturunkan sebagai bukti.", "Rekodkan butiran penghantaran selepas kembali ke pejabat."]',
    1,
    'Ensure full and proper customer confirmation for every delivery.',
    'Pastikan pengesahan penerimaan lengkap bagi setiap penghantaran.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e559de0e-ed37-420b-860f-d5d282bc43d7',
    0,
    'After a collision, you are gathering information from the other driver.',
    'Selepas pelanggaran, anda mengumpul maklumat daripada pemandu lain.',
    '["Take the driver''s contact number and identification details.", "Record only the vehicle number.", "Ask them to contact your office directly.", "Leave once traffic clears."]',
    '["Ambil nombor telefon dan butiran pengenalan pemandu tersebut.", "Catat nombor pendaftaran kenderaan sahaja.", "Minta mereka hubungi pejabat anda secara terus.", "Beredar apabila trafik kembali lancar."]',
    0,
    'Obtain necessary contact and identification details.',
    'Dapatkan nombor telefon dan butiran pengenalan yang diperlukan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd46ce21c-0dd0-4e27-876f-a4ad2abda887',
    0,
    'A fire on your vehicle becomes large and difficult to control.',
    'Kebakaran pada kenderaan anda menjadi besar dan sukar dikawal.',
    '["Contact the fire brigade immediately.", "Continue using the extinguisher repeatedly.", "Wait for operations to arrive first.", "Move the vehicle slightly before deciding."]',
    '["Hubungi pasukan bomba dengan segera.", "Terus gunakan alat pemadam api berulang kali.", "Tunggu bahagian operasi tiba dahulu.", "Gerakkan kendaraan sedikit sebelum membuat keputusan."]',
    0,
    'Contact fire brigade when the fire escalates.',
    'Hubungi bomba apabila kebakaran menjadi besar dan tidak terkawal.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd78deafa-1d6a-40c1-8fdd-ed48d5d794d5',
    0,
    'You approach a site entrance from a public road. The access lane is narrow and partially obstructed.',
    'Anda menghampiri pintu masuk tapak dari jalan awam. Laluan masuk sempit dan sebahagiannya terhalang.',
    '["Maintain speed to avoid blocking traffic behind", "Slow early and proceed when the path is clear", "Move closer to assess space before stopping", "Enter the access lane and adjust position inside"]',
    '["Kekalkan kelajuan untuk elakkan menghalang trafik di belakang", "Perlahankan awal dan masuk apabila laluan jelas", "Bergerak lebih dekat untuk menilai ruang sebelum berhenti", "Masuk ke laluan dan laraskan kedudukan di dalam"]',
    1,
    'Slow early and confirm the path is clear before entering a constrained access point.',
    'Perlahankan kenderaan lebih awal dan pastikan laluan jelas sebelum memasuki laluan sempit.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd3ff9a5d-57b0-4f0a-b830-83200da07b64',
    0,
    'You drive at night in heavy rain on a downhill road. Visibility is reduced and vehicles ahead slow unpredictably.',
    'Anda memandu pada waktu malam dalam hujan lebat di jalan menurun. Pandangan terhad dan kenderaan di hadapan memperlahankan secara tidak menentu.',
    '["Reduce speed early for higher risk conditions", "Maintain speed and rely on headlights and braking", "Slow slightly and adjust if visibility worsens", "Keep pace with the vehicle ahead"]',
    '["Kurangkan kelajuan lebih awal kerana keadaan berisiko tinggi", "Kekalkan kelajuan dan bergantung pada lampu serta brek", "Perlahankan sedikit dan sesuaikan kelajuan jika pandangan semakin terhad", "Ikut kelajuan kenderaan di hadapan"]',
    0,
    'Reduce speed in poor visibility to maintain control.',
    'Kurangkan kelajuan apabila pandangan terhad untuk kekalkan kawalan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0ba9959e-603b-4fce-afa5-43fa6383cc6a',
    0,
    'You arrive at a customer site. Access lanes are narrow and forklifts operate near the loading area.',
    'Anda tiba di tapak pelanggan. Laluan masuk sempit dan forklift beroperasi berhampiran kawasan pemuatan.',
    '["Hold back until access is clearly available", "Move forward slowly to secure a position near loading", "Approach while keeping visible to site staff", "Continue advancing to avoid delaying loading"]',
    '["Tunggu di luar sehingga laluan benar-benar jelas", "Bergerak perlahan untuk mendapatkan kedudukan berhampiran kawasan pemuatan", "Hampiri kawasan tersebut dengan memastikan anda kelihatan oleh pekerja tapak", "Terus bergerak untuk elakkan kelewatan proses pemuatan."]',
    0,
    'Keep distance from constrained access and active loading areas.',
    'Kekalkan jarak dari laluan sempit dan kawasan loading aktif.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '14c2794a-8ba5-4381-bc02-eed281892938',
    0,
    'You drive inside a facility. Vehicles queue ahead and forklifts operate near the roadway.',
    'Anda memandu di dalam kawasan fasiliti. Kenderaan beratur di hadapan dan forklift beroperasi berhampiran laluan.',
    '["Increase following distance and keep clear sight", "Maintain spacing and close the gap if traffic slows", "Reduce the gap to avoid blocking vehicles behind", "Match the distance used by surrounding vehicles"]',
    '["Tambah jarak kenderaan dan kekalkan pandangan jelas", "Kekalkan jarak dan rapatkan jika trafik perlahan", "Rapatkan jarak untuk elakkan menghalang kenderaan di belakang", "Ikut jarak yang digunakan oleh kenderaan sekeliling"]',
    0,
    'Maintain extra spacing and clear sight near operating equipment.',
    'Kekalkan jarak tambahan dan pandangan jelas berhampiran jentera beroperasi.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3e26d762-ec94-4c10-a80d-adc5bd774c51',
    0,
    'You approach a busy site exit joining a public road. Space is tight and reversing may be needed to realign.',
    'Anda menghampiri pintu keluar tapak yang bersambung dengan jalan awam. Ruang sempit dan mungkin perlu mengundur untuk melaras kedudukan.',
    '["Edge forward to secure position and adjust if needed", "Stop, assess, and reverse slowly under control", "Use the horn and continue moving", "Reverse quickly before vehicles arrive"]',
    '["Bergerak sedikit ke hadapan untuk mendapatkan kedudukan", "Berhenti, nilai keadaan, dan undur perlahan dengan kawalan", "Gunakan hon dan terus bergerak", "Undur dengan cepat sebelum kenderaan tiba"]',
    1,
    'Stop and maintain full control before reversing near junctions.',
    'Berhenti dan kekalkan kawalan penuh sebelum mengundur berhampiran persimpangan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '333204f2-b76f-4ed7-8275-dd3e9452299b',
    0,
    'After a delivery, you find a required document was not completed according to company procedure.',
    'Selepas selesai penghantaran, anda mendapati dokumen yang diperlukan tidak dilengkapkan mengikut prosedur syarikat.',
    '["Complete and correct the document before closing the job", "Leave it since the delivery is already done", "Make a brief note and update it later if needed", "Proceed to the next task and rely on existing records"]',
    '["Lengkapkan dan betulkan dokumen sebelum menyelesaikan tugasan", "Biarkan sahaja kerana penghantaran sudah selesai", "Buat catatan ringkas dan kemas kini kemudian jika perlu", "Teruskan ke tugasan seterusnya dan bergantung pada rekod sedia ada"]',
    0,
    'Complete documents correctly to maintain procedural compliance.',
    'Lengkapkan dokumen dengan betul memastikan pematuhan terhadap prosedur.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'dece17a3-7866-4f02-9b9e-70710edb50a2',
    0,
    'Feeling unusually tired due to insufficient rest, you are about to enter a site with narrow internal lanes.',
    'Anda berasa amat letih kerana kurang rehat dan akan memasuki tapak dengan laluan dalaman sempit.',
    '["Delay site entry to take a short rest", "Enter carefully and rely on slow speed", "Proceed since the site is familiar", "Enter and take breaks after the manoeuvre"]',
    '["Tangguhkan kemasukan ke tapak untuk berehat seketika", "Masuk dengan berhati-hati dan bergantung pada kelajuan rendah", "Teruskan kerana tapak tersebut sudah biasa", "Masuk dan berehat selepas selesai manuver"]',
    0,
    'Address fatigue before entering confined areas.',
    'Atasi keletihan sebelum memasuki kawasan sempit.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '883cd540-93c9-4dec-941e-f2a97baa390e',
    0,
    'While waiting inside a site, an emergency alarm sounds and vehicles are directed to clear the area. Your engine is running.',
    'Semasa menunggu di dalam tapak, penggera kecemasan berbunyi dan kenderaan diarahkan mengosongkan kawasan. Enjin anda masih hidup.',
    '["Follow evacuation instructions and stop the engine when safe", "Keep the engine running and leave quickly", "Wait for clarification before acting", "Continue idling until site personnel approach"]',
    '["Ikut arahan pemindahan dan matikan enjin apabila selamat", "Kekalkan enjin hidup dan keluar dengan cepat", "Tunggu penjelasan lanjut sebelum bertindak", "Terus hidupkan enjin sehingga kakitangan tapak datang"]',
    0,
    'Follow evacuation instructions and manage the vehicle safely.',
    'Ikut arahan pemindahan dan kendalikan kenderaan dengan selamat.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4647d8ee-d4f2-474e-8fd7-59ed0d68e193',
    0,
    'You arrive at a customer premise and are told unloading will take longer than expected. The vehicle is parked safely.',
    'Anda tiba di tempat pelanggan dan dimaklumkan proses memunggah keluar akan mengambil masa lebih lama daripada jangkaan. Kenderaan telah diparkir dengan selamat.',
    '["Switch off the engine while waiting", "Keep the engine running to be ready to move", "Rev the engine occasionally", "Leave the engine idling and monitor the situation"]',
    '["Matikan enjin semasa menunggu", "Biarkan enjin hidup untuk bersedia bergerak", "Tekan minyak sekali-sekala", "Biarkan enjin melahu sambil memantau keadaan"]',
    0,
    'Switch off the engine during long waiting periods.',
    'Matikan enjin semasa menunggu lama untuk mengelakkan pembaziran bahan api.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd0222a4c-9026-47d2-a3eb-99d6da4edfaa',
    0,
    'While driving, you notice unusual vibration and a new mechanical noise from the vehicle.',
    'Semasa memandu, anda merasakan getaran tidak normal dan bunyi mekanikal baharu daripada kenderaan.',
    '["Continue driving and observe if the noise disappears", "Stop safely and report the issue clearly to the supervisor", "Reduce speed and complete the trip as planned", "Mention the issue during the next scheduled check"]',
    '["Teruskan memandu dan lihat sama ada bunyi itu hilang", "Berhenti di tempat selamat dan laporkan masalah kepada penyelia", "Kurangkan kelajuan dan teruskan perjalanan seperti dirancang", "Nyatakan masalah semasa pemeriksaan seterusnya"]',
    1,
    'Early detection and clear reporting help prevent minor issues from becoming safety risks.',
    'Pengesanan awal dan laporan yang jelas membantu mengelakkan masalah kecil menjadi risiko keselamatan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '107eae68-3c45-4a17-8dad-ea785bf96aac',
    0,
    'At a site checkpoint, you notice a vehicle defect just before being cleared to proceed.',
    'Di checkpoint tapak, anda perasan ada kerosakan pada kenderaan sejurus sebelum dibenarkan bergerak.',
    '["Proceed through the checkpoint and report the defect afterwards", "Stop at the checkpoint and report the defect immediately", "Move past the checkpoint and assess the defect inside", "Request guidance while remaining in the queue"]',
    '["Terus melepasi checkpoint dan laporkan kerosakan kemudian", "Berhenti di checkpoint dan laporkan kerosakan segera", "Lepasi checkpoint dan periksa kerosakan di dalam", "Minta panduan sambil kekal dalam barisan"]',
    1,
    'Reporting defects at checkpoints prevents unsafe entry into controlled zones.',
    'Laporkan kerosakan sebelum bergerak untuk elakkan risiko semasa masuk atau keluar kawasan terkawal.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9decd45f-c527-40c1-8f62-a7dffe228442',
    0,
    'A staff member at the delivery premise hints that a small personal favour could speed up your delivery process.',
    'Seorang pekerja di tempat pelanggan mencadangkan bahawa bantuan peribadi kecil boleh mempercepatkan proses penghantaran.',
    '["Decline politely and follow standard procedures", "Accept the request to maintain good customer relations", "Delay the decision and see how the situation develops", "Refer the matter to another driver on site"]',
    '["Tolak dengan sopan dan ikut prosedur biasa", "Terima permintaan itu untuk jaga hubungan pelanggan", "Tangguhkan keputusan dan lihat perkembangan keadaan", "Rujuk perkara itu kepada pemandu lain di tapak"]',
    0,
    'Following standard procedures protects fairness and avoids improper influence.',
    'Mengikut prosedur biasa membantu kekalkan keadilan dan elakkan pengaruh yang tidak wajar.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3efb3824-8f3a-46da-929a-c367bbc3a896',
    0,
    'After a delivery, you notice the recorded details do not fully match what occurred.',
    'Selepas penghantaran, anda mendapati butiran yang direkod tidak sepenuhnya sepadan dengan apa yang berlaku.',
    '["Clarify the discrepancy and update the records accurately", "Leave the records unchanged to avoid reopening the discussion", "Add brief notes later so the paperwork roughly reflects events", "Ask someone else to adjust the documents if needed"]',
    '["Jelaskan perbezaan dan kemas kini rekod dengan tepat", "Biarkan rekod seperti itu untuk elakkan perbincangan dibuka semula", "Tambah catatan ringkas kemudian supaya dokumen lebih kurang mencerminkan keadaan sebenar", "Minta orang lain mengubah dokumen jika perlu"]',
    0,
    'Correct records promptly to ensure accuracy and prevent misunderstandings.',
    'Betulkan rekod dengan segera untuk memastikan ketepatan dan mengelakkan salah faham.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6bdcc6b7-8350-4634-9a6b-1422edb15eca',
    0,
    'After unloading in a public street, a nearby shop owner asks you to record a shorter stop time to avoid complaints.',
    'Selepas memunggah muatan di tepi jalan awam, seorang pemilik kedai meminta anda merekod masa berhenti yang lebih singkat untuk elakkan aduan.',
    '["Record the actual stop time and submit the document as required", "Shorten the recorded time since unloading is already completed", "Leave the timing unclear so it does not attract attention", "Explain the situation verbally and minimise what is written"]',
    '["Catat masa berhenti sebenar dan serahkan dokumen seperti dikehendaki", "Pendekkan masa yang direkod kerana proses memunggah sudah selesai", "Biarkan catatan masa tidak jelas supaya tidak menarik perhatian", "Jelaskan secara lisan dan kurangkan maklumat bertulis"]',
    0,
    'Accurate records uphold accountability, even when there is public pressure.',
    'Catatan yang tepat membantu kekalkan tanggungjawab walaupun ada tekanan dari luar.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'af604d04-40ba-426c-8a28-df94d8248630',
    0,
    'You are driving through a residential area where pedestrians are present and traffic is light.',
    'Anda memandu melalui kawasan perumahan dengan kehadiran pejalan kaki dan trafik yang ringan.',
    '["Maintain an appropriate speed and remain mindful of people nearby", "Drive slightly faster to clear the area quickly", "Match the flow of traffic and continue as usual", "Focus on the road ahead and avoid reacting to bystanders"]',
    '["Kekalkan kelajuan yang sesuai dan peka terhadap orang di sekeliling", "Pandu sedikit lebih laju untuk keluar dari kawasan itu dengan cepat", "Ikut aliran trafik dan teruskan seperti biasa", "Fokus ke hadapan dan abaikan pergerakan orang di tepi jalan"]',
    0,
    'Reducing speed in residential areas shows consideration for pedestrian safety.',
    'Mengurangkan kelajuan di kawasan perumahan menunjukkan keprihatinan terhadap keselamatan pejalan kaki.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a272b6a2-6209-434c-b2e5-98fe41af203b',
    0,
    'You intend to change lanes, but another driver in your blind spot appears unsure of your intention.',
    'Anda bercadang untuk menukar lorong, namun pemandu di titik buta kelihatan tidak pasti tentang niat anda.',
    '["Signal early and wait until the other driver responds before moving", "Drift slightly to indicate intention and move when space appears", "Check mirrors again and change lanes once traffic slows", "Hold position and change lanes later without signalling"]',
    '["Beri isyarat awal dan tunggu sehingga diberi ruang", "Hanyut sedikit ke sisi untuk menunjukkan niat dan masuk apabila ada ruang", "Periksa cermin sekali lagi dan tukar lorong apabila trafik menjadi perlahan", "Kekalkan kedudukan dan tukar lorong kemudian tanpa memberi isyarat"]',
    0,
    'Clear signalling helps other drivers understand your intention and reduces uncertainty during lane changes.',
    'Isyarat yang jelas membantu pemandu lain memahami niat anda dan mengurangkan ketidakpastian semasa menukar lorong.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9ad651aa-f44f-4e71-a922-e3b4f7da3ff8',
    0,
    'Another driver cuts in suddenly, forcing you to brake, then begins gesturing angrily at you.',
    'Seorang pemandu memotong masuk secara tiba-tiba sehingga anda terpaksa membrek, kemudian menunjukkan isyarat marah kepada anda.',
    '["Regain composure and continue driving without reacting", "Respond briefly to show you were affected by the move", "Accelerate to move away from the situation", "Slow further to signal your frustration"]',
    '["Tenangkan diri dan teruskan pemanduan tanpa memberi respons", "Beri respons ringkas untuk menunjukkan anda terkesan", "Tambah kelajuan untuk menjauhkan diri daripada situasi", "Perlahankan lagi kenderaan sebagai tanda tidak puas hati"]',
    0,
    'Maintaining composure and not reacting helps prevent aggressive situations from escalating.',
    'Mengekalkan ketenangan dan tidak bertindak balas membantu mengelakkan situasi agresif daripada menjadi lebih tegang.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e99c8f38-e95a-4979-9028-64dc5ac1a80e',
    0,
    'You plan to install a sun shade, dark tint film, or stickers on the company truck windscreen.',
    'Anda bercadang memasang pelindung matahari, filem gelap, atau pelekat pada cermin hadapan lori syarikat.',
    '["Install them if they do not block the main driving view.", "Do not install them without company approval.", "Use removable shades only during daytime driving.", "Check whether other drivers have done similar modifications."]',
    '["Pasang jika tidak menghalang pandangan utama ketika memandu.", "Jangan pasang tanpa kelulusan syarikat.", "Gunakan pelindung yang boleh ditanggalkan pada waktu siang sahaja.", "Periksa sama ada pemandu lain pernah membuat pengubahsuaian yang sama."]',
    1,
    'Avoid unauthorised vehicle modifications that may affect safety or compliance.',
    'Elakkan pengubahsuaian pada kenderaan tanpa kelulusan yang boleh menjejaskan keselamatan atau pematuhan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '351aa12f-d5c7-4beb-939f-5fb477de0dc5',
    0,
    'Your goods vehicle is experiencing failure on a highway and you have stopped on the left shoulder.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda telah berhenti di bahu jalan sebelah kiri.',
    '["Remain inside and assess the situation first.", "Switch on the hazard lights immediately.", "Call your supervisor before taking further action.", "Step out briefly to check approaching traffic."]',
    '["Kekal di dalam kenderaan dan nilai keadaan terlebih dahulu.", "Hidupkan lampu kecemasan dengan segera.", "Hubungi penyelia sebelum mengambil tindakan lanjut.", "Keluar sebentar untuk memeriksa trafik yang menghampiri."]',
    1,
    'Activate hazard lights promptly to alert approaching traffic.',
    'Hidupkan lampu kecemasan segera untuk memberi amaran kepada pengguna jalan lain.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fbdf909a-978a-4812-94c0-7e75a3e856e2',
    0,
    'Your vehicle is due for scheduled maintenance according to the company/manufacturer''s manual.',
    'Kenderaan anda telah tiba masa menjalani penyelenggaraan berjadual mengikut manual syarikat atau pengeluar.',
    '["Continue operating since the vehicle is running smoothly.", "Follow the scheduled maintenance requirement.", "Postpone the service until the next trip cycle.", "Wait for further confirmation before arranging service."]',
    '["Terus beroperasi kerana kenderaan masih berfungsi dengan baik.", "Patuhi keperluan penyelenggaraan berjadual.", "Tangguhkan servis sehingga kitaran perjalanan seterusnya.", "Tunggu pengesahan lanjut sebelum mengaturkan servis."]',
    1,
    'Follow the company/manufacturer''s maintenance schedule as required.',
    'Patuhi jadual penyelenggaraan yang ditetapkan oleh syarikat atau pengeluar.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'de6bc1e8-b65d-4377-a396-e1b8e05c8a68',
    0,
    'You are involved in a minor incident during vehicle operation.',
    'Anda terlibat dalam satu insiden kecil semasa mengendalikan kenderaan.',
    '["Report the incident within 2 hours as required.", "Report it at the end of the workday.", "Report only if damage is visible.", "Wait until instructed before reporting."]',
    '["Laporkan insiden dalam tempoh 2 jam seperti yang ditetapkan.", "Laporkan pada akhir hari kerja.", "Laporkan hanya jika terdapat kerosakan yang dapat dilihat.", "Tunggu arahan sebelum membuat laporan."]',
    0,
    'Report accidents or incidents within the required reporting timeframe.',
    'Laporkan kemalangan atau insiden dalam tempoh masa pelaporan yang ditetapkan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a452af91-eb8f-4990-8bc0-b89fd7af8780',
    0,
    'You are about to start driving the vehicle.',
    'Anda hendak memulakan pemanduan kenderaan.',
    '["Fasten the seat belt before moving.", "Drive first and fasten it later.", "Wear it only on highways.", "Use it only when carrying heavy cargo."]',
    '["Pakai tali pinggang keledar sebelum bergerak.", "Mula memandu dan pakai kemudian.", "Pakai hanya di lebuh raya.", "Pakai hanya apabila membawa muatan berat."]',
    0,
    'Always wear the seat belt before driving.',
    'Pakai tali pinggang keledar sebelum memandu.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5e221099-aa82-46fd-96ff-61cc2a6827f9',
    0,
    'You are reporting for duty after several weeks without a haircut.',
    'Anda melapor diri untuk bertugas selepas beberapa minggu tanpa memotong rambut.',
    '["Maintain short and neat hair as required.", "Keep long hair if tied properly.", "Trim only when reminded by HR.", "Maintain appearance only for inspections."]',
    '["Pastikan rambut sentiasa pendek dan kemas seperti yang ditetapkan.", "Simpan rambut panjang asalkan diikat dengan kemas.", "Potong rambut hanya apabila diingatkan oleh pihak sumber manusia (HR).", "Jaga penampilan hanya semasa pemeriksaan dijalankan."]',
    0,
    'Maintain neat and appropriate grooming for duty.',
    'Kekalkan penampilan yang kemas dan sesuai semasa bertugas.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '479114cb-f3e2-4bff-9f81-af3aef1e2cfa',
    0,
    'You arrive at a delivery location and notice the address differs from the delivery note.',
    'Anda tiba di lokasi penghantaran dan mendapati alamat berbeza daripada yang tertera pada nota penghantaran.',
    '["Deliver to the new address if the customer confirms verbally.", "Contact operations for confirmation before proceeding.", "Deliver if the location is nearby.", "Leave the goods with the person present at the site."]',
    '["Hantar ke alamat baharu jika pelanggan mengesahkan secara lisan.", "Hubungi bahagian operasi untuk pengesahan sebelum meneruskan penghantaran.", "Hantar jika lokasi berhampiran.", "Tinggalkan barang kepada individu yang berada di tapak."]',
    1,
    'Verify address changes with operations before delivery.',
    'Sahkan sebarang perubahan alamat dengan bahagian operasi sebelum membuat penghantaran.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7c55da76-9ceb-4057-a968-0c70c9a40dda',
    0,
    'Following a collision, what photographic evidence should you collect?',
    'Selepas pelanggaran, bukti gambar apakah yang perlu anda ambil?',
    '["Photos of the scene and vehicles involved.", "Only your own vehicle damage.", "A photo after vehicles are moved.", "No photos if witnesses are present."]',
    '["Gambar lokasi kejadian dan kenderaan yang terlibat.", "Gambar kerosakan kenderaan anda sahaja.", "Gambar selepas kenderaan dialihkan.", "Tidak perlu ambil gambar jika ada saksi."]',
    0,
    'Take clear photos of the accident scene and vehicles.',
    'Ambil gambar yang jelas bagi lokasi kejadian dan kenderaan yang terlibat.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7353bb8c-0dbc-4244-a559-7e5c973d09f6',
    0,
    'After a road accident, the Emergency Response Team contacts you.',
    'Selepas kemalangan jalan raya, Pasukan Tindak Balas Kecemasan menghubungi anda.',
    '["Provide clear details of what happened, time, location, and vehicles involved.", "Inform them only that an accident occurred.", "Ask them to obtain details from witnesses.", "Provide information after returning to depot."]',
    '["Berikan maklumat jelas tentang apa yang berlaku, masa, lokasi dan kenderaan yang terlibat.", "Maklumkan bahawa kemalangan telah berlaku sahaja.", "Minta mereka mendapatkan maklumat daripada saksi.", "Berikan maklumat selepas kembali ke depot."]',
    0,
    'Provide clear and accurate accident details immediately.',
    'Berikan maklumat kemalangan yang jelas dan tepat dengan segera.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '764ec709-6b3b-4a02-bf0e-1bc78f93081a',
    0,
    'You drive in slow traffic. A driver cuts in and brakes sharply.',
    'Anda memandu dalam trafik perlahan. Seorang pemandu memotong masuk dan membrek secara mengejut.',
    '["Reduce speed smoothly and keep a safe pace", "Maintain speed to avoid being pushed back", "Slow briefly, then speed up to create space", "Adjust speed after traffic settles"]',
    '["Kurangkan kelajuan secara lancar dan kekalkan kelajuan selamat", "Kekalkan kelajuan untuk mengelak daripada didorong ke belakang.", "Perlahankan seketika kemudian tambah kelajuan untuk mewujudkan ruang di hadapan", "Sesuaikan kelajuan selepas trafik kembali stabil"]',
    0,
    'Calm speed control prevents impulsive reactions in frustrating traffic.',
    'Kawalan kelajuan yang tenang membantu mengelakkan tindak balas impulsif dalam trafik.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.25, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e41b5cb6-3c94-4983-9418-37a0562d3366',
    0,
    'You are in an active loading area during heavy rain. Surfaces are wet and equipment operates nearby.',
    'Anda berada di kawasan pemuatan aktif semasa hujan lebat. Permukaan basah dan jentera beroperasi berhampiran.',
    '["Stay clear of the loading area until conditions stabilise", "Proceed carefully while adjusting pace for the weather", "Move closer to monitor equipment movement", "Continue approaching so loading can proceed"]',
    '["Kekal jauh dari kawasan pemuatan sehingga keadaan stabil", "Teruskan dengan berhati-hati sambil laraskan kelajuan", "Bergerak lebih dekat untuk memantau pergerakan jentera", "Terus menghampiri supaya proses pemuatan boleh diteruskan"]',
    0,
    'Keep clear of loading activity when weather increases risk.',
    'Kekalkan jarak dari aktiviti pemuatan apabila keadaan cuaca meningkatkan risiko.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'aa88e0ec-dfa1-4221-9fef-760461da2d94',
    0,
    'You move from an internal roadway toward a loading area. Obstructions and movement change around you.',
    'Anda bergerak dari laluan dalaman menuju kawasan pemunggahan. Halangan dan pergerakan berubah di sekeliling.',
    '["Slow early and adjust your path to surrounding movement", "Maintain pace and react when a hazard appears", "Focus on the path ahead and reassess inside", "Follow vehicles ahead that pass smoothly"]',
    '["Perlahankan kenderaan lebih awal dan sesuaikan laluan mengikut pergerakan sekitar", "Kekalkan kelajuan dan bertindak apabila bahaya muncul", "Fokus pada laluan di hadapan dan nilai semula selepas masuk", "Ikut kenderaan di hadapan yang melalui kawasan dengan lancar"]',
    0,
    'Anticipate early and adjust space to avoid sudden reactions.',
    'Jangka lebih awal dan sesuaikan ruang untuk elakkan tindak balas mengejut.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8aec956d-9671-454e-89fa-c43b598bd480',
    0,
    'At a security checkpoint, the vehicle ahead is being cleared and the guard signals you to move closer.',
    'Di pusat pemeriksaan keselamatan, kenderaan di hadapan sedang diperiksa dan pengawal memberi isyarat supaya anda bergerak lebih dekat.',
    '["Close the gap to speed up clearance", "Keep a safe following distance", "Stop directly behind the vehicle", "Move slowly and rely on the guard to manage spacing"]',
    '["Rapatkan jarak untuk mempercepatkan pemeriksaan", "Kekalkan jarak selamat dengan kenderaan di hadapan", "Berhenti tepat di belakang kenderaan", "Bergerak perlahan dan bergantung pada pengawal untuk mengawal jarak"]',
    1,
    'Checkpoint instructions do not replace safe spacing.',
    'Arahan pusat pemeriksaan tidak menggantikan disiplin jarak selamat.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e5bfaa49-1af5-4f7c-b0a4-c57961fc6b85',
    0,
    'After a delivery, you are stopped for inspection and asked to present your documents. One document was completed late but is accurate.',
    'Selepas penghantaran, anda ditahan untuk pemeriksaan dan diminta menunjukkan dokumen. Satu dokumen dilengkapkan lewat tetapi maklumatnya tepat.',
    '["Present the documents and clarify the late entry", "Hand over the documents without mentioning the late entry", "Say the document was completed earlier", "Offer to update the document later"]',
    '["Tunjukkan dokumen dan jelaskan tentang pengisian lewat", "Serahkan dokumen tanpa memaklumkan tentang kelewatan pengisian", "Nyatakan bahawa dokumen telah dilengkapkan lebih awal", "Tawarkan untuk mengemas kini dokumen kemudian"]',
    0,
    'Present accurate documents and clarify issues during inspections.',
    'Tunjukkan dokumen yang tepat dan jelaskan perkara berkaitan semasa pemeriksaan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7a118f01-0f41-4ea2-a2e0-cf5f7a56059f',
    0,
    'While driving inside a site, you see a posted speed limit.',
    'Semasa memandu di dalam tapak, anda melihat had laju yang dipaparkan.',
    '["Adjust speed to comply with the posted limit", "Maintain current speed since traffic is light", "Reduce speed slightly but continue comfortably", "Match the speed of other vehicles"]',
    '["Laraskan kelajuan untuk mematuhi had laju yang dipaparkan", "Kekalkan kelajuan kerana trafik ringan", "Kurangkan kelajuan sedikit tetapi teruskan dengan selesa", "Ikut kelajuan kenderaan lain"]',
    0,
    'Follow posted speed limits inside operational sites.',
    'Patuhi had laju yang ditetapkan di dalam kawasan operasi.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '417625a1-5495-4318-9f86-258cc004f45d',
    0,
    'After a pre-trip inspection, you feel an unusual vibration while driving.',
    'Selepas pemeriksaan sebelum perjalanan, anda merasakan getaran tidak biasa semasa memandu.',
    '["Stop and recheck the vehicle before continuing", "Continue driving since the inspection showed no problems", "Complete the trip and report it at the end of the shift", "Ignore it unless a warning indicator appears"]',
    '["Berhenti dan periksa semula kenderaan", "Terus memandu kerana pemeriksaan awalan dibuat", "Selesaikan perjalanan dan laporkan pada akhir syif", "Abaikan kecuali lampu amaran muncul"]',
    0,
    'Unusual vehicle behaviour requires immediate checking.',
    'Perubahan mekanikal kenderaan perlu diperiksa segera.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '594e97c9-0134-4bc8-b66d-0e4a838e772e',
    0,
    'At the end of your shift, the vehicle cabin is cluttered with items.',
    'Pada akhir syif, kabin kenderaan berselerak dengan barang.',
    '["Tidy the cabin and leave it ready for the next driver", "Leave the cabin since the shift has ended", "Remove personal items and clean it the next shift", "Clean only if the next driver is known"]',
    '["Kemas kabin dan sediakan untuk pemandu seterusnya", "Biarkan kabin kerana syif telah tamat", "Ambil barang peribadi dan kemakan kabin keesokan hari", "Bersihkan hanya jika pemandu seterusnya dikenali"]',
    0,
    'Leave the cabin orderly for the next user or the next shift',
    'Tinggalkan kabin dalam keadaan kemas untuk pengguna seterusnya.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'cd58d27a-1151-4c12-8170-08bd14192a7d',
    0,
    'Before departure, you identify a cargo safety concern while another party pressures you to move immediately.',
    'Sebelum berlepas, anda mengenal pasti isu keselamatan muatan sementara pihak lain mendesak anda bergerak segera.',
    '["Proceed carefully to avoid further discussion", "Address the safety concern and explain the delay calmly", "Agree to move briefly to reduce tension", "Remain silent and delay action"]',
    '["Teruskan dengan berhati-hati untuk elakkan perbincangan lanjut", "Tangani isu keselamatan muatan dan jelaskan kelewatan dengan tenang", "Setuju bergerak seketika untuk mengurangkan ketegangan", "Berdiam diri dan tangguhkan tindakan"]',
    1,
    'Address safety concerns first while responding calmly to others.',
    'Utamakan keselamatan sambil bertindak balas dengan tenang kepada pihak lain.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b68243d6-3427-4fd3-bec6-7779ab431765',
    0,
    'While reversing slowly inside a site, you notice steering response feels abnormal.',
    'Semasa mengundur perlahan di dalam tapak, anda merasakan tindak balas stereng tidak normal.',
    '["Continue reversing carefully to clear the area", "Stop the manoeuvre and assess the defect", "Complete the reverse and report afterward", "Reduce speed further and keep moving"]',
    '["Terus mengundur dengan berhati-hati untuk lepasi kawasan itu", "Hentikan manuver dan periksa keadaan", "Selesaikan undur dan laporkan selepas itu", "Kurangkan lagi kelajuan dan teruskan bergerak"]',
    1,
    'Stopping immediately when a defect is felt during manoeuvres prevents damage and injury.',
    'Hentikan kenderaan apabila terasa tanda tidak normal semasa manuver untuk elakkan kerosakan dan kecederaan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '428cdb9f-e7e7-411f-a254-7d8e5b489fd3',
    0,
    'A customer becomes verbally aggressive after being told the delivery cannot proceed as requested.',
    'Seorang pelanggan bercakap secara agresif selepas dimaklumkan bahawa penghantaran tidak dapat diteruskan seperti diminta.',
    '["Respond firmly to assert your position", "Stay calm, acknowledge concerns, and explain the situation clearly", "End the conversation and walk away", "Repeat company policy without further engagement"]',
    '["Jawab dengan tegas untuk pertahankan pendirian", "Kekal tenang, dengar perkara yang dibangkitkan dan terangkan keadaan dengan jelas", "Tamatkan perbualan dan beredar", "Ulang dasar syarikat tanpa perbincangan lanjut"]',
    1,
    'Staying calm and acknowledging concerns helps prevent escalation and keeps the situation under control.',
    'Kekal tenang dan beri penjelasan yang jelas membantu elakkan keadaan menjadi lebih tegang dan kekalkan kawalan situasi.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '99e7dbd2-56a4-47ec-847c-f74038e29a82',
    0,
    'During unloading, a site worker suggests a small personal favour to speed up the process.',
    'Semasa proses memunggah, seorang pekerja tapak mencadangkan bantuan peribadi kecil untuk mempercepatkan proses.',
    '["Decline politely and continue unloading as required", "Agree briefly since it may help everyone finish faster", "Avoid responding directly and keep working to reduce attention", "Suggest handling the request later to keep things moving"]',
    '["Tolak dengan sopan dan teruskan proses memunggah seperti dikehendaki", "Setuju seketika kerana ia mungkin mempercepatkan kerja", "Elakkan memberi respons secara langsung dan teruskan kerja", "Cadangkan urus perkara itu kemudian supaya kerja berjalan"]',
    0,
    'Declining improper requests helps maintain integrity and fair working practices.',
    'Menolak permintaan yang tidak sesuai membantu kekalkan integriti dan amalan kerja yang adil.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e627e7f5-52b2-45de-a919-8cb8de99813f',
    0,
    'During a delivery discussion, someone becomes upset after you refuse an improper request.',
    'Semasa perbincangan penghantaran, seseorang menjadi tidak puas hati selepas anda menolak permintaan yang tidak sesuai.',
    '["Restate your position calmly and keep the discussion respectful", "Explain in detail why the request is wrong and unacceptable", "End the discussion abruptly to avoid further disagreement", "Respond firmly to make it clear the matter is closed"]',
    '["Nyatakan semula pendirian anda dengan tenang dan kekalkan perbincangan secara hormat", "Terangkan dengan terperinci mengapa permintaan itu salah dan tidak boleh diterima", "Tamatkan perbincangan secara mendadak untuk elak pertelingkahan lanjut", "Beri respons dengan tegas supaya jelas perkara itu telah selesai"]',
    0,
    'Holding your position calmly helps resolve issues without escalating conflict.',
    'Kekalkan pendirian dengan tenang untuk selesaikan isu tanpa meningkatkan ketegangan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '74c9a147-0297-433c-a982-285c434ab3ef',
    0,
    'A driver behind you flashes headlights repeatedly and gestures, appearing impatient with your speed.',
    'Seorang pemandu di belakang anda berulang kali memberi lampu tinggi dan membuat isyarat, kelihatan tidak sabar dengan kelajuan anda.',
    '["Keep your speed steady and avoid responding to the behaviour", "Speed up slightly so the situation does not turn into an argument", "Change lanes when possible to prevent further confrontation", "React briefly to signal you have noticed the other driver"]',
    '["Kekalkan kelajuan secara konsisten dan elakkan memberi respons", "Tambah sedikit kelajuan supaya keadaan tidak menjadi tegang", "Tukar lorong apabila selamat untuk mengelakkan konfrontasi", "Beri respons ringkas untuk menunjukkan anda sedar akan kehadirannya"]',
    0,
    'Maintaining steady driving and not reacting helps prevent conflicts from escalating.',
    'Pemanduan yang stabil dan tidak bertindak balas membantu mengelakkan situasi daripada menjadi tegang.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '18858c71-e9e5-47d6-aae6-c30645cff542',
    0,
    'You slow to turn near pedestrians, and nearby road users appear unsure of your intention.',
    'Anda memperlahankan kenderaan untuk membelok berhampiran pejalan kaki, dan pengguna jalan lain kelihatan tidak pasti tentang niat anda.',
    '["Signal early and make the turn carefully", "Slow further to see how others react", "Turn once there is space without signalling", "Edge forward slightly to show what you intend to do"]',
    '["Beri isyarat awal dan belok secara cermat", "Perlahankan lagi untuk melihat reaksi orang lain", "Belok apabila ada ruang tanpa memberi isyarat", "Gerak sedikit ke hadapan untuk menunjukkan niat"]',
    0,
    'Early signalling helps pedestrians and other road users understand your intention and stay safe.',
    'Isyarat awal membantu pejalan kaki dan pengguna jalan lain memahami niat anda dan kekal selamat.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9fc39509-71b0-4973-9f9a-e1fc32ba2c0f',
    0,
    'A vehicle cuts in sharply, making you angry. You need to change lanes while drivers around you are unsure of your intention.',
    'Sebuah kenderaan memotong masuk secara mengejut sehingga anda berasa marah. Anda perlu menukar lorong ketika pemandu lain di sekitar tidak pasti tentang niat anda.',
    '["Regain composure and signal clearly before changing lanes", "Change lanes quickly to get away from the situation", "Sound the horn briefly to express frustration", "Hold your lane without signalling until traffic settles"]',
    '["Tenangkan diri dan beri isyarat dengan jelas sebelum menukar lorong", "Tukar lorong dengan cepat untuk menjauhkan diri daripada situasi", "Bunyi hon seketika untuk meluahkan rasa tidak puas hati", "Kekalkan lorong tanpa memberi isyarat sehingga trafik kembali stabil"]',
    0,
    'Clear signalling after regaining composure helps others understand your intentions and keeps traffic moving safely.',
    'Isyarat yang jelas selepas menenangkan diri membantu pemandu lain memahami niat anda dan memastikan aliran trafik kekal selamat.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c019a050-4b08-4b76-a398-76d9d6c513f6',
    0,
    'You have completed 8 hours of driving for the day and one nearby delivery remains.',
    'Anda telah memandu selama 8 jam pada hari tersebut dan satu penghantaran berhampiran masih belum selesai.',
    '["Continue driving to complete the final delivery.", "Stop driving and report reaching the daily limit.", "Drive for another 30 minutes before stopping.", "Reduce speed and complete the delivery carefully."]',
    '["Terus memandu untuk menyelesaikan penghantaran terakhir.", "Hentikan pemanduan dan laporkan bahawa had harian telah dicapai.", "Memandu lagi selama 30 minit sebelum berhenti.", "Kurangkan kelajuan dan selesaikan penghantaran dengan berhati-hati."]',
    1,
    'Follow driving hour limits to maintain safety and compliance.',
    'Patuhi had waktu pemanduan untuk menjaga keselamatan dan pematuhan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9bed2bfd-0858-4c2e-aa8b-16479c4fc64d',
    0,
    'Your goods vehicle is experiencing failure at night and you need to step out.',
    'Kenderaan barangan anda mengalami kerosakan pada waktu malam dan anda perlu keluar dari kenderaan.',
    '["Exit quickly to place warning devices.", "Wear a safety vest before exiting.", "Stand beside the vehicle and observe traffic.", "Use your phone light while walking behind the vehicle."]',
    '["Keluar dengan segera untuk meletakkan alat amaran.", "Pakai jaket keselamatan sebelum keluar.", "Berdiri di sebelah kenderaan dan perhatikan trafik.", "Gunakan lampu telefon bimbit semasa berjalan di belakang kenderaan."]',
    1,
    'Ensure personal visibility before exiting to reduce roadside risk.',
    'Pastikan anda mudah dilihat sebelum keluar bagi mengurangkan risiko di tepi jalan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b265977d-3018-4916-aef0-f391a024b866',
    0,
    'During inspection, you notice the fire extinguisher has passed its expiry date.',
    'Semasa pemeriksaan, anda mendapati alat pemadam api telah melepasi tarikh luput.',
    '["Keep using it since it has not been discharged.", "Replace it with a compliant 9kg extinguisher within validity.", "Replace it with a compliant 6kg extinguisher within validity.", "Replace it with a compliant 12kg extinguisher within validity."]',
    '["Terus gunakan kerana ia belum pernah digunakan.", "Gantikan dengan alat pemadam api 9kg yang mematuhi spesifikasi dan masih dalam tempoh sah.", "Gantikan dengan alat pemadam api 6kg yang mematuhi spesifikasi dan masih dalam tempoh sah.", "Gantikan dengan alat pemadam api 12kg yang mematuhi spesifikasi dan masih dalam tempoh sah."]',
    1,
    'Ensure the required fire extinguisher meets the approved specification and validity.',
    'Pastikan alat pemadam api yang diperlukan mematuhi spesifikasi dan tempoh sah yang ditetapkan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9d5de387-3850-464d-9ba8-3375b950bb8f',
    0,
    'You are asked to modify the vehicle''s GPS tracking or speedometer settings.',
    'Anda diminta untuk mengubah suai tetapan sistem GPS atau meter kelajuan kenderaan.',
    '["Make the adjustment if it improves convenience.", "Refuse any modification that violates safety or company protocol.", "Adjust the settings temporarily and restore them later.", "Modify only if other drivers have done so."]',
    '["Buat pelarasan jika ia memudahkan urusan.", "Tolak sebarang pengubahsuaian yang melanggar peraturan keselamatan atau prosedur syarikat.", "Ubah tetapan sementara dan pulihkan kemudian.", "Buat pengubahsuaian hanya jika pemandu lain pernah melakukannya."]',
    1,
    'Do not alter vehicle systems against safety rules or company protocol.',
    'Jangan mengubah suai sistem kenderaan yang bertentangan dengan peraturan keselamatan atau prosedur syarikat.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1ad1a43c-7f21-40a3-9f57-750d11ee44eb',
    0,
    'You are selected for a random blood and urine test during duty.',
    'Anda dipilih untuk menjalani ujian darah dan air kencing secara rawak semasa bertugas.',
    '["Cooperate and undergo the test as required.", "Request to postpone the test to another day.", "Refuse the test because it is unlawful.", "Agree only if other drivers are tested first."]',
    '["Berikan kerjasama dan jalani ujian tersebut seperti yang dikehendaki.", "Minta supaya ujian ditangguhkan ke hari lain.", "Tolak ujian tersebut kerana ia tidak sah di sisi undang-undang.", "Bersetuju hanya jika pemandu lain diuji terlebih dahulu."]',
    0,
    'Comply with random substance testing as required.',
    'Patuhi ujian saringan bahan terlarang secara rawak seperti yang ditetapkan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c2a5ee07-c42f-43f2-afc2-3e08c1ff0afe',
    0,
    'You are starting your work shift for the day.',
    'Anda memulakan syif kerja pada hari tersebut.',
    '["Record your attendance at the end of the shift.", "Record your attendance at the beginning and end of the shift.", "Inform your supervisor.", "Record attendance only when requested."]',
    '["Rekodkan kehadiran pada akhir syif.", "Rekodkan kehadiran pada awal dan akhir syif.", "Maklumkan kepada penyelia.", "Rekodkan kehadiran hanya apabila diminta."]',
    1,
    'Record attendance properly at the start and end of duty.',
    'Rekod kehadiran dengan betul pada awal dan akhir tugas.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '67f7bf15-6607-4648-8da5-9ee4c3eb4e26',
    0,
    'After ensuring safety at the accident scene, what should you do next?',
    'Selepas memastikan keselamatan di lokasi kemalangan, apakah tindakan seterusnya?',
    '["Report immediately to office.", "Complete delivery first and report later.", "Wait until returning to depot.", "Inform only if damage is serious."]',
    '["Laporkan segera kepada pejabat.", "Selesaikan penghantaran dahulu dan laporkan kemudian.", "Tunggu sehingga kembali ke depot.", "Maklumkan hanya jika kerosakan adalah serius."]',
    0,
    'Report the incident immediately and await instruction.',
    'Laporkan kejadian segera dan tunggu arahan lanjut.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '670d8c6d-edfd-4aa9-bbd4-6552b883c5e8',
    0,
    'After a collision, operations asks for your location.',
    'Selepas pelanggaran, bahagian operasi meminta lokasi anda.',
    '["Provide the exact location using junctions or landmarks.", "Say you are \"near the highway\".", "Share the location after police arrival.", "Wait for GPS tracking to update automatically."]',
    '["Berikan lokasi tepat dengan menyatakan simpang atau mercu tanda.", "Berikan anggaran lokasi berdasarkan kawasan sekitar.", "Kongsi lokasi selepas polis tiba.", "Tunggu sistem GPS dikemas kini secara automatik."]',
    0,
    'Provide precise accident location details.',
    'Berikan butiran lokasi kemalangan dengan tepat dan jelas.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '491200cb-773b-4e75-8b84-0ce91c51fcdf',
    0,
    'You drive in steady multi-lane traffic. Motorcycles filter between lanes and traffic slows near an exit.',
    'Anda memandu dalam trafik berbilang lorong yang lancar. Motosikal bergerak di antara lorong dan trafik perlahan berhampiran susur keluar.',
    '["Maintain lane position and prepare for sudden movement", "Change lanes early to avoid slowing traffic", "Hold lane but move closer to the lane marking", "Continue normally and react only if traffic slows"]',
    '["Kekalkan kedudukan lorong dan bersedia untuk pergerakan mengejut", "Tukar lorong lebih awal untuk mengelakkan trafik perlahan", "Kekalkan lorong tetapi bergerak lebih dekat ke garisan lorong", "Teruskan seperti biasa dan bertindak hanya jika trafik perlahan"]',
    0,
    'Maintain stable lane position and anticipate sudden movement.',
    'Kekalkan kedudukan lorong yang stabil dan jangka pergerakan mengejut.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7e907500-739a-4d83-8d96-3a526e1ccf5b',
    0,
    'You follow a slow vehicle on a busy road. Traffic flows on the adjacent lane.',
    'Anda mengekori kenderaan perlahan di jalan sibuk. Trafik bergerak di lorong sebelah.',
    '["Wait for a clear safe gap before overtaking", "Overtake quickly to avoid staying behind", "Move closer to signal your intent", "Begin overtaking and adjust as traffic responds"]',
    '["Tunggu ruang yang benar-benar selamat sebelum memotong", "Memotong dengan cepat supaya tidak terus terperangkap", "Bergerak lebih dekat untuk memberi isyarat niat", "Mulakan memotong dan sesuaikan kedudukan mengikut trafik"]',
    0,
    'Manage frustration and wait for a clear safe gap before overtaking.',
    'Kawal rasa marah dan tunggu ruang yang benar-benar selamat sebelum memotong.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '11eee3ca-34db-411a-adbe-de25a7ec842a',
    0,
    'You are inside a terminal yard. A marshal signals you to hold while equipment moves in your path.',
    'Anda berada di dalam kawasan terminal. Seorang marshal memberi isyarat supaya berhenti sementara jentera bergerak di laluan anda.',
    '["Remain stationary until the marshal signals to proceed", "Ease forward slightly to improve visibility", "Hold briefly, then advance once equipment clears", "Follow the vehicle ahead if it begins moving"]',
    '["Kekal berhenti sehingga marshal memberi isyarat untuk bergerak", "Bergerak sedikit ke hadapan untuk meningkatkan jarak penglihatan", "Berhenti seketika kemudian bergerak apabila jentera beredar", "Ikut kenderaan di hadapan jika ia mula bergerak"]',
    0,
    'Follow marshal instructions and keep distance from operating equipment.',
    'Patuhi arahan marshal dan kekalkan jarak daripada jentera yang sedang beroperasi.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '82b8803b-3035-4ed3-a302-5ff039568783',
    0,
    'You approach a junction inside an industrial site. Internal lanes intersect and site rules require vehicles to yield.',
    'Anda menghampiri persimpangan di dalam kawasan industri. Laluan dalaman bersilang dan peraturan tapak memerlukan kenderaan memberi laluan.',
    '["Slow down and follow the site junction rule", "Roll forward and proceed when the path looks clear", "Edge into the junction to signal intention", "Enter if nearby vehicles move through safely"]',
    '["Perlahankan kenderaan dan ikut peraturan persimpangan tapak", "Bergerak perlahan dan masuk apabila laluan kelihatan jelas", "Masuk sedikit ke persimpangan untuk memberi isyarat niat", "Masuk jika kenderaan berhampiran kelihatan melalui dengan selamat"]',
    0,
    'Apply site junction rules to prevent conflicts at internal intersections.',
    'Patuhi peraturan persimpangan tapak untuk mengelakkan konflik di persimpangan dalaman.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '82b6ee92-8564-4652-bd92-b14a5be9ae4f',
    0,
    'During a roadside inspection, an officer approaches and you realise you are not wearing a safety vest.',
    'Semasa pemeriksaan di tepi jalan, seorang pegawai menghampiri dan anda sedar anda tidak memakai vest keselamatan.',
    '["Put on the safety vest and cooperate with the inspection", "Continue the inspection and wear it if instructed", "Answer the officer''s questions and address it later", "Remain where you are until the inspection ends"]',
    '["Pakai vest keselamatan dan beri kerjasama semasa pemeriksaan", "Teruskan pemeriksaan dan pakai jika diarahkan", "Jawab soalan pegawai dan uruskan kemudian", "Kekal di tempat anda sehingga pemeriksaan selesai"]',
    0,
    'Wear required safety equipment during inspections.',
    'Pakai peralatan keselamatan yang diperlukan semasa pemeriksaan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '203b3fd3-3f06-4f76-af24-e426c37a6e86',
    0,
    'While driving inside a site, you encounter uneven surfaces and hazards along the route. You are within the speed limit.',
    'Semasa memandu di dalam tapak, anda menghadapi permukaan tidak rata dan bahaya di laluan. Anda masih dalam had laju dibenarkan.',
    '["Reduce speed to suit the hazards", "Maintain speed since it is within the limit", "Adjust speed only near visible obstacles", "Continue at normal speed and rely on steering"]',
    '["Kurangkan kelajuan mengikut keadaan", "Kekalkan kelajuan kerana masih dalam had laju", "Sesuaikan kelajuan hanya berhampiran halangan yang jelas", "Teruskan pada kelajuan biasa dan bergantung pada kawalan stereng"]',
    0,
    'Adjust speed to suit conditions even within the limit.',
    'Sesuaikan kelajuan mengikut keadaan walaupun masih dalam had laju.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8a186963-c048-4d5d-aaea-265979ec14a1',
    0,
    'After a pre-trip inspection, the vehicle behaves differently once you begin moving.',
    'Selepas pemeriksaan sebelum perjalanan, kenderaan menunjukkan keadaan tidak biasa apabila anda mula bergerak.',
    '["Continue driving to see if it settles", "Stop safely and reassess the vehicle", "Adjust driving style to compensate", "Complete the trip and report later"]',
    '["Terus memandu untuk melihat sama ada keadaan kembali normal", "Berhenti dengan selamat dan periksa semula kenderaan", "Laraskan cara pemanduan untuk menyesuaikan keadaan", "Selesaikan perjalanan dan laporkan kemudian"]',
    1,
    'Vehicle behaviour should match inspection results.',
    'Jika kenderaan menunjukkan keadaan tidak biasa, berhenti dan periksa semula sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '20216335-64ed-4345-81b6-1608f159133c',
    0,
    'While preparing for delivery, you notice the cargo is not fully secured and the customer is waiting.',
    'Semasa bersedia untuk penghantaran, anda mendapati muatan tidak dikunci dengan sempurna dan pelanggan sedang menunggu.',
    '["Pause and secure the cargo before proceeding", "Continue carefully and address it afterward", "Proceed to avoid delay and handle carefully", "Proceed while explaining the situation to the customer"]',
    '["Berhenti seketika dan pastikan muatan dikunci dengan betul sebelum meneruskan", "Teruskan dengan berhati-hati dan selesaikan isu kemudian", "Teruskan untuk mengelakkan kelewatan dan kendalikan dengan berhati-hati", "Teruskan sambil menerangkan keadaan kepada pelanggan"]',
    0,
    'Secure cargo before delivery despite time pressure.',
    'Pastikan muatan selamat sebelum meneruskan penghantaran walaupun terdapat tekanan masa.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9e89c1f4-3093-48ce-bf8c-8f80a71b8a3b',
    0,
    'Before entering an industrial site, you have not completed the required pre-trip inspection.',
    'Sebelum memasuki tapak industri, anda belum melengkapkan pemeriksaan pra-perjalanan kenderaan.',
    '["Enter the site carefully and complete checks later", "Complete the inspection and follow site entry rules", "Rely on previous checks and proceed as directed", "Ask site staff to guide you inside immediately"]',
    '["Masuk ke tapak dengan berhati-hati dan lakukan pemeriksaan kemudian", "Lengkapkan pemeriksaan dan patuhi peraturan kemasukan tapak", "Bergantung pada pemeriksaan sebelumnya dan teruskan seperti diarahkan", "Minta kakitangan tapak membimbing anda masuk segera"]',
    1,
    'Complete inspections before site entry to ensure readiness and compliance.',
    'Lengkapkan pemeriksaan sebelum memasuki tapak untuk memastikan kesiapsiagaan dan pematuhan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '16938dea-b69d-4496-82f3-917910888d59',
    0,
    'While waiting inside a confined site area, the vehicle is idling near structures and pedestrians.',
    'Semasa menunggu di kawasan tapak yang sempit, enjin masih hidup berhampiran struktur dan pejalan kaki.',
    '["Keep the engine idling so you can move off quickly", "Switch off the engine while waiting", "Keep idling until instructed to move", "Remain stationary with the engine running"]',
    '["Biarkan enjin hidup supaya boleh bergerak segera", "Matikan enjin semasa menunggu", "Terus biarkan enjin hidup sehingga diarahkan bergerak", "Kekal berhenti dengan enjin masih hidup"]',
    1,
    'Switching off the engine when stationary reduces risk and unnecessary exposure in confined areas.',
    'Matikan enjin semasa berhenti untuk kurangkan risiko dan pendedahan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '18133f64-5d57-4aee-b157-dee89aa0417b',
    0,
    'During a delivery, a customer begins recording your interaction on a mobile phone.',
    'Semasa penghantaran, seorang pelanggan mula merakam interaksi anda menggunakan telefon bimbit.',
    '["Continue the discussion calm and professional", "Ask the customer to stop recording before continuing", "Keep responses brief and focus on completing the task", "Proceed with the delivery without acknowledging the recording"]',
    '["Teruskan perbincangan dengan tenang dan profesional", "Minta pelanggan berhenti merakam sebelum meneruskan", "Jawab secara ringkas dan fokus untuk selesaikan tugas", "Teruskan penghantaran tanpa mengendahkan rakaman"]',
    0,
    'Maintaining professional behaviour protects your image when interactions are visible or recorded.',
    'Kekalkan tingkah laku profesional apabila interaksi dirakam atau dilihat orang lain.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '522aa92d-7724-44ea-aa0d-0dbbbb59435b',
    0,
    'During unloading, a disagreement with site staff begins to escalate over the unloading sequence.',
    'Semasa proses memunggah, berlaku perbezaan pendapat dengan kakitangan tapak mengenai turutan memunggah muatan dan keadaan mula menjadi tegang.',
    '["Pause briefly, acknowledge the concern, and suggest resolving it calmly", "Explain in detail why your unloading sequence is correct and safer", "Continue unloading quietly to avoid making the situation worse", "Justify your approach so everyone understands your reasoning"]',
    '["Berhenti seketika dan bincang dengan tenang", "Terangkan dengan panjang lebar mengapa turutan anda lebih betul dan selamat", "Teruskan proses memunggah secara senyap untuk elak keadaan menjadi lebih tegang", "Pertahankan cara anda supaya semua faham sebabnya"]',
    0,
    'Pausing and responding calmly helps defuse tension.',
    'Berhenti seketika dan beri respons dengan tenang membantu redakan ketegangan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '118ff955-a5eb-4db0-b546-f45de257d3a2',
    0,
    'After unloading, someone pressures you to change delivery records so the issue does not escalate.',
    'Selepas proses memunggah, seseorang menekan anda supaya mengubah rekod penghantaran agar isu tersebut tidak menjadi lebih besar.',
    '["Say the records must stay as they are and continue calmly", "Change the records slightly so the discussion can end", "Leave the records for now to avoid further disagreement", "Explain repeatedly why the records cannot be changed"]',
    '["Nyatakan rekod mesti kekal seperti sedia ada dan teruskan dengan tenang", "Ubah sedikit rekod supaya perbincangan boleh dihentikan", "Biarkan rekod dahulu untuk elak pertelingkahan lanjut", "Terangkan berulang kali mengapa rekod tidak boleh diubah"]',
    0,
    'Keeping records accurate while staying calm helps prevent conflict from escalating.',
    'Kekalkan rekod yang tepat sambil bersikap tenang untuk elakkan keadaan menjadi lebih tegang.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0d96b25c-2b87-431f-89e6-9ef80550aa8c',
    0,
    'While driving through a community area, people nearby gesture for you to slow down as you pass.',
    'Semasa melalui kawasan komuniti, orang di sekitar memberi isyarat supaya anda memperlahankan kenderaan.',
    '["Reduce speed and continue driving considerately", "Maintain your speed since you are within the limit", "Slow briefly, then resume your previous speed", "Focus ahead and avoid reacting to the gestures"]',
    '["Kurangkan kelajuan dan teruskan pemanduan dengan penuh pertimbangan", "Kekalkan kelajuan kerana masih dalam had yang dibenarkan", "Perlahankan seketika, kemudian sambung semula kelajuan asal", "Fokus ke hadapan dan abaikan isyarat tersebut"]',
    0,
    'Adjusting speed in response to community signals shows courtesy and respect for local conditions.',
    'Melaras kelajuan mengikut keadaan setempat menunjukkan sikap hormat dan prihatin terhadap komuniti.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '60dee31a-d502-4c05-9ca3-1a7627d481e7',
    0,
    'In a local area, another driver gestures courteously for you to merge while traffic slows.',
    'Di kawasan tempatan, seorang pemandu memberi isyarat sopan untuk membenarkan anda masuk ketika trafik semakin perlahan.',
    '["Signal clearly and merge when safe", "Merge promptly to return the courtesy", "Hesitate briefly to avoid appearing disrespectful", "Acknowledge the gesture and continue moving"]',
    '["Beri isyarat dengan jelas dan masuk apabila selamat", "Masuk segera untuk membalas kesopanan tersebut", "Tangguh seketika supaya tidak kelihatan tidak menghormati", "Balas isyarat tersebut dan teruskan bergerak"]',
    0,
    'Clear signalling should guide merging decisions, even when courtesy is shown by others.',
    'Isyarat yang jelas dan pertimbangan keselamatan perlu menjadi panduan walaupun diberi laluan oleh pemandu lain.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1415cf31-e9c8-49ff-ac3c-76e1343d2b89',
    0,
    'You plan to install a sun shade, dark tint film, or stickers on the company truck windscreen.',
    'Anda bercadang memasang pelindung matahari, filem gelap, atau pelekat pada cermin hadapan lori syarikat.',
    '["Install them if they do not block the main driving view.", "Do not install them without company approval.", "Use removable shades only during daytime driving.", "Check whether other drivers have done similar modifications."]',
    '["Pasang jika tidak menghalang pandangan utama ketika memandu.", "Jangan pasang tanpa kelulusan syarikat.", "Gunakan pelindung yang boleh ditanggalkan pada waktu siang sahaja.", "Periksa sama ada pemandu lain pernah membuat perubahan yang sama."]',
    1,
    'Avoid unauthorised vehicle modifications that may affect safety or compliance.',
    'Elakkan pengubahsuaian kenderaan tanpa kelulusan yang boleh menjejaskan keselamatan atau pematuhan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '323e99ee-519f-4952-b635-0e82e3438485',
    0,
    'You have been on duty for 10 hours and are asked to continue working.',
    'Anda telah bertugas selama 10 jam dan diminta untuk terus bekerja.',
    '["Continue if the remaining task is short.", "Stop working after reaching the 10-hour limit.", "Work another hour and rest later.", "Continue if traffic conditions are light."]',
    '["Teruskan jika baki tugasan adalah singkat.", "Hentikan bekerja selepas mencapai had 10 jam.", "Bekerja satu jam lagi dan berehat kemudian.", "Teruskan jika keadaan trafik tidak sibuk."]',
    1,
    'Adhere to the maximum daily working hour limit.',
    'Patuhi had maksimum waktu kerja harian.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6b51c0f7-8bf5-4a4f-ab4b-8a8c20345db2',
    0,
    'Your goods vehicle is experiencing failure on a highway and you are placing safety cones behind it.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda sedang meletakkan kon keselamatan di belakangnya.',
    '["Place cones a few metres behind the vehicle to alert nearby traffic.", "Position cones to the rear, spaced about 10 metres apart.", "Place one cone directly behind the vehicle as a marker.", "Set the cones beside the vehicle to save time."]',
    '["Letakkan kon beberapa meter di belakang kenderaan untuk memberi amaran kepada trafik berhampiran.", "Letakkan kon di bahagian belakang dengan jarak kira-kira 10 meter antara satu sama lain.", "Letakkan satu kon tepat di belakang kenderaan sebagai penanda.", "Letakkan kon di sisi kenderaan untuk menjimatkan masa."]',
    1,
    'Position warning devices correctly to provide clear rear hazard warning.',
    'Letakkan alat amaran dengan jarak yang sesuai untuk memberi amaran yang jelas kepada trafik dari belakang.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0a400447-551f-42da-88f4-deaf8faf6fd6',
    0,
    'During inspection, you realise the vehicle has no working torchlight.',
    'Semasa pemeriksaan, anda mendapati tiada lampu suluh yang berfungsi di dalam kenderaan.',
    '["Proceed if driving is during daytime only.", "Replace the torchlight before operating the vehicle.", "Use your phone light if needed.", "Continue since other safety items are present."]',
    '["Teruskan perjalanan jika pemanduan hanya pada waktu siang.", "Gantikan lampu suluh tersebut sebelum mengendalikan kenderaan.", "Gunakan lampu telefon bimbit jika perlu.", "Teruskan kerana peralatan keselamatan lain masih ada."]',
    1,
    'Ensure required safety equipment is present and functional.',
    'Pastikan peralatan keselamatan yang diperlukan tersedia dan berfungsi dengan baik.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '20dec325-5c80-4746-b30f-7750b7e369f0',
    0,
    'Before starting your trip, you review the vehicle''s licensing documents.',
    'Sebelum memulakan perjalanan, anda menyemak dokumen lesen kenderaan.',
    '["Proceed if the documents were checked last month.", "Verify that all required vehicle licences are valid.", "Continue driving and check only if stopped.", "Rely on the office to monitor document validity."]',
    '["Teruskan perjalanan jika dokumen telah diperiksa bulan lepas.", "Pastikan semua lesen kenderaan yang diperlukan masih sah.", "Terus memandu dan semak hanya jika ditahan.", "Bergantung kepada pejabat untuk memantau tempoh sah dokumen."]',
    1,
    'Ensure vehicle licensing documents are valid before operating.',
    'Pastikan semua dokumen lesen kenderaan masih sah sebelum mengendalikan kenderaan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b6e338e1-860d-4f2e-a95b-79e784767064',
    0,
    'You are scheduled to begin duty at 5:00 AM.',
    'Anda dijadualkan untuk memulakan tugas pada pukul 8:00 pagi.',
    '["Arrive early to prepare before starting duty.", "Arrive exactly at 8:00 AM and prepare afterward.", "Arrive a few minutes late if traffic is light.", "Inform colleagues to cover while you arrive."]',
    '["Tiba lebih awal untuk membuat persediaan sebelum bertugas.", "Tiba tepat pukul 8:00 pagi dan buat persediaan selepas itu.", "Tiba lewat beberapa minit jika trafik lancar.", "Maklumkan rakan sekerja untuk mengambil alih tugas sementara anda tiba."]',
    0,
    'Arrive early to prepare and start duty on time.',
    'Tiba lebih awal untuk membuat persediaan dan memulakan tugas tepat pada masanya.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8e55cc25-1c1b-49b0-a184-7455803c7d09',
    0,
    'Before starting a trip, you check the prime mover and trailer documents.',
    'Sebelum memulakan perjalanan, anda menyemak dokumen kepala lori dan treler.',
    '["Ensure the permit, road tax, and inspection certificate are valid.", "Proceed if the road tax is still valid.", "Check only the prime mover documents.", "Verify documents only when stopped by enforcement."]',
    '["Pastikan permit, cukai jalan dan sijil pemeriksaan masih sah.", "Teruskan perjalanan jika cukai jalan masih sah.", "Periksa dokumen kepala lori sahaja.", "Sahkan dokumen hanya apabila ditahan penguat kuasa."]',
    0,
    'Ensure all required vehicle documents are valid before operating.',
    'Pastikan semua dokumen kenderaan yang diperlukan masih sah sebelum beroperasi.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5720b69f-0ad8-419f-b336-c3d413ffeb56',
    0,
    'During a delivery, a customer raises their voice and provokes you.',
    'Semasa membuat penghantaran, seorang pelanggan meninggikan suara dan memprovokasi anda.',
    '["Respond firmly to defend your position.", "Avoid confrontation and report to operations.", "Leave the site immediately without informing anyone.", "Continue arguing until the issue is resolved."]',
    '["Bertindak balas dengan tegas untuk mempertahankan diri.", "Elakkan pertelingkahan dan laporkan kepada bahagian operasi.", "Tinggalkan tapak serta-merta tanpa memaklumkan kepada sesiapa.", "Terus berdebat sehingga isu selesai."]',
    1,
    'Do not engage in confrontation; report the matter to operations.',
    'Elakkan pertelingkahan dan laporkan perkara tersebut kepada bahagian operasi.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7e180bfa-43cc-4d62-b653-8dfdd08940d3',
    0,
    'After a collision, the third party offers to settle repair costs privately.',
    'Selepas pelanggaran, pihak ketiga menawarkan untuk menyelesaikan kos pembaikan secara persendirian.',
    '["Accept the offer to avoid paperwork.", "Inform operations and wait for instruction.", "Negotiate and settle on the spot.", "Accept payment and continue duty."]',
    '["Terima tawaran untuk mengelakkan urusan dokumentasi.", "Maklumkan bahagian operasi dan tunggu arahan selanjutnya.", "Berunding dan selesaikan di tempat kejadian.", "Terima bayaran dan teruskan tugas."]',
    1,
    'Do not agree to private settlements without company instruction.',
    'Jangan bersetuju dengan penyelesaian persendirian tanpa arahan syarikat.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '600cc453-1ad1-444c-917a-67a30bd428e3',
    0,
    'Your vehicle is carrying chemical cargo and is involved in an accident.',
    'Kenderaan anda membawa muatan bahan kimia dan terlibat dalam kemalangan.',
    '["Inform operations of the cargo type and any hazard risk.", "Report the vehicle damage.", "Wait for emergency responders to identify the cargo.", "Mention cargo details when asked."]',
    '["Maklumkan kepada bahagian operasi jenis muatan dan sebarang risiko bahaya.", "Laporkan kerosakan kenderaan.", "Tunggu pasukan kecemasan mengenal pasti jenis muatan.", "Nyatakan butiran muatan bila ditanya."]',
    0,
    'Communicate cargo hazards immediately during an accident.',
    'Maklumkan risiko bahaya muatan dengan segera semasa kemalangan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '35e5af64-89ad-4767-bd59-60b3e07c470b',
    0,
    'You drive at cruising speed. Vehicles ahead brake intermittently and motorcycles filter between lanes.',
    'Anda memandu pada kelajuan tetap. Kenderaan di hadapan membrek dan motosikal bergerak di antara lorong.',
    '["Increase following distance for sudden slowing", "Maintain distance and brake if traffic slows", "Move closer to match the pace ahead", "Change lanes to avoid unpredictable movement"]',
    '["Tambah jarak kenderaan untuk lebih bersedia", "Kekalkan jarak dan brek jika trafik perlahan", "Bergerak lebih dekat untuk ikut kelajuan di hadapan", "Tukar lorong untuk elakkan pergerakan tidak menentu"]',
    0,
    'Extra space gives more time to respond to hazards ahead.',
    'Ruang tambahan memberi lebih masa untuk bertindak terhadap bahaya di hadapan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'cc8c140e-1d88-47b3-8428-d724f1cd0cee',
    0,
    'You drive at night in heavy rain. Spray from vehicles ahead reduces visibility.',
    'Anda memandu pada waktu malam dalam keadaan hujan lebat. Percikan air dari kenderaan di hadapan mengurangkan pandangan.',
    '["Increase following distance for more reaction time", "Maintain distance since traffic speed is steady", "Close the gap to keep sight of the vehicle ahead", "Keep the same distance and react if traffic slows"]',
    '["Tambah jarak kenderaan untuk lebih masa bertindak", "Kekalkan jarak kerana kelajuan trafik stabil", "Rapatkan jarak untuk mengekalkan pandangan kenderaan di hadapan", "Kekalkan jarak dan bertindak jika trafik perlahan"]',
    0,
    'Increase spacing in poor visibility to manage sudden slowing safely.',
    'Tingkatkan jarak antara kenderaan ketika penglihatan terhad bagi menangani tindakan brek mengejut dengan selamat.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'de42c30a-eb27-4ff9-be49-d2dd1d09ca6f',
    0,
    'Inside a site yard, you merge into an internal lane while equipment operates nearby.',
    'Di dalam kawasan tapak, anda perlu masuk ke lorong dalaman sementara jentera beroperasi berhampiran.',
    '["Wait for a clear gap with safe equipment clearance", "Merge when a small gap appears to maintain flow", "Move forward gradually to secure space", "Follow the vehicle ahead into the lane"]',
    '["Tunggu ruang jelas dengan jarak selamat daripada jentera", "Masuk apabila terdapat ruang kecil untuk kekalkan aliran trafik", "Bergerak ke hadapan secara beransur untuk mendapatkan ruang", "Ikut kenderaan di hadapan masuk ke lorong"]',
    0,
    'Choose a clear gap and keep safe distance from operating equipment.',
    'Tunggu ruang yang jelas dan kekalkan jarak selamat dari jentera beroperasi.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'cd84712b-0b95-4340-80eb-316e8f60b067',
    0,
    'After a delivery, you park in a designated area where idling is prohibited.',
    'Selepas penghantaran, anda parkir di kawasan yang ditetapkan di mana enjin tidak dibenarkan hidup.',
    '["Switch off the engine and follow the parking procedure", "Leave the engine running briefly to save time", "Complete the procedure and address the engine later", "Wait in the vehicle with the engine on"]',
    '["Matikan enjin dan ikut prosedur parkir", "Biarkan enjin hidup seketika untuk menjimatkan masa", "Lengkapkan prosedur dahulu dan matikan enjin kemudian", "Tunggu di dalam kenderaan dengan enjin masih hidup"]',
    0,
    'Follow procedures and switch off the engine where idling is prohibited.',
    'Ikut prosedur dan matikan enjin di kawasan yang melarang melahu enjin.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '75172784-ff85-484d-b254-15ec304f4f78',
    0,
    'While driving inside a site with pedestrians and equipment moving nearby, your phone receives a message.',
    'Semasa memandu di dalam tapak dengan pekerja dan jentera bergerak berhampiran, telefon anda menerima mesej.',
    '["Ignore the message and maintain full attention", "Check the message briefly since speed is low", "Slow down and glance when the area looks clear", "Respond quickly."]',
    '["Abaikan mesej dan kekalkan tumpuan penuh", "Periksa mesej seketika kerana kelajuan rendah", "Perlahankan dan lihat mesej apabila kawasan kelihatan selamat", "Balas mesej dengan cepat."]',
    0,
    'Avoid distractions in mixed-movement areas.',
    'Elakkan gangguan di kawasan pergerakan bercampur.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bc78d638-be49-4b89-94cc-d79177066ab6',
    0,
    'During a slow loading manoeuvre in a confined space, a nearby worker offers guidance.',
    'Semasa manuver perlahan untuk pemuatan di ruang sempit, seorang pekerja memberi panduan.',
    '["Pause and coordinate clearly with the worker before continuing", "Continue manoeuvring slowly and rely on hand signals as they appear", "Proceed carefully without engaging to avoid confusion", "Continue cautiously while listening for instructions and adjusting if needed"]',
    '["Berhenti seketika dan sesuaikan komunikasi dengan pekerja sebelum meneruskan", "Teruskan manuver perlahan dan bergantung pada isyarat tangan yang diberi", "Teruskan dengan berhati-hati tanpa berinteraksi untuk elakkan kekeliruan", "Teruskan dengan berhati-hati sambil mendengar arahan dan melaras jika perlu"]',
    0,
    'Clear coordination during manoeuvres helps prevent damage and supports safe cooperation.',
    'Koordinasi yang jelas semasa manuver membantu mencegah kerosakan dan menyokong kerjasama yang selamat.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a1f6c3b0-c28a-454c-a20b-ad390af8cbb5',
    0,
    'While moving through a busy site, you feel abnormal resistance and hear a new mechanical sound.',
    'Semasa bergerak di tapak yang sibuk, anda merasakan rintangan tidak normal dan bunyi mekanikal baharu.',
    '["Continue moving slowly to clear the area", "Stop safely, assess the issue, and proceed only when clear", "Adjust steering and throttle to maintain site flow", "Complete the movement and report the issue afterward"]',
    '["Terus bergerak perlahan untuk keluar dari kawasan itu", "Berhenti di tempat selamat, periksa keadaan, dan teruskan hanya apabila jelas selamat", "Laraskan stereng dan pendikit untuk mengekalkan aliran pergerakan tapak", "Selesaikan pergerakan dan laporkan masalah selepas itu"]',
    1,
    'Respond promptly to mechanical cues and ensure the area is safe before proceeding.',
    'Bertindak segera terhadap tanda mekanikal dan pastikan kawasan selamat sebelum meneruskan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ba90acd8-9f71-43d8-85b5-ee766b5d8953',
    0,
    'At a site gate, you notice a wheel chock and tool left unsecured on the vehicle before entry.',
    'Di pintu masuk tapak, anda perasan pengadang tayar dan peralatan tidak diikat kemas pada kenderaan sebelum masuk.',
    '["Enter the site and secure them at the first parking point", "Secure the items before entering the site", "Proceed inside since the items are not in use", "Ask security to allow entry first"]',
    '["Masuk tapak dan kemaskan di tempat parkir pertama", "Kemaskan dahulu sebelum masuk tapak", "Terus masuk kerana alat itu tidak digunakan", "Minta kebenaran masuk daripada pengawal dahulu"]',
    1,
    'Securing loose equipment before entry prevents avoidable risks inside controlled areas.',
    'Kemaskan peralatan sebelum masuk tapak untuk elakkan risiko.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e994228c-a574-4981-a762-c9b9313cb651',
    0,
    'A customer asks you to change delivery details on the paperwork.',
    'Seorang pelanggan meminta anda mengubah butiran penghantaran dalam dokumen.',
    '["Complete the paperwork accurately and explain the situation", "Adjust the delivery details as requested by the customer", "Leave the paperwork unchanged and submit it later", "Submit the paperwork as requested without explanation"]',
    '["Lengkapkan dokumen dengan tepat dan jelaskan keadaan sebenar", "Ubah butiran penghantaran seperti diminta", "Biarkan dokumen seperti itu dan serahkan kemudian", "Serahkan dokumen seperti diminta tanpa penjelasan"]',
    0,
    'Accurate documentation ensures transparency and protects everyone involved.',
    'Dokumentasi yang tepat memastikan ketelusan dan melindungi semua pihak.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c5a62ef9-7425-4032-95de-df0361d55096',
    0,
    'During unloading, a tense exchange with site staff starts attracting attention from people nearby.',
    'Semasa proses memunggah, perbualan tegang dengan kakitangan tapak mula menarik perhatian orang di sekeliling.',
    '["Keep your tone calm and behaviour professional", "Explain your actions in detail so observers understand your position", "Continue the task while limiting further interaction", "Justify your response to avoid appearing at fault"]',
    '["Kekalkan nada tenang dan tingkah laku profesional", "Terangkan tindakan anda dengan terperinci supaya orang lain faham", "Teruskan tugas sambil hadkan interaksi lanjut", "Jelaskan respons anda untuk elak kelihatan bersalah"]',
    0,
    'Maintaining calm, professional behaviour protects your image when situations draw public attention.',
    'Kekalkan sikap tenang dan profesional apabila situasi menarik perhatian orang ramai.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4c34d2b7-365a-4020-9a04-61b27703b337',
    0,
    'During a delivery, a customer explains that a small personal gift is customary in their culture.',
    'Semasa penghantaran, seorang pelanggan menjelaskan bahawa pemberian kecil peribadi adalah amalan dalam budayanya.',
    '["Decline respectfully and continue with the delivery as planned", "Accept briefly to avoid appearing disrespectful", "Delay responding and see how others handle it", "Explain carefully why such gifts can cause problems"]',
    '["Tolak dengan hormat dan teruskan penghantaran seperti dirancang", "Terima seketika supaya tidak kelihatan tidak hormat", "Tangguhkan respons dan lihat bagaimana orang lain bertindak", "Terangkan dengan teliti mengapa pemberian itu boleh menimbulkan isu"]',
    0,
    'Respecting culture does not require accepting gifts that compromise integrity.',
    'Menghormati budaya tidak bermaksud menerima pemberian yang boleh menjejaskan integriti.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '26e3b69d-2858-4b26-ab0a-282a9467631a',
    0,
    'You approach a road section with temporary cones where pedestrians are crossing near your lane.',
    'Anda menghampiri laluan yang dipasang kon sementara dengan pejalan kaki melintas berhampiran lorong anda.',
    '["Maintain correct lane position and proceed cautiously past the area", "Move closer to the lane edge to pass through more quickly", "Adjust position to follow vehicles ahead without slowing", "Focus on traffic flow and avoid reacting to people nearby"]',
    '["Kekalkan kedudukan lorong yang betul dan pandu dengan berhati-hati melalui kawasan tersebut", "Rapat ke tepi lorong untuk melepasi kawasan dengan lebih cepat", "Laraskan kedudukan mengikut kenderaan di hadapan tanpa memperlahankan", "Fokus pada aliran trafik dan abaikan orang di sekitar"]',
    0,
    'Maintaining lane discipline and caution protects pedestrians and reflects responsible public conduct.',
    'Disiplin lorong dan pemanduan berhati-hati melindungi pejalan kaki serta mencerminkan sikap bertanggungjawab di tempat awam.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bed2b757-d666-4b30-b234-bfb8c13f00a3',
    0,
    'You prepare to merge into a moving lane when another driver accelerates and blocks the available gap.',
    'Anda bersedia untuk masuk ke lorong yang sedang bergerak apabila seorang pemandu lain memecut dan menutup ruang yang ada.',
    '["Hold back and wait for a clearer gap", "Force the merge to assert your position", "Move closer to pressure the other driver to yield", "Gesture briefly to signal dissatisfaction"]',
    '["Tahan dan tunggu ruang yang lebih jelas serta selamat", "Paksa masuk untuk mempertahankan kedudukan anda", "Rapatkan kenderaan untuk memberi tekanan supaya pemandu lain mengalah", "Buat isyarat ringkas tanda tidak puas hati"]',
    0,
    'Waiting for a safe gap and avoiding confrontation reduces risk and prevents unnecessary conflict.',
    'Menunggu ruang yang selamat dan mengelakkan konfrontasi membantu mengurangkan risiko serta ketegangan di jalan raya.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '794c594d-d7ab-44b6-9cd0-beadddf92dd1',
    0,
    'You have completed 8 hours of driving for the day and one nearby delivery remains.',
    'Anda telah memandu selama 8 jam pada hari itu dan satu penghantaran berhampiran masih belum selesai.',
    '["Continue driving to complete the final delivery.", "Stop driving and report reaching the daily limit.", "Drive for another 30 minutes before stopping.", "Reduce speed and complete the delivery carefully."]',
    '["Terus memandu untuk menyelesaikan penghantaran terakhir.", "Hentikan pemanduan dan laporkan bahawa had harian telah dicapai.", "Memandu lagi selama 30 minit sebelum berhenti.", "Kurangkan kelajuan dan selesaikan penghantaran dengan berhati-hati."]',
    1,
    'Follow driving hour limits to maintain safety and compliance.',
    'Patuhi had waktu pemanduan untuk menjaga keselamatan dan pematuhan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fc09a195-4bd8-4ef8-9782-76f1bf348289',
    0,
    'You have worked six consecutive days and are scheduled for another duty.',
    'Anda telah bekerja selama enam hari berturut-turut dan dijadualkan untuk bertugas lagi.',
    '["Continue working if you feel fit.", "Take one rest day after six working days.", "Work half a day before taking leave.", "Swap shifts without taking a rest day."]',
    '["Terus bekerja jika anda berasa cergas.", "Ambil satu hari rehat selepas enam hari bekerja.", "Bekerja separuh hari sebelum mengambil cuti.", "Tukar syif tanpa mengambil hari rehat."]',
    1,
    'Take the required rest day after six consecutive working days.',
    'Ambil hari rehat yang ditetapkan selepas bekerja enam hari berturut-turut.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '534afa90-0f2e-4330-b610-72fad83ef2d5',
    0,
    'Your goods vehicle is experiencing failure on a highway and you are placing a warning triangle.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda sedang meletakkan segi tiga amaran.',
    '["Place it a few metres behind the vehicle for quick visibility.", "Place it about 50 metres to the rear of the vehicle.", "Place it beside the vehicle near the shoulder.", "Hold it while standing near traffic to alert drivers."]',
    '["Letakkan beberapa meter di belakang kenderaan supaya mudah dilihat dengan cepat.", "Letakkan kira-kira 50 meter di belakang kenderaan.", "Letakkan di sisi kenderaan berhampiran bahu jalan.", "Pegang sambil berdiri berhampiran trafik untuk memberi amaran."]',
    1,
    'Position warning devices at a safe rear distance to alert approaching traffic early.',
    'Letakkan alat amaran pada jarak selamat di belakang kenderaan untuk memberi amaran awal kepada trafik yang menghampiri.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '67e7c33c-a20d-43ba-ba82-68a9b1cc843f',
    0,
    'You check the vehicle and the warning triangle is missing.',
    'Anda memeriksa kenderaan dan mendapati segi tiga amaran tiada.',
    '["Continue driving if hazard lights are working.", "Replace the safety triangle before departure.", "Borrow one only when needed.", "Use cones instead of a triangle."]',
    '["Terus memandu jika lampu kecemasan berfungsi.", "Gantikan segi tiga amaran sebelum memulakan perjalanan.", "Pinjam satu hanya apabila diperlukan.", "Gunakan kon sebagai ganti segi tiga amaran."]',
    1,
    'Carry the required warning triangle before operating.',
    'Bawa segi tiga amaran yang diperlukan sebelum mengendalikan kenderaan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9f395921-b77b-4454-a54b-2db550685df3',
    0,
    'During inspection, you check the engine system before departure.',
    'Semasa pemeriksaan, anda memeriksa sistem enjin sebelum memulakan perjalanan.',
    '["Skip the check if the engine started normally.", "Verify the engine system as part of the safety inspection.", "Check only when warning lights appear.", "Inspect the engine only during scheduled servicing."]',
    '["Abaikan pemeriksaan jika enjin dapat dihidupkan seperti biasa.", "Sahkan sistem enjin sebagai sebahagian daripada pemeriksaan keselamatan.", "Periksa hanya apabila lampu amaran menyala.", "Periksa enjin hanya semasa servis berjadual."]',
    1,
    'Include engine system checks in daily safety inspections.',
    'Periksa sistem enjin setiap hari sebagai sebahagian daripada pemeriksaan keselamatan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '02059a76-7cb1-4496-bb11-92b01a37c60f',
    0,
    'You are starting and completing a delivery trip.',
    'Anda memulakan dan menamatkan satu perjalanan penghantaran.',
    '["Record the meter reading only at the end of the trip.", "Record the meter reading before and after the trip.", "Record it only if fuel usage seems unusual.", "Estimate the reading based on distance travelled."]',
    '["Catat bacaan meter hanya pada akhir perjalanan.", "Catat bacaan meter sebelum dan selepas perjalanan.", "Catat hanya jika penggunaan bahan api kelihatan luar biasa.", "Anggarkan bacaan berdasarkan jarak perjalanan."]',
    1,
    'Record meter readings before and after each trip.',
    'Catat bacaan meter sebelum dan selepas setiap perjalanan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0ae93577-c71f-4368-bacf-b8420f61a491',
    0,
    'Before departure, you review the prime mover and trailer documents. One document has expired.',
    'Sebelum memulakan perjalanan, anda menyemak dokumen kepala lori dan treler. Salah satu dokumen telah tamat tempoh.',
    '["Proceed if the other documents are still valid.", "Inform operations and do not operate until resolved.", "Continue the trip and update after delivery.", "Drive and renew the document at the next service."]',
    '["Teruskan perjalanan jika dokumen lain masih sah.", "Maklumkan bahagian operasi dan jangan beroperasi sehingga diselesaikan.", "Teruskan perjalanan dan kemas kini selepas penghantaran selesai.", "Memandu dahulu dan perbaharui dokumen pada servis seterusnya."]',
    1,
    'Do not operate if required vehicle documents have expired and inform operations immediately.',
    'Jangan beroperasi jika dokumen kenderaan yang diperlukan telah tamat tempoh dan maklumkan kepada bahagian operasi segera.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '26f91561-8210-42d7-b325-fc7eb34a54b4',
    0,
    'While driving, a member of the public provokes you aggressively.',
    'Semasa memandu, seorang orang awam bertindak agresif dan memprovokasi anda.',
    '["React quickly to assert your position.", "Remain calm and report the incident.", "Stop and confront the person.", "Follow the person to clarify the issue."]',
    '["Bertindak segera untuk mempertahankan pendirian anda.", "Kekal tenang dan laporkan kejadian tersebut.", "Berhenti dan bersemuka dengan individu tersebut.", "Ikut individu tersebut untuk menjelaskan keadaan."]',
    1,
    'Avoid impulsive actions and report the incident appropriately.',
    'Kekal tenang dan laporkan kejadian dengan cara yang sesuai.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '344cdad8-4ae8-48db-bf73-134adc69749e',
    0,
    'While driving on a highway, you notice smoke coming from the trailer.',
    'Semasa memandu di lebuh raya, anda mendapati asap keluar dari treler.',
    '["Stop at a safe roadside area without blocking traffic.", "Continue slowly to reach the nearest rest area.", "Stop immediately in the current lane.", "Park close to nearby buildings for assistance."]',
    '["Berhenti di kawasan tepi jalan yang selamat tanpa menghalang trafik.", "Teruskan memandu perlahan untuk sampai ke kawasan rehat terdekat.", "Berhenti serta-merta di lorong semasa.", "Parkir berhampiran bangunan untuk mendapatkan bantuan."]',
    0,
    'Stop in a safe open area that does not obstruct traffic.',
    'Berhenti di kawasan terbuka yang selamat dan tidak menghalang trafik.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9126a53b-22f7-433a-9cf4-d16a55c6f973',
    0,
    'After an accident, operations asks about injuries.',
    'Selepas kemalangan, bahagian operasi bertanya tentang kecederaan.',
    '["Confirm injuries to yourself and others involved.", "Say everyone seems fine without checking.", "Wait for medical staff to assess first.", "Report injuries after confirmed by hospital."]',
    '["Sahkan kecederaan kepada diri sendiri dan pihak yang terlibat.", "Maklumkan semua kelihatan baik tanpa membuat pemeriksaan.", "Tunggu petugas perubatan membuat penilaian terlebih dahulu.", "Laporkan kecederaan selepas disahkan oleh pihak hospital."]',
    0,
    'Provide accurate injury status information promptly.',
    'Berikan maklumat status kecederaan dengan tepat dan segera.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '913ab7e1-2af6-4d55-b496-4f328b582d77',
    0,
    'You prepare to change lanes in steady traffic. Motorcycles filter between lanes and traffic slows near an exit.',
    'Anda bersedia untuk menukar lorong dalam trafik lancar. Motosikal bergerak di antara lorong dan trafik perlahan berhampiran susur keluar.',
    '["Signal early and complete full mirror checks before moving", "Signal as you move and rely on others to adjust", "Check mirrors quickly and move when the lane looks clear", "Wait for traffic to stabilise before signalling"]',
    '["Beri isyarat awal dan periksa cermin sepenuhnya sebelum bergerak", "Beri isyarat semasa bergerak dan harap pemandu lain menyesuaikan diri", "Periksa cermin dengan cepat dan bergerak apabila lorong kelihatan jelas", "Tunggu trafik stabil sebelum memberi isyarat"]',
    0,
    'Signal early and complete full checks before changing lanes.',
    'Beri isyarat awal dan lakukan pemeriksaan penuh sebelum menukar lorong.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3a45824c-4cc9-4189-82dc-51c9afcc95fd',
    0,
    'You drive inside a depot with marked lanes. Equipment operates nearby and stacked loads restrict visibility.',
    'Anda memandu di dalam depot dengan lorong bertanda. Jentera beroperasi berhampiran dan susunan muatan menghadkan pandangan.',
    '["Keep to the marked lane and slow until movement is clear", "Adjust position to see past the equipment", "Continue moving so you do not block equipment behind", "Proceed as usual and rely on operators"]',
    '["Kekalkan lorong bertanda dan perlahankan sehingga pergerakan jelas", "Sesuaikan kedudukan untuk melihat melepasi jentera", "Terus bergerak supaya tidak menghalang jentera di belakang", "Teruskan seperti biasa dan bergantung pada pengendali jentera"]',
    0,
    'Keep lane discipline and reduce speed near operating equipment.',
    'Amalkan disiplin lorong dan kurangkan kelajuan berhampiran peralatan beroperasi.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '532f0d19-3ae4-4811-b420-fbd9ec4ea26e',
    0,
    'You approach an industrial access road. Surfaces are uneven, obstructions present, and visibility is reduced.',
    'Anda menghampiri laluan masuk kawasan industri. Permukaan jalan tidak rata, terdapat halangan, dan pandangan terhad.',
    '["Reduce speed early and adjust your path for hazards", "Maintain a cautious pace and react if conditions worsen", "Proceed steadily while focusing on the access route", "Follow the vehicle ahead navigating the area"]',
    '["Kurangkan kelajuan lebih awal dan sesuaikan laluan untuk elakkan bahaya", "Kekalkan kelajuan berhati-hati dan bertindak jika keadaan bertambah buruk", "Terus bergerak secara stabil sambil fokus pada laluan utama", "Ikut kenderaan di hadapan yang melalui kawasan itu"]',
    0,
    'Adjust early to surface and visibility risks to maintain control.',
    'Sesuaikan pemanduan lebih awal terhadap risiko permukaan dan pandangan untuk kekalkan kawalan kenderaan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '105514ff-dd85-407c-8d71-eeb355a4fb7c',
    0,
    'You prepare to park and deploy trailer landing legs on uneven ground.',
    'Anda bersedia untuk parkir dan menurunkan kaki sokongan treler di permukaan tidak rata.',
    '["Stop and ensure the ground is stable before deploying", "Deploy slowly and monitor for sinking", "Proceed as usual since the area is commonly used", "Rely on visual checks and adjust if movement appears"]',
    '["Berhenti dan pastikan permukaan stabil sebelum menurunkan kaki sokongan treler", "Turunkan secara perlahan dan pantau jika berlaku mendapan", "Teruskan seperti biasa kerana kawasan tersebut biasa digunakan", "Bergantung pada pemeriksaan visual dan pelarasan jika pergerakan berlaku"]',
    0,
    'Assess ground stability before deploying landing legs.',
    'Periksa kestabilan permukaan sebelum menurunkan kaki sokongan treler.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a2e1c7f4-393d-4bef-8595-cbb41b5356c7',
    0,
    'While reversing to park, your phone receives a message.',
    'Semasa mengundur untuk parkir, telefon anda menerima mesej.',
    '["Ignore the message and complete the manoeuvre", "Pause and check the message before continuing", "Continue reversing while glancing at the phone", "Stop midway and respond to the message"]',
    '["Abaikan mesej dan selesaikan manuver", "Berhenti seketika dan periksa mesej sebelum meneruskan", "Terus mengundur sambil melihat telefon", "Berhenti di tengah dan balas mesej"]',
    0,
    'Avoid device use during manoeuvres.',
    'Elakkan penggunaan telefon semasa manuver.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '199845ad-4f3c-4595-919b-13400cb37763',
    0,
    'After completing your trip, you notice a minor defect that developed during the drive.',
    'Selepas selesai perjalanan, anda mendapati kerosakan kecil berlaku semasa memandu.',
    '["Report the defect and ensure the vehicle is checked before reuse", "Note the defect later since the trip is completed", "Mention it informally to the next driver", "Leave the vehicle available since it still operates"]',
    '["Laporkan kerosakan dan pastikan kenderaan diperiksa sebelum digunakan semula", "Catat kerosakan kemudian kerana perjalanan telah selesai", "Beritahu secara tidak rasmi kepada pemandu seterusnya", "Biarkan kenderaan digunakan kerana masih boleh beroperasi"]',
    0,
    'Report defects promptly to prevent risk in the next operation.',
    'Laporkan kerosakan dengan segera untuk mengelakkan risiko dalam operasi seterusnya.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2280de1e-005a-499f-a714-5e7fed9de907',
    0,
    'After a trip, you identify a minor defect before completing the handover documentation.',
    'Selepas tamat perjalanan, anda mengesan kerosakan kecil sebelum melengkapkan dokumentasi serahan kenderaan.',
    '["Record the defect accurately and submit the documentation", "Submit the documentation first and update the defect record later", "Delay recording the defect until the next scheduled inspection", "Note the defect informally and proceed with documentation"]',
    '["Rekodkan kerosakan dengan tepat dan serahkan dokumentasi", "Serahkan dokumentasi dahulu dan kemas kini rekod kerosakan kemudian", "Tangguhkan merekod kerosakan sehingga pemeriksaan seterusnya", "Catat kerosakan secara tidak rasmi dan teruskan dokumentasi"]',
    0,
    'Defects must be formally recorded to ensure proper documentation and accountability.',
    'kerosakan mesti direkod secara rasmi untuk memastikan dokumentasi dan akauntabiliti yang betul.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9fd358f6-f1b0-4b51-b3da-12b5401da0a0',
    0,
    'While moving on a wet, uneven surface, you notice abnormal vibration and reduced vehicle response.',
    'Semasa bergerak di permukaan basah dan tidak rata, anda merasakan getaran tidak normal dan tindak balas kenderaan berkurang.',
    '["Maintain steady movement to avoid wheel slip", "Stop and assess before continuing", "Adjust speed slightly and continue through the area", "Complete the movement and report the issue later"]',
    '["Kekalkan pergerakan stabil untuk elakkan gelinciran tayar", "Berhenti dan periksa sebelum meneruskan", "Laraskan kelajuan sedikit dan teruskan melalui kawasan itu", "Selesaikan pergerakan dan laporkan masalah kemudian"]',
    1,
    'Pause to assess mechanical signals under challenging surface conditions.',
    'Berhenti dan periksa isu mekanikal dalam keadaan permukaan yang mencabar.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6d55645b-e9b9-4fa7-8325-a90129e52f4d',
    0,
    'While parked inside a site, an emergency alarm sounds and evacuation routes must be kept clear.',
    'Semasa parkir di dalam tapak, penggera kecemasan berbunyi dan laluan keluar mesti dikekalkan bebas halangan.',
    '["Remain in the cabin and wait for instructions", "Secure cabin items and clear the evacuation path immediately", "Leave the vehicle as it is and exit quickly", "Move the vehicle slightly to create more space"]',
    '["Kekal di dalam kabin dan tunggu arahan", "Pastikan barang dalam kabin tidak bergerak dan kosongkan laluan keluar segera", "Tinggalkan kenderaan seperti sedia ada dan keluar dengan cepat", "Gerakkan kenderaan sedikit untuk beri lebih ruang"]',
    1,
    'Secure loose items and clear evacuation routes immediately.',
    'Pastikan barang tidak bergerak dan kekalkan laluan keluar jelas dengan segera.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '23e529d0-fa5c-45f2-95d8-c1e45e376548',
    0,
    'During a delivery, a customer follows cultural practices unfamiliar to you.',
    'Semasa membuat penghantaran, seorang pelanggan mengikut amalan budaya yang tidak biasa bagi anda.',
    '["Acknowledge the practice and respond respectfully", "Continue the task without engaging further", "Question the practice to clarify expectations", "Follow your usual approach and proceed"]',
    '["Hormati amalan tersebut dan beri respons dengan sesuai", "Teruskan tugas tanpa melibatkan diri", "Persoalkan amalan itu untuk jelaskan jangkaan", "Ikut cara biasa anda dan teruskan"]',
    0,
    'Respecting cultural differences helps maintain positive and professional interactions.',
    'Menghormati perbezaan budaya membantu kekalkan interaksi yang profesional dan baik.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5d78d1f5-2806-40d2-a2c1-c0fd4154b31a',
    0,
    'During unloading, site staff suggest recording different details on the delivery documents to save time.',
    'Semasa proses memunggah, kakitangan tapak mencadangkan supaya butiran pada dokumen penghantaran direkod berbeza untuk jimat masa.',
    '["Record the actual details accurately", "Adjust the details slightly so unloading can finish smoothly", "Note the change later to keep the paperwork acceptable", "Leave the documents for someone else to complete"]',
    '["Catat butiran yang sebenarnya dengan tepat", "Ubah sedikit butiran supaya proses memunggah selesai dengan lancar", "Catat perubahan kemudian supaya dokumen masih kelihatan boleh diterima", "Biarkan dokumen untuk disiapkan oleh orang lain"]',
    0,
    'Recording accurate details supports accountability and prevents issues later.',
    'Merekod butiran dengan tepat membantu pastikan tanggungjawab jelas dan elakkan masalah pada masa akan datang.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bdd5fde7-ccc1-491b-8fa0-13bf7c162e47',
    0,
    'During a delivery, a cultural misunderstanding causes tension between you and the customer.',
    'Semasa penghantaran, berlaku salah faham berkaitan budaya yang menyebabkan ketegangan antara anda dan pelanggan.',
    '["Acknowledge the concern respectfully and respond calmly", "Explain your intentions in detail to clear the misunderstanding", "Step back from the discussion to prevent further discomfort", "Defend your position to avoid being seen as disrespectful"]',
    '["Ambil maklum dengan hormat dan beri respons dengan tenang", "Terangkan niat anda dengan terperinci untuk jelaskan salah faham", "Undur diri daripada perbincangan untuk elak keadaan menjadi lebih tidak selesa", "Pertahankan pendirian supaya tidak dianggap tidak hormat"]',
    0,
    'Respectful acknowledgement and calm response help ease tension caused by misunderstandings.',
    'Pengakuan yang hormat dan respons yang tenang membantu redakan ketegangan akibat salah faham.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5ab5c362-617c-4413-815e-050a92a5254e',
    0,
    'You are holding your lane in slow traffic when another driver begins tailgating and sounding the horn.',
    'Anda mengekalkan lorong dalam trafik perlahan apabila pemandu di belakang mula mengekori rapat dan membunyikan hon.',
    '["Maintain your lane position and avoid reacting to the behaviour", "Shift position slightly to signal cooperation and reduce tension", "Change lanes quickly to get away from the situation", "Gesture briefly to show you have noticed the other driver"]',
    '["Kekalkan kedudukan lorong dan elakkan memberi respons", "Ubah sedikit kedudukan untuk menunjukkan kerjasama dan mengurangkan ketegangan", "Tukar lorong dengan cepat untuk menjauhkan diri daripada situasi", "Buat isyarat ringkas untuk menunjukkan anda sedar akan kehadirannya"]',
    0,
    'Holding lane discipline and not reacting helps prevent aggressive situations from escalating.',
    'Mengekalkan disiplin lorong dan tidak bertindak balas membantu mengelakkan situasi agresif daripada menjadi lebih tegang.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '071bd6de-59f4-4e5f-8588-1eee3ed7b120',
    0,
    'You spot debris ahead and slow early, while vehicles behind continue approaching at speed.',
    'Anda terlihat objek di atas jalan di hadapan lalu memperlahankan kenderaan lebih awal, sementara kenderaan di belakang masih menghampiri dengan laju.',
    '["Ease off smoothly and press brakes smoothly to warn others", "Maintain speed to avoid confusing traffic behind", "Brake later so following vehicles react together", "Slow suddenly once the debris is closer"]',
    '["Perlahankan kenderaan secara beransur supaya lampu brek memberi amaran kepada kenderaan belakang", "Kekalkan kelajuan supaya tidak mengelirukan trafik di belakang", "Brek kemudian supaya kenderaan belakang bertindak serentak", "Perlahankan kenderaan secara mengejut apabila objek semakin hampir"]',
    0,
    'Early slowing with clear signals helps other drivers adjust safely to hazards ahead.',
    'Memperlahankan kenderaan lebih awal membantu memberi amaran awal kepada pemandu lain dan membolehkan mereka menyesuaikan diri dengan selamat.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.25, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f8955dc9-6609-45bb-8323-d1215740bf36',
    0,
    'You have been on duty for 10 hours and are asked to continue working.',
    'Anda telah bertugas selama 10 jam dan diminta untuk terus bekerja.',
    '["Continue if the remaining task is short.", "Stop working after reaching the 10-hour limit.", "Work another hour and rest later.", "Continue if traffic conditions are light."]',
    '["Teruskan jika baki tugasan adalah singkat.", "Hentikan kerja selepas mencapai had 10 jam.", "Bekerja satu jam lagi dan berehat kemudian.", "Teruskan jika keadaan trafik ringan."]',
    1,
    'Adhere to the maximum daily working hour limit.',
    'Patuhi had maksimum waktu kerja harian.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0e25e6e6-9b57-47ef-8d43-19fc1a451dad',
    0,
    'While driving, you notice the sun shade and stickers on the windscreen reduce your side visibility.',
    'Semasa memandu, anda mendapati pelindung matahari dan pelekat pada cermin hadapan mengurangkan penglihatan sisi.',
    '["Continue driving carefully despite reduced visibility.", "Stop at a safe location and remove or adjust the obstruction.", "Reduce speed and rely more on mirrors.", "Adjust your lane position to compensate for the blind area."]',
    '["Terus memandu dengan berhati-hati walaupun penglihatan terhad.", "Berhenti di lokasi yang selamat dan tanggalkan/laraskan halangan tersebut.", "Kurangkan kelajuan dan lebih bergantung pada cermin sisi.", "Laraskan kedudukan lorong untuk mengimbangi kawasan yang terhalang."]',
    1,
    'Ensure full visibility before continuing to drive safely.',
    'Pastikan penglihatan jelas sepenuhnya sebelum meneruskan pemanduan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f3139810-3415-47ad-b8f0-7ea38a701e76',
    0,
    'Your goods vehicle is experiencing failure on a highway and assistance has arrived.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan bantuan telah tiba.',
    '["Leave the vehicle where it stopped since help is present.", "Move the vehicle to a safer location when possible.", "Wait until traffic reduces before relocating.", "Relocate only if other drivers signal it is safe."]',
    '["Biarkan kenderaan di tempat ia berhenti kerana bantuan telah tiba.", "Alihkan kenderaan ke lokasi yang lebih selamat jika keadaan mengizinkan.", "Tunggu sehingga trafik berkurangan sebelum mengalihkan kenderaan.", "Alihkan hanya jika pemandu lain memberi isyarat selamat."]',
    1,
    'Relocate the vehicle to minimise continued traffic exposure.',
    'Alihkan kenderaan ke lokasi lebih selamat untuk mengurangkan pendedahan berterusan kepada trafik.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5d749c70-6e4a-4ced-9ab4-0b2bbb3d79c9',
    0,
    'You find that the first aid kit is incomplete.',
    'Anda mendapati kit pertolongan cemas tidak lengkap.',
    '["Continue if no emergency is expected.", "Replenish the first aid kit before operating.", "Rely on site facilities if needed.", "Inform later after completing the trip."]',
    '["Teruskan perjalanan jika tiada kecemasan dijangka berlaku.", "Lengkapkan kit pertolongan cemas sebelum mengendalikan kenderaan.", "Bergantung kepada kemudahan di lokasi jika perlu.", "Maklumkan kemudian selepas menamatkan perjalanan."]',
    1,
    'Maintain a complete and ready first aid kit at all times.',
    'Pastikan kit pertolongan cemas sentiasa lengkap dan sedia digunakan pada setiap masa.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '47c33054-d203-47b8-a63b-29ea280691f1',
    0,
    'Before departure, you conduct a safety inspection.',
    'Sebelum memulakan perjalanan, anda menjalankan pemeriksaan keselamatan.',
    '["Focus only on tyres since they wear faster.", "Check brakes, tyres, steering, and vehicle lights.", "Inspect brakes only if carrying heavy cargo.", "Check lights after beginning the journey."]',
    '["Periksa tayar sahaja kerana ia lebih cepat haus.", "Periksa brek, tayar, stereng dan lampu kenderaan.", "Periksa brek hanya jika membawa muatan berat.", "Periksa lampu selepas memulakan perjalanan."]',
    1,
    'Inspect all critical control and lighting systems before driving.',
    'Periksa semua sistem kawalan dan lampu sebelum memandu.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a314c136-767f-4f0d-b303-a24d03de5dbb',
    0,
    'Your driving document will expire in three weeks.',
    'Dokumen pemanduan anda akan tamat tempoh dalam tiga minggu.',
    '["Renew it two weeks before expiry.", "Renew it on your next off day.", "Renew it when you have free time.", "Renew it during the expiry week."]',
    '["Perbaharui dua minggu sebelum tamat tempoh.", "Perbaharui pada hari cuti anda yang seterusnya.", "Perbaharui apabila ada masa lapang.", "Perbaharui pada minggu tamat tempoh."]',
    0,
    'Renew required documents at least two weeks before expiry.',
    'Perbaharui dokumen yang diperlukan sekurang-kurangnya dua minggu sebelum tamat tempoh.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd6054920-7113-49ab-962b-3d7a7aa7116c',
    0,
    'After completing your assignment, you are returning the vehicle.',
    'Selepas menamatkan tugasan, anda hendak memulangkan kenderaan.',
    '["Park the truck at any available space nearby.", "Park the truck at the company''s designated area.", "Leave the truck where it is most convenient.", "Park outside temporarily and inform later."]',
    '["Parkir lori di mana-mana ruang yang tersedia berhampiran.", "Parkir lori di kawasan yang ditetapkan oleh syarikat.", "Tinggalkan lori di tempat yang paling mudah.", "Parkir di luar buat sementara dan maklumkan kemudian."]',
    1,
    'Park company vehicles only at approved locations.',
    'Parkir kenderaan syarikat hanya di lokasi yang diluluskan.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7f47f755-7021-4236-b5de-badead9f8034',
    0,
    'A roadside altercation with a member of the public escalates and feels unsafe.',
    'Berlaku pertelingkahan di tepi jalan dengan orang awam dan keadaan menjadi tidak selamat.',
    '["Handle the matter personally.", "Go to the nearest police station and report.", "Ignore it and continue driving.", "Confront the individual to settle it."]',
    '["Uruskan sendiri situasi tersebut.", "Pergi ke balai polis terdekat dan buat laporan.", "Abaikan dan teruskan pemanduan.", "Bersemuka untuk menyelesaikan isu."]',
    1,
    'Seek police assistance when safety is threatened.',
    'Dapatkan bantuan polis apabila keselamatan terancam.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '90f5219d-6139-438e-908f-f2952928f446',
    0,
    'While stopped due to a fire on the trailer, flames are visible near the rear section.',
    'Semasa berhenti akibat kebakaran pada treler, api kelihatan di bahagian belakang.',
    '["Separate the prime mover from the trailer if safe.", "Keep the unit connected to maintain stability.", "Move the vehicle slightly before taking action.", "Wait to confirm the exact fire source."]',
    '["Pisahkan kepala lori daripada treler jika keadaan selamat.", "Kekalkan sambungan untuk mengekalkan kestabilan.", "Gerakkan kenderaan sedikit sebelum mengambil tindakan.", "Tunggu untuk mengesahkan punca kebakaran."]',
    0,
    'Separate units when safe to reduce fire spread.',
    'Pisahkan unit jika keadaan selamat untuk mengurangkan risiko api merebak.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '19f45f3a-f723-4a15-a8cd-020ce7bb1530',
    0,
    'After a collision, operations asks whether the vehicle can be moved.',
    'Selepas pelanggaran, bahagian operasi bertanya sama ada kenderaan boleh dialihkan.',
    '["Inform whether the vehicle can be moved or is blocking traffic.", "Move the vehicle without informing anyone.", "Leave it as it is and end the call.", "Decide later after completing documentation."]',
    '["Maklumkan sama ada kenderaan boleh dialihkan atau sedang menghalang trafik.", "Alihkan kenderaan tanpa memaklumkan kepada sesiapa.", "Biarkan sahaja dan tamatkan panggilan.", "Buat keputusan kemudian selepas melengkapkan dokumen."]',
    0,
    'Inform operations about vehicle condition and obstruction status.',
    'Maklumkan keadaan kenderaan dan sama ada ia menghalang trafik.',
    ARRAY['MY'],
    'General Cargo',
    ARRAY['General Cargo'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);