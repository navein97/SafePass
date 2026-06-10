-- 1. Update questions table schema to support new columns
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS text_ms TEXT;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS options_ms JSONB;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS explanation_ms TEXT;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS difficulty TEXT;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS batch_number INTEGER;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS component_weights JSONB;

-- 2. Clear existing questions (optional, but ensures clean slate based on CSV)
-- DELETE FROM public.questions;

-- 3. Insert new questions
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '21a731c2-904c-44e6-aafb-ea225905131d', 
    'While driving at the posted speed, you see motorcycles filtering between lanes and uneven braking ahead.', 
    'Anda memandu pada kelajuan dibenarkan. Motosikal bergerak di antara lorong dan brek tidak sekata berlaku di hadapan.', 
    '["Maintain speed and brake if traffic slows suddenly", "Reduce speed early and increase following distance", "Change lanes to avoid slower traffic ahead", "Maintain speed and focus on the vehicle ahead"]', 
    '["Kekalkan kelajuan dan brek jika trafik perlahan secara tiba-tiba", "Kurangkan kelajuan lebih awal dan tambah jarak kenderaan", "Tukar lorong untuk mengelakkan trafik perlahan", "Kekalkan kelajuan dan fokus pada kenderaan di hadapan"]', 
    1, 
    'Reduce speed early to create time and space for sudden road changes.', 
    'Kurangkan kelajuan lebih awal untuk memberi masa dan ruang apabila keadaan jalan berubah.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '1bb29a6d-0a75-47b4-9482-9f088828653c', 
    'You merge from a slip road onto a busy highway. Vehicles ahead brake unevenly and motorcycles pass between lanes.', 
    'Anda memasuki lebuh raya dari laluan masuk. Kenderaan di hadapan membrek tidak sekata dan motosikal bergerak di antara lorong.', 
    '["Wait for a clearly safe gap before merging", "Merge and adjust speed once on the highway", "Use the gap quickly before traffic closes", "Move forward to signal intent and merge when traffic slows"]', 
    '["Tunggu jarak/ruang yang benar-benar selamat sebelum masuk", "Masuk dahulu dan ubah kelajuan di lebuh raya", "Gunakan ruang dengan cepat sebelum trafik menjadi padat/sesak", "Bergerak ke hadapan untuk beri isyarat niat dan masuk apabila trafik perlahan"]', 
    0, 
    'Choose a safe gap to avoid sudden braking and conflict during merging.', 
    'Pilih jarak yang selamat untuk mengelakkan brek mengejut dan konflik semasa masuk ke lebuh raya.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '5a7bc28a-65d4-4295-af3e-02d7b941dee6', 
    'You need to reverse into a marked bay inside a site. Space is tight, visibility is limited, and vehicles move nearby.', 
    'Anda perlu mengundur ke petak bertanda di dalam tapak. Ruang sempit, pandangan terhad, dan kenderaan bergerak berhampiran.', 
    '["Stop and reverse only when visibility and clearance are confirmed", "Reverse slowly while checking mirrors and adjusting position", "Continue reversing to avoid delaying vehicles behind", "Reverse carefully and rely on others to keep clear"]', 
    '["Berhenti dan undur hanya apabila pandangan dan ruang selamat dipastikan", "Undur perlahan sambil periksa cermin dan sesuaikan kedudukan", "Terus undur untuk elakkan melambatkan kenderaan di belakang", "Undur dengan berhati-hati dan harap orang lain menjauh"]', 
    0, 
    'Confirm visibility and clearance before reversing in confined areas.', 
    'Pastikan pandangan dan ruang selamat sebelum mengundur di kawasan sempit.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '49d57e1c-1160-423f-a49e-bc83fe2d6ba3', 
    'You approach a terminal gate where vehicles queue across multiple lanes.', 
    'Anda menghampiri pintu masuk terminal. Kenderaan beratur di beberapa lorong.', 
    '["Remain in the assigned lane and follow the gate process", "Shift to a faster lane when another vehicle is processed", "Move forward gradually as space opens ahead", "Follow the vehicle ahead through the gate"]', 
    '["Kekal di lorong yang ditetapkan dan ikut proses di pintu masuk", "Tukar ke lorong lebih laju apabila kenderaan lain sedang diproses", "Bergerak ke hadapan secara beransur-ansur apabila ruang terbuka", "Ikut kenderaan di hadapan melalui pintu masuk"]', 
    0, 
    'Remain in your lane and follow gate instructions to keep entry orderly.', 
    'Kekalkan lorong dan patuhi arahan pintu masuk untuk memastikan kemasukan teratur.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'a3cfaa3c-3f97-4584-b89a-9120cc0f9092', 
    'Inside a site yard, a marshal instructs you to hold while vehicles reposition nearby.', 
    'Di kawasan tapak, seorang marshal mengarahkan anda supaya berhenti sementara kenderaan berhampiran sedang mengubah kedudukan.', 
    '["Hold position and continue checking mirrors and blind spots", "Signal and edge forward slightly to prepare to move", "Adjust position gradually while watching the marshal", "Follow nearby vehicles once they begin moving"]', 
    '["Kekal berhenti dan terus periksa cermin serta titik buta", "Beri isyarat dan bergerak sedikit ke hadapan sebagai persediaan bergerak", "Sesuaikan kedudukan secara beransur sambil memerhati marshal", "Ikut pergerakan kenderaan berhampiran apabila ia mula bergerak"]', 
    0, 
    'Follow marshal instructions while maintaining situational awareness.', 
    'Patuhi arahan marshal sambil kekalkan kesedaran persekitaran.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '77379a40-6caa-43a9-9b9e-63c77368de27', 
    'You queue to mount a container onto your trailer. The vehicle ahead is still aligning and the area is congested.', 
    'Anda beratur untuk loading/offloading kontena ke atas treler. Kenderaan di hadapan masih melaras kedudukan dan kawasan sesak.', 
    '["Maintain spacing and wait until the mounting area is clear", "Move closer to prepare once the vehicle ahead finishes", "Close the gap slowly to reduce waiting time", "Follow ground staff signals to approach closely"]', 
    '["Kekalkan jarak dan tunggu sehingga kawasan loading/offloading kosong", "Bergerak lebih dekat untuk bersedia apabila kenderaan di hadapan selesai", "Rapatkan jarak perlahan untuk kurangkan masa menunggu", "Ikut isyarat pekerja tapak untuk menghampiri sedekat mungkin"]', 
    0, 
    'Maintain spacing during container mounting operations.', 
    'Kekalkan jarak semasa operasi loading/offloading kontena.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'c10dad49-c8db-4ce8-8514-e56b2fa3bc2d', 
    'You approach a terminal gate where entry requires credential verification. One credential is no longer valid.', 
    'Anda menghampiri pintu masuk terminal yang memerlukan pengesahan pas akses. Satu akses tidak lagi sah.', 
    '["Stop the entry process and report the issue", "Proceed with entry and resolve the issue inside", "Wait to see if the gate allows access", "Continue toward the gate since the trip is scheduled"]', 
    '["Hentikan proses masuk dan laporkan masalah tersebut", "Teruskan masuk dan selesaikan isu di dalam terminal", "Tunggu untuk melihat sama ada pintu membenarkan masuk", "Terus menuju ke pintu masuk kerana perjalanan telah dijadualkan"]', 
    0, 
    'Valid credentials are required before terminal entry.', 
    'Dokumen akses yang sah diperlukan sebelum memasuki terminal.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '90d7b95d-a147-4145-b63f-fece309c0afd', 
    'At a checkpoint, you are asked to present documents and notice the delivery time was recorded inaccurately.', 
    'Di tempat pemeriksaan, anda diminta menunjukkan dokumen dan menyedari masa penghantaran direkod tidak tepat.', 
    '["Present the document and clarify the timing if asked", "Hand over the document without mentioning the timing", "Explain verbally that the details are correct", "Ask for time to update the document before presenting it"]', 
    '["Serahkan dokumen dan jelaskan masa jika ditanya", "Serahkan dokumen tanpa menyebut tentang masa", "Jelaskan secara lisan bahawa butiran adalah betul", "Minta masa untuk mengemas kini dokumen sebelum menyerahkannya"]', 
    0, 
    'Accurate documents and cooperation support smooth inspections.', 
    'Dokumen yang tepat dan kerjasama membantu pemeriksaan berjalan lancar.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'adb4c930-132d-458b-b53a-dcabf5105537', 
    'While driving, the engine feels strained during acceleration though no warning lights appear.', 
    'Semasa memandu, enjin terasa kurang responsive semasa memecut walaupun tiada lampu amaran menyala.', 
    '["Ease acceleration and monitor the condition", "Maintain normal acceleration since no lights show", "Increase engine output to test the response", "Continue driving and act only if it worsens"]', 
    '["Kurangkan pecutan dan pantau keadaan", "Kekalkan pecutan kerana tiada lampu amaran", "Tingkatkan kuasa enjin untuk menguji tindak balas", "Terus memandu dan bertindak hanya jika keadaan bertambah teruk"]', 
    0, 
    'Respond early to unusual vehicle performance.', 
    'Bertindak awal apabila prestasi kenderaan tidak biasa.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '29c6cf6e-3dc6-477a-8e5c-59d50a26bf82', 
    'During pre-trip inspection, you discover a brake defect before departure.', 
    'Semasa pemeriksaan pra-perjalanan, anda menemui masalah pada brek sebelum berlepas.', 
    '["Proceed carefully and monitor the defect during the journey", "Delay reporting until after completing the delivery", "Report the defect immediately and follow required procedures", "Ignore the defect to avoid operational delays"]', 
    '["Teruskan dengan berhati-hati dan pantau masalah sepanjang perjalanan", "Tangguhkan laporan sehingga penghantaran selesai", "Laporkan masalah segera dan ikut prosedur yang ditetapkan", "Abaikan masalah untuk elakkan kelewatan operasi"]', 
    2, 
    'Defects must be reported before departure to ensure safety and integrity.', 
    'Masalah mesti dilaporkan sebelum berlepas untuk memastikan keselamatan dan integriti.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'c64b24a9-d1d7-4dc3-ba9d-8cc183b33a7e', 
    'While waiting in an active loading zone, you notice cargo movement that may affect load stability.', 
    'Semasa menunggu di zon pemuatan aktif, anda melihat pergerakan muatan yang boleh menjejaskan kestabilan muatan.', 
    '["Remain in position and allow loading to continue", "Stop the process and alert site staff to address the cargo risk", "Move the vehicle slightly to reduce exposure", "Monitor the situation and proceed once loading appears stable"]', 
    '["Kekal di tempat dan biarkan proses pemuatan diteruskan", "Hentikan proses dan maklumkan kakitangan tapak tentang risiko muatan", "Gerakkan kenderaan sedikit untuk mengurangkan pendedahan", "Pantau keadaan dan teruskan apabila pemuatan kelihatan stabil"]', 
    1, 
    'Address cargo instability promptly to prevent incidents in loading areas.', 
    'Tangani ketidakstabilan muatan dengan segera untuk mengelakkan insiden di kawasan pemuatan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'c14d2249-d88e-4451-8e42-e80694ce330e', 
    'A customer questions a delivery delay and speaks to you in a frustrated tone.', 
    'Seorang pelanggan mempersoalkan kelewatan penghantaran dan bercakap dengan nada tidak puas hati.', 
    '["Respond briefly and focus on completing the delivery", "Explain the situation calmly and confirm the next steps", "Defend your actions and point out factors beyond your control", "Avoid discussion and direct the customer to the office"]', 
    '["Jawab secara ringkas dan fokus untuk selesaikan penghantaran", "Terangkan keadaan dengan tenang dan sahkan langkah seterusnya", "Pertahankan tindakan anda dan jelaskan faktor di luar kawalan", "Elakkan perbincangan dan arahkan pelanggan ke pejabat"]', 
    1, 
    'Calm, clear explanation helps reduce frustration and keeps the interaction professional.', 
    'Penjelasan yang tenang dan jelas membantu kurangkan ketegangan dan kekalkan profesionalisme.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'bf4f1167-1a1d-49dd-a581-ef336257a7c8', 
    'A colleague suggests you keep quiet about a major issue to avoid attention from management.', 
    'Seorang rakan sekerja mencadangkan supaya anda berdiam diri tentang satu isu besar untuk elakkan perhatian pihak pengurusan.', 
    '["Explain clearly why the issue should be reported", "Agree to stay quiet to keep things smooth", "Avoid responding and let the matter pass", "Say little and continue with your work"]', 
    '["Jelaskan dengan terang mengapa isu itu perlu dilaporkan", "Setuju untuk berdiam diri supaya keadaan kekal tenang", "Elakkan memberi respons dan biarkan perkara itu berlalu", "Kurangkan bercakap dan teruskan kerja anda"]', 
    0, 
    'Clear communication and honesty help prevent larger problems later.', 
    'Komunikasi yang jelas dan jujur membantu elakkan masalah menjadi lebih besar.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '8cda13b5-acf1-4b59-9751-d1f8392c7e9a', 
    'While parked in a public area, a bystander hints that a small payment could allow special access.', 
    'Semasa parkir di kawasan awam, seorang individu menyatakan bahawa bayaran kecil boleh membolehkan akses khas.', 
    '["Decline politely and continue following normal procedures", "Consider the request since it may avoid inconvenience to others", "Delay responding and see if the situation resolves itself", "Suggest discussing the matter later to keep things moving"]', 
    '["Tolak dengan sopan dan ikut prosedur biasa", "Pertimbangkan permintaan itu kerana mungkin elakkan kesulitan", "Tangguhkan respons dan lihat perkembangan keadaan", "Cadangkan bincang perkara itu kemudian supaya urusan dapat diteruskan"]', 
    0, 
    'Refusing improper offers protects integrity and maintains public trust.', 
    'Menolak tawaran yang tidak sesuai membantu kekalkan integriti dan kepercayaan orang awam.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '24f1250a-b5fb-4c0d-8364-d4a1f15e007f', 
    'During a delivery, a culturally sensitive interaction is happening while people nearby are watching or recording.', 
    'Semasa penghantaran, berlaku interaksi sensitif berkaitan budaya dan orang sekeliling sedang melihat dan merakam.', 
    '["Maintain respectful behaviour and continue professionally", "Explain your actions carefully so others do not misinterpret them", "Limit the interaction to avoid drawing further attention", "Adjust your response to match how others expect you to behave"]', 
    '["Kekalkan tingkah laku yang hormat dan teruskan secara profesional", "Terangkan tindakan anda dengan teliti supaya tidak disalah tafsir", "Hadkan interaksi untuk elak menarik lebih perhatian", "Ubah respons anda mengikut jangkaan orang sekeliling"]', 
    0, 
    'Maintaining respectful, professional behaviour protects your image during visible interactions.', 
    'Sikap hormat dan profesional membantu melindungi imej anda apabila situasi diperhatikan orang lain.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'baeff1c5-7f3c-470e-9571-201082bcae42', 
    'Traffic ahead is moving, but you keep extra distance. A customer messages asking why progress feels slow.', 
    'Trafik di hadapan bergerak, namun anda mengekalkan jarak yang lebih selamat. Pelanggan menghantar mesej bertanya mengapa pergerakan agak lambat.', 
    '["Maintain safe following distance and explain the situation calmly", "Close the gap slightly so movement appears faster", "Reassure the customer and focus on keeping pace", "Ignore the message and continue driving"]', 
    '["Kekalkan jarak selamat dan jelaskan keadaan dengan tenang", "Rapatkan sedikit jarak supaya pergerakan nampak lebih cepat", "Yakinkan pelanggan dan cuba kekalkan kelajuan trafik", "Abaikan mesej dan teruskan pemanduan"]', 
    0, 
    'Keeping a safe following distance while explaining the reason supports safety and customer confidence.', 
    'Mengekalkan jarak selamat sambil memberi penjelasan membantu menjaga keselamatan dan keyakinan pelanggan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '253e3b25-39e6-4c18-9b23-e6ceb1c97f57', 
    'You slow early after spotting a hazard ahead. The driver behind reacts angrily and closes in.', 
    'Anda memperlahankan kenderaan lebih awal selepas melihat bahaya di hadapan. Pemandu di belakang bertindak marah dan merapat.', 
    '["Keep your speed steady and avoid engaging", "Speed up slightly to reduce pressure from behind", "Brake again to show there is a hazard ahead", "Gesture briefly to discourage the tailgating"]', 
    '["Kekalkan kelajuan yang stabil dan elakkan memberi respons", "Tambah sedikit kelajuan untuk mengurangkan tekanan dari belakang", "Tekan brek sekali lagi untuk menunjukkan terdapat bahaya di hadapan", "Buat isyarat ringkas untuk menghalang tingkah laku tersebut"]', 
    0, 
    'Maintaining steady driving and avoiding engagement helps manage hazards without escalating conflict.', 
    'Mengekalkan pemanduan yang stabil dan tidak bertindak balas membantu mengurus risiko tanpa menambahkan ketegangan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '1a4a480d-cc07-4cdc-ac0f-ea54fd4e6089', 
    'You have worked six consecutive days and are scheduled for another duty.', 
    'Anda telah bekerja selama enam hari berturut-turut dan dijadualkan untuk bertugas lagi.', 
    '["Continue working if you feel fit.", "Take one rest day after six working days.", "Work half a day before taking leave.", "Swap shifts without taking a rest day."]', 
    '["Terus bekerja jika anda berasa cergas.", "Ambil satu hari rehat selepas enam hari bekerja.", "Bekerja separuh hari sebelum mengambil cuti.", "Tukar syif tanpa mengambil hari rehat."]', 
    1, 
    'Take the required rest day after six consecutive working days.', 
    'Ambil hari rehat yang ditetapkan selepas enam hari bekerja berturut-turut.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '83882811-9918-469a-9ae8-b73d7063aad4', 
    'Before starting your shift, you notice dark tint film and stickers on part of the windscreen.', 
    'Sebelum memulakan syif, anda mendapati terdapat filem gelap dan pelekat pada sebahagian cermin hadapan.', 
    '["Leave them since they were already installed.", "Remove or report them because they may obstruct visibility.", "Start driving and adjust your seating position instead.", "Ignore them as long as the road ahead is visible."]', 
    '["Biarkan kerana ia telah dipasang sebelum ini.", "Tanggalkan atau laporkan kerana ia boleh menghalang penglihatan.", "Mulakan pemanduan dan laraskan kedudukan tempat duduk.", "Abaikan selagi jalan di hadapan masih kelihatan."]', 
    1, 
    'Address unauthorised modifications to protect visibility and vehicle safety.', 
    'Tangani pengubahsuaian tanpa kelulusan untuk menjaga penglihatan dan keselamatan kenderaan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'da209d60-1b38-4d1d-87a2-d96ad2373e22', 
    'A colleague asks to ride in your cabin as a second driver for convenience.', 
    'Seorang rakan sekerja meminta untuk menaiki kabin anda sebagai pemandu kedua atas alasan kemudahan.', 
    '["Allow the ride if the journey is short.", "Decline unless company authorisation is given.", "Allow the ride if the colleague is an employee.", "Permit the ride if no customers are affected."]', 
    '["Benarkan jika perjalanan adalah singkat.", "Tolak kecuali terdapat kebenaran daripada syarikat.", "Benarkan jika rakan tersebut ialah pekerja syarikat.", "Benarkan jika tiada pelanggan yang terjejas."]', 
    1, 
    'Do not carry passengers without proper company authorisation.', 
    'Jangan membawa penumpang tanpa kebenaran rasmi daripada syarikat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '04ce1574-d378-4814-bf0e-7c6be4ff2d56', 
    'You notice only three safety cones are available in the vehicle.', 
    'Anda mendapati hanya tiga kon keselamatan tersedia di dalam kenderaan.', 
    '["Proceed since cones are rarely used.", "Ensure five compliant safety cones are available.", "Carry additional cones only for highway trips.", "Proceed since 3 cones is enough."]', 
    '["Teruskan perjalanan kerana kon jarang digunakan.", "Pastikan lima kon keselamatan yang mematuhi spesifikasi tersedia.", "Bawa kon tambahan hanya untuk perjalanan di lebuh raya.", "Teruskan kerana 3 kon sudah mencukupi."]', 
    1, 
    'Ensure the required number of compliant safety cones is carried.', 
    'Pastikan bilangan kon keselamatan yang mematuhi spesifikasi dibawa seperti yang ditetapkan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '9901d0be-6526-4952-af32-532400ae3d63', 
    'You are verifying the vehicle before loading cargo.', 
    'Anda sedang mengesahkan keadaan kenderaan sebelum memuatkan kargo.', 
    '["Confirm the permitted load limit before loading.", "Load first and check weight later.", "Estimate weight based on experience.", "Accept the customer''s estimate without verification."]', 
    '["Sahkan had muatan yang dibenarkan sebelum memuatkan kargo.", "Muatkan terlebih dahulu dan periksa berat kemudian.", "Anggarkan berat berdasarkan pengalaman.", "Terima anggaran pelanggan tanpa pengesahan."]', 
    0, 
    'Confirm the permitted load limit before carrying cargo.', 
    'Sahkan had muatan yang dibenarkan sebelum membawa kargo.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '19408d92-6754-4da3-bb57-08ff6bd651aa', 
    'You are preparing for duty.', 
    'Anda sedang membuat persediaan untuk bertugas.', 
    '["Wear a collared shirt before reporting for duty.", "Wear any casual T-shirt as long as it is clean.", "Wear a sleeveless shirt in hot weather.", "Change only if instructed by a supervisor."]', 
    '["Pakai baju berkolar sebelum melapor diri untuk bertugas.", "Pakai mana-mana baju T kasual asalkan bersih.", "Pakai baju tanpa lengan ketika cuaca panas.", "Tukar pakaian hanya jika diarahkan oleh penyelia."]', 
    0, 
    'Wear proper collared attire as required for duty.', 
    'Pakai pakaian berkolar yang sesuai seperti yang ditetapkan semasa bertugas.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '51d81b8b-55ef-42e2-99f0-bc739ba592dc', 
    'After completing your task, you still have the prime mover key.', 
    'Selepas menamatkan tugasan, anda masih memegang kunci kepala lori.', 
    '["Take the key home for the next shift.", "Return the key to the company as required.", "Leave the key inside the vehicle.", "Keep the key until requested."]', 
    '["Bawa pulang kunci untuk syif seterusnya.", "Pulangkan kunci kepada syarikat seperti yang ditetapkan.", "Tinggalkan kunci di dalam kenderaan.", "Simpan kunci sehingga diminta."]', 
    1, 
    'Return vehicle keys to the company after duty.', 
    'Pulangkan kunci kenderaan kepada syarikat selepas bertugas.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '525444c7-d658-46b9-ba9f-df94022d37b0', 
    'You notice a mismatch between the seal number and the gate pass record.', 
    'Anda mendapati nombor seal tidak sepadan dengan rekod pada gate pass.', 
    '["Proceed if the container is sealed.", "Report to operations for further instruction.", "Correct the document yourself.", "Continue if the customer is waiting."]', 
    '["Teruskan jika kontena telah dimeterai.", "Laporkan kepada bahagian operasi untuk arahan selanjutnya.", "Betulkan dokumen sendiri.", "Teruskan perjalanan jika pelanggan sedang menunggu."]', 
    1, 
    'Report any container or seal discrepancy before proceeding.', 
    'Laporkan sebarang perbezaan pada kontena atau seal sebelum meneruskan perjalanan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'ab2c6850-fff7-4c89-8f0e-fb6c786d580f', 
    'At the customer site, the container door appears misaligned.', 
    'Di premis pelanggan, pintu kontena kelihatan tidak sejajar.', 
    '["Record it internally and inform operations.", "Lock it and continue.", "Deliver first and explain later.", "Adjust it without reporting."]', 
    '["Catat dalam rekod dalaman dan maklumkan bahagian operasi.", "Kunci pintu dan teruskan perjalanan.", "Hantar dahulu dan jelaskan kemudian.", "Laraskan tanpa melaporkan."]', 
    0, 
    'Report container defects before moving.', 
    'Laporkan kecacatan kontena sebelum meneruskan pergerakan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'cd42e8c2-75e2-4666-8e26-c2e09a2b5d84', 
    'The customer indicates a location that appears tight and near property.', 
    'Pelanggan menunjukkan lokasi yang kelihatan sempit dan berhampiran harta benda.', 
    '["Position quickly to minimise delay.", "Prioritise safety to prevent property damage or injury.", "Follow the instruction eventhough you have doubts.", "Ask workers to stand nearby to guide closely."]', 
    '["Letakkan kontena dengan cepat untuk mengurangkan kelewatan.", "Utamakan keselamatan bagi mengelakkan kerosakan atau kecederaan.", "Teruskan walaupun anda mempunyai keraguan tentang ruang tersebut.", "Minta pekerja berdiri berhampiran untuk memberi panduan dari jarak dekat."]', 
    1, 
    'Prioritise safety when positioning containers on site.', 
    'Utamakan keselamatan semasa meletakkan kontena di tapak.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '984bea34-e2b6-43bf-8c64-3ec368a9c97c', 
    'After a road collision, what should you record first?', 
    'Selepas berlaku pelanggaran jalan raya, apakah yang perlu anda catat terlebih dahulu?', 
    '["The exact accident location.", "The damages.", "The estimated repair cost.", "The traffic condition."]', 
    '["Lokasi kemalangan yang tepat.", "Kerosakan yang berlaku.", "Anggaran kos pembaikan.", "Keadaan trafik."]', 
    0, 
    'Record the accident location accurately.', 
    'Catat lokasi kemalangan dengan tepat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '85949ff4-e7ab-400f-a09b-e867832a2a95', 
    'Your vehicle catches fire during transit.', 
    'Kenderaan anda terbakar semasa dalam perjalanan.', 
    '["Inform operations or the company safety team immediately.", "Attempt to control the fire fully before reporting.", "Inform the customer first.", "Report only if damage is severe."]', 
    '["Maklumkan kepada bahagian operasi atau pasukan keselamatan syarikat dengan segera.", "Cuba kawal kebakaran sepenuhnya sebelum melaporkan.", "Maklumkan kepada pelanggan terlebih dahulu.", "Laporkan hanya jika kerosakan adalah serius."]', 
    0, 
    'Report fire incidents immediately for further instruction.', 
    'Laporkan kejadian kebakaran dengan segera untuk arahan lanjut.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '16f67001-5f23-4631-85f0-6d6585ae0249', 
    'During initial reporting, what should you do if additional relevant details arise?', 
    'Semasa laporan awal dibuat, apakah yang perlu anda lakukan jika terdapat maklumat tambahan yang berkaitan?', 
    '["Share any information that supports the initial report.", "Limit information to basic facts only.", "Provide extra details only if requested later.", "Wait until writing a formal report."]', 
    '["Kongsikan maklumat yang menyokong laporan awal.", "Hadkan maklumat kepada fakta asas sahaja.", "Berikan butiran tambahan hanya jika diminta kemudian.", "Tunggu sehingga menyediakan laporan rasmi."]', 
    0, 
    'Provide all relevant information for the initial response.', 
    'Berikan semua maklumat yang berkaitan untuk tindakan awal yang tepat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    1, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'f9cac8e7-0fe5-4665-9b48-89778751203b', 
    'You position your vehicle in a loading area where forklifts are operating.', 
    'Anda meletakkan kenderaan di kawasan memuat/memunggah barang di mana forklift sedang beroperasi.', 
    '["Move forward quickly and stop near loading", "Stop at a safe distance and proceed when clear", "Continue moving and rely on forklift guidance", "Park as close as possible despite limited space"]', 
    '["Bergerak cepat ke hadapan dan berhenti berhampiran kawasan memuat/memunggah barang", "Berhenti pada jarak selamat dan bergerak apabila laluan sudah jelas", "Terus bergerak dan bergantung pada panduan forklift", "Parkir sedekat mungkin walaupun ruang terhad"]', 
    1, 
    'Keep a safe distance from active loading zones to reduce collision risk.', 
    'Kekalkan jarak selamat dari kawasan kawasan pemuatan aktif untuk mengurangkan risiko pelanggaran.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'dee918b8-06c1-4fb8-bc49-0047c6ef4726', 
    'You approach a busy junction. Traffic slows and visibility is partly blocked by surrounding vehicles.', 
    'Anda menghampiri persimpangan yang sibuk. Trafik perlahan dan sebahagian pandangan terhalang oleh kenderaan sekeliling.', 
    '["Reduce speed early and prepare to stop", "Maintain speed and brake only if needed", "Slow slightly and move when the vehicle ahead moves", "Keep moving to clear the junction quickly"]', 
    '["Kurangkan kelajuan lebih awal dan bersedia untuk berhenti", "Kekalkan kelajuan dan brek hanya jika perlu", "Perlahankan sedikit dan bergerak apabila kenderaan di hadapan bergerak", "Terus bergerak untuk melepasi persimpangan dengan cepat"]', 
    0, 
    'Reduce speed before junctions to respond safely to unexpected movement.', 
    'Kurangkan kelajuan sebelum persimpangan untuk bertindak balas dengan selamat terhadap pergerakan mengejut.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'd8f29d31-a805-4fb7-9f34-1371ea457a56', 
    'You are on foot near your vehicle in an active loading area. Forklifts operate and stacked goods restrict visibility.', 
    'Anda berjalan berhampiran kenderaan di kawasan pemunggahan aktif. Forklift beroperasi dan susunan barangan menghadkan pandangan.', 
    '["Keep clear of loading paths and wait until movement settles", "Move closer to observe equipment movement", "Walk through quickly to minimise time in the area", "Stand where operators can see you and keep moving"]', 
    '["Kekal jauh dari laluan pemunggahan dan tunggu sehingga pergerakan reda", "Bergerak lebih dekat untuk memerhati pergerakan jentera", "Berjalan cepat untuk kurangkan masa di kawasan itu", "Berdiri di tempat pengendali boleh nampak dan terus bergerak"]', 
    0, 
    'Keep clear of loading activity to avoid sudden equipment movement and blind spots.', 
    'Kekalkan jarak dari aktiviti pemunggahan untuk elakkan pergerakan jentera mengejut dan kawasan titik buta.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'ad64b4e0-b8e6-4065-a72e-b34fbcad14ff', 
    'You drive inside an industrial site where equipment operates near the roadway.', 
    'Anda memandu di dalam kawasan industri di mana jentera beroperasi berhampiran laluan.', 
    '["Reduce speed early and keep extra clearance from equipment", "Maintain pace and adjust if equipment enters your path", "Continue slowly to pass before equipment repositions", "Follow the vehicle ahead past the equipment"]', 
    '["Kurangkan kelajuan lebih awal dan kekalkan jarak daripada jentera", "Kekalkan kelajuan dan sesuaikan jika jentera memasuki laluan anda", "Terus bergerak perlahan untuk melepasi sebelum jentera beralih", "Ikut kenderaan di hadapan melepasi jentera"]', 
    0, 
    'Reduce speed early and keep clear of operating equipment.', 
    'Kurangkan kelajuan lebih awal dan kekalkan jarak dari jentera beroperasi.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '522a379d-9a5a-4a99-bcd0-3e653c24b540', 
    'Inside a site yard, equipment operates near your path when another vehicle cuts across.', 
    'Di kawasan tapak, jentera beroperasi berhampiran laluan anda dan tiba-tiba sebuah kenderaan melintas di hadapan.', 
    '["Slow down, keep distance from equipment, and continue calmly", "Adjust position to regain progress while watching equipment", "Proceed steadily to clear the area quickly", "Follow the vehicle ahead closely to avoid delay"]', 
    '["Perlahankan, kekalkan jarak dari jentera, dan teruskan dengan tenang", "Laraskan kedudukan untuk meneruskan pergerakan sambil memerhati jentera", "Terus bergerak untuk melepasi kawasan itu dengan cepat", "Ikut kenderaan di hadapan dengan rapat untuk elakkan kelewatan"]', 
    0, 
    'Maintain composure and distance near operating equipment.', 
    'Kekalkan ketenangan dan jarak selamat berhampiran jentera beroperasi.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '89563f71-9137-461f-8cd2-01452a766910', 
    'Before starting duty, you have not completed the required rest and are still under medication.', 
    'Sebelum memulakan tugas, anda belum mendapat rehat yang cukup dan masih di bawah kesan ubat.', 
    '["Delay starting duty and report the issue", "Start the trip carefully since the route is familiar", "Begin driving and stop later if you feel affected", "Proceed and take rest after your shift"]', 
    '["Tangguhkan tugas dan laporkan keadaan tersebut", "Mulakan perjalanan dengan berhati-hati kerana laluan sudah biasa", "Mula memandu dan berhenti kemudian jika terasa terjejas", "Teruskan dan ambil rehat selepas tamat syif"]', 
    0, 
    'Confirm fitness for duty before driving.', 
    'Pastikan kecergasan untuk bertugas sebelum memandu.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'dce46dac-d513-4fd5-b63e-f76aa0323b42', 
    'At a site entrance, valid driving credentials are required. One required credential has expired.', 
    'Di pintu masuk tapak, kelayakan memandu yang sah diperlukan. Satu kelayakan telah tamat tempoh.', 
    '["Stop the entry process and report the issue", "Complete the safety induction and resolve it later", "Proceed since rules will be explained during induction", "Wait to see if access is granted"]', 
    '["Hentikan proses masuk dan laporkan masalah tersebut", "Selesaikan taklimat keselamatan dan uruskan kemudian", "Teruskan masuk kerana peraturan akan diterangkan semasa taklimat", "Tunggu untuk melihat sama ada akses dibenarkan"]', 
    0, 
    'Valid credentials are required before site entry.', 
    'Kelayakan yang sah diperlukan sebelum memasuki tapak.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'e4031f3e-e9bf-42f4-8504-7b3ae1e87da3', 
    'After loading at a site, procedure requires using a designated exit route.', 
    'Selepas selesai memunggah keluar di tapak, prosedur memerlukan anda menggunakan laluan keluar yang ditetapkan.', 
    '["Follow the designated exit route and site rules", "Take a shorter route since no traffic is visible", "Adjust your exit path to save time", "Exit based on familiarity rather than instructions"]', 
    '["Ikut laluan keluar dan peraturan pergerakan tapak", "Ambil laluan lebih pendek kerana tiada trafik kelihatan", "Laraskan laluan keluar untuk menjimatkan masa", "Keluar berdasarkan kebiasaan dan bukan arahan"]', 
    0, 
    'Follow site exit routes and movement rules.', 
    'Ikut laluan keluar dan peraturan pergerakan tapak.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '71e4d872-49cf-43ff-abeb-af92dab8e69e', 
    'While manoeuvring at low speed in a confined space, you notice resistance and a faint scraping sound.', 
    'Semasa membuat manuver pada kelajuan rendah di ruang sempit, anda merasakan rintangan dan bunyi geseran ringan.', 
    '["Stop and reassess clearance before continuing", "Proceed slowly and rely on steering to clear the space", "Apply more throttle to finish quickly", "Continue and inspect the vehicle after the manoeuvre"]', 
    '["Berhenti dan semak semula ruang sebelum meneruskan", "Terus bergerak perlahan dan bergantung pada stereng", "Tekan minyak lebih untuk menyelesaikan manuver dengan cepat", "Teruskan dan periksa kenderaan selepas manuver selesai"]', 
    0, 
    'Stop when unusual resistance or sounds occur.', 
    'Berhenti apabila terdapat rintangan atau bunyi tidak biasa.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '610c6daf-0e95-4823-b36f-63ea2c5a2eaa', 
    'During a rest stop, you notice rubbish and food containers inside the truck cabin.', 
    'Semasa berhenti rehat, anda melihat sampah dan bekas makanan di dalam kabin lori.', 
    '["Leave the cabin unchanged since cleanliness does not affect vehicle operation", "Clean the cabin later when the schedule is less demanding", "Clean and tidy the cabin immediately", "Remove only items that may interfere with driving controls"]', 
    '["Biarkan kabin seperti itu kerana kebersihan tidak menjejaskan operasi kenderaan", "Bersihkan kabin kemudian apabila jadual kurang sibuk", "Bersihkan dan kemaskan kabin segera", "Buang hanya barang yang boleh mengganggu kawalan pemanduan"]', 
    2, 
    'Maintaining cabin cleanliness supports safe operation and professional standards.', 
    'Menjaga kebersihan kabin menyokong operasi selamat dan mencerminkan profesionalisme.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'e45575d1-246e-427d-9637-ecefbcb477b7', 
    'While reversing slowly in a tight site area, you lose clear sight of one rear corner.', 
    'Semasa mengundur perlahan di kawasan tapak yang sempit, anda hilang pandangan jelas pada satu sudut belakang.', 
    '["Continue reversing slowly using mirrors", "Stop the vehicle and reassess the situation", "Turn the steering slightly and keep moving", "Rely on previous experience and continue"]', 
    '["Terus mengundur perlahan menggunakan cermin", "Berhenti dan nilai semula keadaan", "Pusing stereng sedikit dan terus bergerak", "Bergantung pada pengalaman lalu dan teruskan"]', 
    1, 
    'Stop when visibility is uncertain to prevent damage and protect people and property.', 
    'Berhenti apabila pandangan tidak jelas untuk mengelakkan kerosakan dan melindungi orang serta harta benda.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'eb7cd744-8cc5-4f74-b2a1-af5300594ac1', 
    'During unloading, site staff give instructions abruptly while you are positioning the vehicle.', 
    'Semasa memunggah muatan, kakitangan tapak memberi arahan secara tiba-tiba ketika anda sedang memposisikan kenderaan.', 
    '["Respond minimally and focus only on vehicle positioning", "Acknowledge the instructions and coordinate calmly", "Challenge the tone and clarify who is responsible", "Proceed without engaging further"]', 
    '["Jawab secara minimum dan fokus pada posisi kenderaan sahaja", "Akui arahan tersebut dan bekerjasama dengan tenang", "Persoalkan nada arahan dan jelaskan siapa bertanggungjawab", "Teruskan tanpa melibatkan diri"]', 
    1, 
    'Calm coordination helps tasks run smoothly, even when instructions are delivered abruptly.', 
    'Bekerjasama dengan tenang membantu kerja berjalan lancar walaupun arahan diberi secara tiba-tiba.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'ff434425-52ff-4a2e-9bb5-8831871bc7ff', 
    'A disagreement arises on site, and the discussion starts to become tense.', 
    'Berlaku perbezaan pendapat di tapak dan perbincangan mula menjadi tegang.', 
    '["Speak calmly, acknowledge concerns, and clarify next steps", "Restate your position firmly to end the discussion", "Reduce interaction and wait for the situation to pass", "Continue the task without engaging further"]', 
    '["Bercakap dengan tenang dan jelaskan langkah seterusnya", "Tegaskan pendirian anda untuk tamatkan perbincangan", "Kurangkan interaksi dan tunggu keadaan reda", "Teruskan tugas tanpa melibatkan diri"]', 
    0, 
    'Calm acknowledgement and clear steps help prevent disagreements from escalating.', 
    'Pendekatan yang tenang dan langkah yang jelas membantu elakkan keadaan menjadi lebih tegang.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'a49be27d-65d5-4249-8c1b-d1a75291b597', 
    'In a public area, a bystander becomes upset about where your vehicle is stopped.', 
    'Di kawasan awam, seorang individu berasa tidak puas hati tentang lokasi kenderaan anda berhenti.', 
    '["Respond calmly, acknowledge the concern, and explain briefly", "Explain in detail why the stop is necessary and allowed", "Avoid engagement and continue the task to prevent escalation", "Justify your position firmly so the complaint does not continue"]', 
    '["Beri respons tenang, ambil maklum dan jelaskan secara ringkas", "Terangkan dengan terperinci mengapa berhenti di situ perlu dan dibenarkan", "Elakkan berinteraksi dan teruskan tugas", "Pertahankan posisi anda dengan tegas supaya aduan tidak berlanjutan"]', 
    0, 
    'Calm acknowledgement helps ease public tension and prevents situations from escalating.', 
    'Respons yang tenang dan jelas membantu redakan ketegangan dan elakkan keadaan menjadi lebih serius.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '1ccb4a76-fc8c-476f-a378-c7f158e71007', 
    'A customer calls you during the trip and urges you to arrive faster due to a delay.', 
    'Seorang pelanggan menelefon semasa perjalanan dan mendesak anda tiba lebih cepat kerana berlaku kelewatan.', 
    '["Maintain a safe speed and explain your expected arrival time", "Increase speed slightly to show effort and responsiveness", "Reassure the customer and focus on reaching sooner", "Shorten the conversation and continue driving as planned"]', 
    '["Kekalkan kelajuan selamat dan maklumkan anggaran masa ketibaan", "Tambah sedikit kelajuan untuk tunjuk usaha dan responsif", "Yakinkan pelanggan dan cuba sampai lebih awal", "Pendekkan perbualan dan teruskan perjalanan seperti biasa"]', 
    0, 
    'Maintaining safe speed while giving a clear update supports both safety and customer trust.', 
    'Kekalkan kelajuan selamat sambil beri maklumat jelas bagi menjaga keselamatan dan kepercayaan pelanggan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '327140d3-6885-4837-b3fc-d7eddd248455', 
    'Traffic ahead slows sharply. You increase following distance while vehicles behind close in without warning.', 
    'Trafik di hadapan menjadi perlahan secara mendadak. Anda menambah jarak hadapan sementara kenderaan di belakang semakin menghampiri tanpa amaran.', 
    '["Ease off early and activate brake lights to signal slowing", "Maintain speed to avoid confusing drivers behind", "Close the gap to match traffic flow", "Brake later so others are forced to react"]', 
    '["Lepaskan pedal awal dan hidupkan lampu brek untuk memberi isyarat memperlahankan kenderaan", "Kekalkan kelajuan supaya tidak mengelirukan pemandu di belakang", "Rapatkan jarak untuk mengikut aliran trafik", "Tekan brek secara mengejut supaya pemandu lain terpaksa bertindak balas"]', 
    0, 
    'Creating space early and signalling clearly helps others adjust safely to changing traffic conditions.', 
    'Mewujudkan ruang lebih awal dan memberi isyarat dengan jelas membantu pemandu lain menyesuaikan diri dengan selamat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '6470902b-9e7c-4124-9f1d-e4de82802ef9', 
    'At a junction, you prepare to turn while another vehicle approaches from the side and appears unsure of your intention.', 
    'Di simpang jalan, anda bersedia untuk membelok apabila sebuah kenderaan dari sisi kelihatan tidak pasti tentang niat anda.', 
    '["Signal early and complete the turn when it is safe", "Roll forward slightly to indicate you intend to go", "Wait longer to see how the other driver reacts", "Turn once there is space to avoid delaying traffic behind"]', 
    '["Beri isyarat awal dan belok apabila selamat", "Gerak sedikit ke hadapan untuk menunjukkan niat", "Tunggu lebih lama untuk melihat reaksi pemandu lain", "Belok apabila ada ruang untuk mengelakkan kelewatan di belakang"]', 
    0, 
    'Clear signalling at junctions helps other drivers understand your intention and reduces uncertainty.', 
    'Isyarat yang jelas di simpang membantu pemandu lain memahami niat anda dan mengurangkan ketidakpastian.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'ac8f7884-e18a-4d36-90a7-2d98e8f9be2e', 
    'While driving, you notice the sun shade and stickers on the windscreen reduce your side visibility.', 
    'Semasa memandu, anda mendapati pelindung matahari dan pelekat pada cermin hadapan mengurangkan penglihatan sisi.', 
    '["Continue driving carefully despite reduced visibility.", "Stop at a safe location and remove or adjust the obstruction.", "Reduce speed and rely more on mirrors.", "Adjust your lane position to compensate for the blind area."]', 
    '["Terus memandu dengan berhati-hati walaupun penglihatan berkurang.", "Berhenti di lokasi selamat dan tanggalkan/laraskan halangan tersebut.", "Kurangkan kelajuan dan lebih bergantung pada cermin sisi.", "Laraskan kedudukan lorong untuk mengimbangi kawasan yang terhalang."]', 
    1, 
    'Ensure full visibility before continuing to drive safely.', 
    'Pastikan penglihatan jelas sepenuhnya sebelum meneruskan pemanduan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '73beebdc-8a6f-46ff-8315-a4a3e711dc78', 
    'You arrive at a customer site to uncouple the trailer on uneven, soft ground.', 
    'Anda tiba di tapak pelanggan untuk membuka sambungan treler di atas permukaan tanah yang tidak rata dan lembut.', 
    '["Lower the landing legs carefully and check stability after uncoupling.", "Place strong wooden planks under the landing legs before uncoupling.", "Adjust the trailer position slightly to find firmer ground before uncoupling.", "Ask site staff to observe the trailer during the process."]', 
    '["Turunkan kaki sokongan dengan berhati-hati dan periksa kestabilan selepas membuka sambungan.", "Letakkan papan kayu yang kukuh di bawah kaki sokongan sebelum membuka sambungan.", "Laraskan sedikit kedudukan treler untuk mencari tanah yang lebih kukuh sebelum membuka sambungan.", "Minta kakitangan tapak memerhati treler semasa proses tersebut."]', 
    1, 
    'Ensure stable ground support before uncoupling to prevent trailer instability.', 
    'Pastikan sokongan tanah stabil sebelum membuka sambungan bagi mengelakkan treler menjadi tidak stabil.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '5c0c05b6-093d-4bda-99c4-f6d7e9f35061', 
    'You are preparing to start your trip and will return later the same day.', 
    'Anda sedang bersedia untuk memulakan perjalanan dan akan kembali pada hari yang sama.', 
    '["Conduct inspection only before starting the trip.", "Conduct inspection only after completing the trip.", "Conduct inspections both before and after the trip.", "Conduct inspection only if a defect is suspected."]', 
    '["Lakukan pemeriksaan sebelum memulakan perjalanan sahaja.", "Lakukan pemeriksaan selepas menamatkan perjalanan sahaja.", "Lakukan pemeriksaan sebelum dan selepas perjalanan.", "Lakukan pemeriksaan hanya jika terdapat tanda kerosakan."]', 
    2, 
    'Perform required inspections before and after every trip.', 
    'Lakukan pemeriksaan yang ditetapkan sebelum dan selepas setiap perjalanan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '605cdcec-d83f-47e8-bba5-4ce49a0dc3f4', 
    'The reflective string delineators are damaged and no longer reflective.', 
    'Tali delineator reflektif rosak dan tidak lagi memantulkan cahaya.', 
    '["Continue if cones are available.", "Replace them with compliant reflective delineators.", "Use hazard lights instead.", "Keep them until the next inspection cycle."]', 
    '["Teruskan perjalanan jika kon keselamatan tersedia.", "Gantikan dengan delineator reflektif yang mematuhi spesifikasi.", "Gunakan lampu kecemasan sebagai ganti.", "Kekalkan penggunaannya sehingga pemeriksaan seterusnya."]', 
    1, 
    'Maintain compliant reflective equipment for roadside safety.', 
    'Pastikan peralatan reflektif yang mematuhi spesifikasi sentiasa tersedia untuk keselamatan di tepi jalan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'f0e4e9b2-8f58-42dd-802c-9e61fe1ffb57', 
    'During inspection, you review emergency and fire equipment in the vehicle.', 
    'Semasa pemeriksaan, anda menyemak peralatan kecemasan dan pemadam api di dalam kenderaan.', 
    '["Check only for long-distance trips.", "Ensure emergency and fire equipment is complete and valid.", "Assume it is sufficient if previously used.", "Check after starting the trip."]', 
    '["Periksa hanya untuk perjalanan jarak jauh.", "Pastikan peralatan kecemasan dan pemadam api lengkap dan masih sah untuk digunakan.", "Anggap mencukupi jika pernah digunakan sebelum ini.", "Periksa selepas memulakan perjalanan."]', 
    1, 
    'Ensure emergency and fire equipment is complete and valid before driving.', 
    'Pastikan peralatan kecemasan dan pemadam api lengkap dan masih sah untuk digunakan sebelum memandu.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '587cee60-3269-48d2-97c3-bfc024822177', 
    'You are dressing for your driving shift.', 
    'Anda sedang berpakaian untuk syif pemanduan.', 
    '["Wear long trousers as required.", "Wear shorts if the weather is hot.", "Wear track pants for comfort.", "Wear any trousers only when visiting customer sites."]', 
    '["Pakai seluar panjang seperti yang ditetapkan.", "Pakai seluar pendek jika cuaca panas.", "Pakai seluar trek untuk keselesaan.", "Pakai apa-apa seluar hanya apabila melawat tapak pelanggan."]', 
    0, 
    'Wear long trousers as part of required duty attire.', 
    'Pakai seluar panjang seperti yang ditetapkan semasa bertugas.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'e10a96bb-92a4-45f3-8465-0ec95eb35c94', 
    'As a driver, you must remain aware of the expiry and renewal dates of vehicle and operating documents.', 
    'Sebagai seorang pemandu, anda perlu peka terhadap tarikh tamat tempoh dan pembaharuan dokumen kenderaan serta operasi.', 
    '["Monitor the dates and arrange renewal before expiry.", "Wait for reminders from the office.", "Check the dates only during inspections.", "Rely on company personnel to identify expiry."]', 
    '["Pantau tarikh tersebut dan uruskan pembaharuan sebelum tamat tempoh.", "Tunggu peringatan daripada pejabat.", "Semak tarikh hanya semasa pemeriksaan.", "Bergantung kepada pegawai syarikat untuk mengenal pasti tarikh tamat tempoh."]', 
    0, 
    'Be aware of expiry dates and renew documents before they lapse.', 
    'Sentiasa peka terhadap tarikh tamat tempoh dan perbaharui dokumen sebelum tempoh sahnya berakhir.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '095d7070-61d2-4558-9894-10c262ea6659', 
    'While hauling an import container from the port, you notice a dent and scratches on the container wall.', 
    'Semasa membawa kontena import dari pelabuhan, anda mendapati terdapat kesan kemek dan calar pada dinding kontena.', 
    '["Record the damage in the gate pass before exiting the port.", "Inform operations after delivery.", "Record it only in the internal company form.", "Proceed since the seal is intact."]', 
    '["Rekodkan kerosakan pada gate pass sebelum keluar dari pelabuhan.", "Maklumkan bahagian operasi selepas penghantaran.", "Rekodkan hanya dalam borang dalaman syarikat.", "Teruskan perjalanan kerana seal masih dalam keadaan baik."]', 
    0, 
    'Record visible container damage in the gate pass before leaving the port.', 
    'Rekodkan sebarang kerosakan kontena yang kelihatan pada gate pass sebelum meninggalkan pelabuhan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'abc35cc3-990a-4600-b3cc-494fdc8bfd1e', 
    'Before exiting the port, you compare the container number in the EIR/gate pass with the customs form and delivery note.', 
    'Sebelum keluar dari pelabuhan, anda membandingkan nombor kontena dalam EIR atau gate pass dengan borang kastam dan nota penghantaran.', 
    '["Proceed if the container type looks correct.", "Ensure all documents show the same container number.", "Check the number only at delivery point.", "Rely on port staff verification."]', 
    '["Teruskan perjalanan jika jenis kontena kelihatan betul.", "Pastikan semua dokumen menunjukkan nombor kontena yang sama.", "Semak nombor hanya di lokasi penghantaran.", "Bergantung kepada pengesahan kakitangan pelabuhan."]', 
    1, 
    'Confirm container numbers match across all documents before exit.', 
    'Pastikan nombor kontena sepadan dalam semua dokumen sebelum keluar dari pelabuhan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '23df8b5e-8afc-4f35-99fb-b5dacb01034a', 
    'Before pulling a loaded export container, you inspect the seal.', 
    'Sebelum menarik kontena eksport yang telah dimuatkan, anda memeriksa seal.', 
    '["Ensure the container is sealed before departure.", "Proceed if the container door is locked.", "Seal it later at the port.", "Rely on warehouse staff confirmation."]', 
    '["Pastikan kontena telah dipasang seal sebelum bertolak.", "Teruskan perjalanan jika pintu kontena telah dikunci.", "Pasang seal kemudian apabila tiba di pelabuhan.", "Bergantung kepada pengesahan kakitangan gudang."]', 
    0, 
    'Ensure export containers are properly sealed before movement.', 
    'Pastikan kontena eksport dipasang seal dengan betul sebelum pergerakan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'c9d1f8ce-a614-466a-a7b0-d11b5e305f57', 
    'You are involved in a road collision.', 
    'Anda terlibat dalam pelanggaran jalan raya.', 
    '["Record the third party''s vehicle type and registration number.", "Record only the third party''s phone number.", "Take photos of the damage without recording vehicle details.", "Ask someone help to record the information for you."]', 
    '["Catat jenis kenderaan dan nombor pendaftaran pihak ketiga.", "Catat nombor telefon pihak ketiga sahaja.", "Ambil gambar kerosakan tanpa merekod butiran kenderaan.", "Minta pertolongan orang lain mencatat maklumat bagi pihak anda."]', 
    0, 
    'Record vehicle type and registration details.', 
    'Catat jenis kenderaan dan nombor pendaftaran dengan tepat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '8ef75150-9a33-4302-acb0-03553c7aed8e', 
    'A small fire starts near the engine compartment while parked.', 
    'Semasa parkir, kebakaran kecil bermula berhampiran ruang enjin.', 
    '["Use the ABC fire extinguisher if safe.", "Wait for others to assist before acting.", "Pour available water to reduce flames.", "Observe briefly before deciding."]', 
    '["Gunakan alat pemadam api jenis ABC jika keadaan selamat.", "Tunggu bantuan sebelum mengambil tindakan.", "Tuang air yang ada untuk mengurangkan api.", "Perhatikan keadaan seketika sebelum membuat keputusan."]', 
    0, 
    'Use the appropriate extinguisher if the fire is manageable.', 
    'Gunakan alat pemadam api yang sesuai jika kebakaran masih boleh dikawal dan keadaan selamat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    2, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '22081721-0696-4c8f-9375-c5166575fa09', 
    'You position your vehicle in a loading area where forklifts and pedestrians are moving.', 
    'Anda meletakkan kenderaan di kawasan pemunggahan di mana forklift dan pejalan kaki sedang bergerak.', 
    '["Move forward quickly before equipment approaches", "Position only when the area is clear of movement", "Continue moving slowly and watch for operator signals", "Stop close to the loading area to reduce walking"]', 
    '["Bergerak cepat ke hadapan sebelum peralatan menghampiri", "Letakkan kenderaan hanya apabila kawasan itu tiada pergerakan", "Terus bergerak perlahan sambil perhatikan isyarat pengendali", "Berhenti dekat kawasan pemunggahan untuk kurangkan berjalan"]', 
    1, 
    'Keep clear of active loading zones to reduce collision and injury risk.', 
    'Kekalkan jarak dari kawasan pemunggahan aktif untuk mengurangkan risiko pelanggaran dan kecederaan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '37faf974-8566-4787-bfdb-62f3116167db', 
    'You approach a busy junction. Traffic slows unevenly and vehicles from the side edge forward.', 
    'Anda menghampiri persimpangan sibuk. Trafik perlahan secara tidak sekata dan kenderaan dari sisi bergerak ke hadapan.', 
    '["Hold your lane and approach at reduced speed", "Shift slightly within your lane to improve visibility", "Edge closer to discourage other vehicles", "Maintain speed and react only if a vehicle enters"]', 
    '["Kekalkan lorong dan hampiri pada kelajuan rendah", "Bergerak sedikit dalam lorong untuk tingkatkan pandangan", "Bergerak lebih dekat untuk menghalang kenderaan lain", "Kekalkan kelajuan dan bertindak hanya jika kenderaan masuk"]', 
    0, 
    'Clear lane position and early speed control reduce conflict at junctions.', 
    'Kedudukan lorong yang jelas dan kawalan kelajuan awal mengurangkan konflik di persimpangan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '2c906578-43c8-48b3-a5b0-2fc1056a9a9f', 
    'You approach a checkpoint inside a facility. Vehicles queue unevenly and lanes split toward inspection points.', 
    'Anda menghampiri pusat pemeriksaan di dalam fasiliti. Kenderaan beratur tidak sekata dan lorong berpecah ke beberapa laluan pemeriksaan.', 
    '["Remain in your lane and wait for checkpoint direction", "Shift early to a less congested lane", "Move forward and adjust position near the checkpoint", "Follow the vehicle ahead if its lane clears faster"]', 
    '["Kekalkan lorong dan tunggu arahan pusat pemeriksaan", "Tukar awal ke lorong yang kurang sesak", "Bergerak ke hadapan dan sesuaikan kedudukan berhampiran pusat pemeriksaan", "Ikut kenderaan di hadapan jika lorongnya bergerak lebih cepat"]', 
    0, 
    'Remain orderly and wait for checkpoint direction in controlled zones.', 
    'Kekalkan pergerakan teratur dan tunggu arahan pusat pemeriksaan di kawasan kawalan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '74e5b994-2027-44de-a52b-04f0dc79f2c7', 
    'You need to reverse into a tight space in a site yard. Vehicles and equipment move nearby.', 
    'Anda perlu mengundur ke ruang sempit di kawasan tapak. Kenderaan dan jentera bergerak berhampiran.', 
    '["Stop and reverse only when space and visibility are clear", "Reverse slowly and adjust speed as conditions change", "Complete the manoeuvre to minimise disruption", "Follow nearby vehicles to guide your reversing speed"]', 
    '["Berhenti dan undur hanya apabila ruang dan pandangan jelas", "Undur perlahan dan sesuaikan kelajuan mengikut keadaan", "Selesaikan manuver untuk kurangkan gangguan kepada orang lain", "Ikut pergerakan kenderaan berhampiran untuk panduan kelajuan mengundur"]', 
    0, 
    'Confirm space and visibility before reversing in busy yards.', 
    'Pastikan ruang dan pandangan jelas sebelum mengundur di kawasan tapak sibuk.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '85ff7b12-4d49-4845-ba69-b08636114794', 
    'You approach a narrow access point inside a facility. Visibility is limited and vehicles may enter from the opposite direction.', 
    'Anda menghampiri laluan masuk sempit di dalam fasiliti. Pandangan terhad dan kenderaan mungkin masuk dari arah bertentangan.', 
    '["Slow early and wait until the access path is clear", "Continue forward cautiously and adjust if a vehicle appears", "Enter the access point to hold position", "Follow the vehicle ahead through the access"]', 
    '["Perlahankan kenderaan lebih awal dan tunggu sehingga laluan benar-benar jelas", "Terus bergerak dengan berhati-hati dan sesuaikan jika kenderaan muncul", "Masuk ke laluan untuk menunggu", "Ikut kenderaan di hadapan melalui laluan"]', 
    0, 
    'Slow early and confirm the path is clear before entering.', 
    'Perlahankan kenderaan lebih awal dan pastikan laluan jelas sebelum masuk.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'cbe8cab3-cf85-4ece-8d21-414a35ea8888', 
    'While driving, your phone receives a message and you are slightly above the speed limit.', 
    'Semasa memandu, telefon anda menerima mesej dan anda memandu sedikit melebihi had laju.', 
    '["Slow to the legal speed and ignore the message", "Maintain speed and quickly check the message", "Reduce speed slightly and read when traffic allows", "Keep speed steady and reply briefly"]', 
    '["Kurangkan kelajuan ke had yang dibenarkan dan abaikan mesej tersebut", "Kekalkan kelajuan dan periksa mesej dengan cepat", "Kurangkan sedikit kelajuan dan baca apabila keadaan sesuai", "Kekalkan kelajuan dan balas mesej secara ringkas"]', 
    0, 
    'Follow speed limits and avoid device use while driving.', 
    'Patuhi had laju dan elakkan penggunaan telefon semasa memandu.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'feb97c88-b844-4556-ac6c-ebc4d8c36b82', 
    'At a controlled checkpoint, valid credentials are required and one credential has expired.', 
    'Di pusat pemeriksaan kawalan, kelayakan yang sah diperlukan dan satu kelayakan telah tamat tempoh.', 
    '["Stop at the checkpoint and report the issue", "Proceed slowly and resolve it afterward", "Wait to see if access is granted without it", "Continue forward since monitoring appears light"]', 
    '["Berhenti di pusat pemeriksaan dan laporkan masalah tersebut", "Terus bergerak perlahan dan selesaikan kemudian", "Tunggu untuk melihat sama ada akses dibenarkan tanpa kelayakan", "Terus bergerak kerana pemantauan kelihatan kurang ketat"]', 
    0, 
    'Stop and meet credential requirements before proceeding.', 
    'Berhenti dan pastikan kelayakan dipenuhi sebelum meneruskan perjalanan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '6c100f03-8111-4fb1-ac49-075c258bb7ac', 
    'At a site with active loading operations, you step out of your vehicle in the loading area without a safety helmet.', 
    'Di tapak dengan operasi pemuatan aktif, anda keluar dari kenderaan di kawasan pemuatan tanpa topi keselamatan.', 
    '["Put on the required PPE and keep clear of loading", "Remain where you are and rely on operators", "Move quickly through the area to reduce time", "Wait for instructions before addressing PPE"]', 
    '["Pakai PPE yang diperlukan dan kekal jauh dari operasi pemuatan", "Kekal di tempat dan bergantung pada pengendali", "Bergerak cepat melalui kawasan itu untuk kurangkan masa", "Tunggu arahan dan kemudian pakai PPE"]', 
    0, 
    'Wear required PPE and keep clear of loading zones.', 
    'Pakai PPE yang diperlukan dan kekalkan jarak dari kawasan pemuatan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'd08263ca-e73a-4934-aa6e-e3705d2b0f21', 
    'While manoeuvring at low speed with a load, you feel the load shift and notice the vehicle is closer than expected to an obstacle.', 
    'Semasa membuat manuver pada kelajuan rendah dengan muatan, anda merasakan muatan bergerak dan menyedari kenderaan lebih dekat daripada jangkaan kepada halangan.', 
    '["Stop and assess if it is safe to proceed", "Proceed slowly and adjust steering to maintain clearance", "Complete the manoeuvre and check the load afterward", "Continue moving and secure the load once clear"]', 
    '["Berhenti dan pastikan selamat sebelum meneruskan", "Terus bergerak perlahan dan laraskan stereng untuk kekalkan jarak", "Selesaikan manuver dan periksa muatan selepas itu", "Terus bergerak dan periksa di tempat perhentian"]', 
    0, 
    'Stop and reassess when load shift or clearance risk appears.', 
    'Berhenti dan nilai semula apabila muatan bergerak atau jarak menjadi sempit.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'e5c4b7c0-3ef1-4476-9473-fa0f1498a7d7', 
    'While parked at a public roadside stop, your engine is running near pedestrians and nearby premises.', 
    'Semasa parkir di tepi jalan awam, enjin kenderaan masih hidup berhampiran pejalan kaki dan premis berdekatan.', 
    '["Keep the engine running to maintain cabin comfort", "Shut down the engine while parked", "Keep the engine running and remain inside the vehicle", "Leave the engine running briefly before moving off"]', 
    '["Biarkan enjin hidup untuk keselesaan kabin", "Matikan enjin semasa parkir", "Biarkan enjin hidup dan kekal di dalam kenderaan", "Biarkan enjin hidup seketika sebelum bergerak"]', 
    1, 
    'Shutting down the engine when parked protects company assets and shows respect for the public.', 
    'Mematikan enjin semasa parkir melindungi aset syarikat dan menunjukkan hormat kepada orang awam.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'b52dba9d-26e7-4269-87ca-15ebb3b0499b', 
    'Inside a site, you approach a junction where parked equipment limits turning space.', 
    'Di dalam tapak, anda menghampiri simpang dan jentera parkir mengehadkan ruang membelok.', 
    '["Continue forward and adjust steering during the turn", "Stop early and reposition for a wider, safer turn", "Follow the shortest path to clear the junction", "Move closer before deciding how to turn"]', 
    '["Teruskan ke hadapan dan laras stereng semasa membelok", "Berhenti awal dan ubah posisi untuk belokan yang lebih luas dan selamat", "Ikut laluan paling pendek untuk lepasi simpang", "Bergerak lebih dekat sebelum tentukan cara membelok"]', 
    1, 
    'Early positioning inside sites prevents tight turns, damage, and unnecessary corrections.', 
    'Posisi awal yang betul di dalam tapak membantu elakkan belokan sempit, kerosakan dan pembetulan yang tidak perlu.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '6e8480ef-4285-429c-8e29-ae1b7bdc61db', 
    'While making a delivery, members of the public are nearby and watching your interaction with the customer.', 
    'Semasa membuat penghantaran, orang awam berada berdekatan dan memerhati interaksi anda dengan pelanggan.', 
    '["Focus only on the customer and ignore the surroundings", "Maintain calm, respectful behaviour mindful of the public presence", "Keep the exchange short to avoid attention", "Let the customer lead the interaction tone"]', 
    '["Fokus pada pelanggan sahaja dan abaikan keadaan sekeliling", "Kekalkan tingkah laku tenang dan hormat dengan mengambil kira kehadiran orang awam", "Pendekkan perbualan untuk elak perhatian", "Biarkan pelanggan tentukan nada interaksi"]', 
    1, 
    'Professional behaviour matters not only to the customer, but also to the public observing the interaction.', 
    'Tingkah laku profesional penting bukan sahaja kepada pelanggan tetapi juga kepada orang awam yang memerhati.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '885b5566-6980-463c-badd-7fa1bde20ca6', 
    'During a site discussion, you realise the conversation may be overheard or recorded.', 
    'Semasa perbincangan di tapak, anda sedar perbualan mungkin didengar atau dirakam.', 
    '["Speak carefully and keep the discussion professional", "Lower your voice and limit further discussion", "End the conversation and return to work", "Continue speaking as you normally would"]', 
    '["Bercakap dengan berhati-hati dan kekalkan profesionalisme", "Rendahkan suara dan hadkan perbincangan", "Tamatkan perbualan dan kembali bekerja", "Terus bercakap seperti biasa"]', 
    0, 
    'Choosing words carefully helps protect your professional image in visible situations.', 
    'Pilih kata dengan cermat untuk lindungi imej profesional di tempat umum.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '55acaecf-6c13-4e46-8137-44ef4d786be0', 
    'In a public area, people nearby are watching and filming while you interact with others.', 
    'Di kawasan awam, orang di sekeliling memerhati dan merakam semasa anda berinteraksi dengan orang lain.', 
    '["Keep your behaviour calm and professional throughout", "Explain your actions clearly so observers understand your position", "Limit interaction and focus on finishing the task", "Respond firmly to avoid appearing uncertain"]', 
    '["Kekalkan tingkah laku tenang dan profesional sepanjang masa", "Terangkan tindakan anda supaya orang yang memerhati faham", "Hadkan interaksi dan fokus selesaikan tugas", "Beri respons dengan tegas supaya tidak kelihatan ragu-ragu"]', 
    0, 
    'Professional behaviour matters most when actions are visible to the public.', 
    'Tingkah laku profesional amat penting apabila tindakan anda dapat dilihat oleh orang awam.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '6ae0f100-abfe-42e7-b329-00731c54357e', 
    'Traffic slows unexpectedly, and a supervisor asks if you can make up time on the road.', 
    'Trafik tiba-tiba menjadi perlahan dan penyelia bertanya sama ada anda boleh mengejar semula masa di jalan raya.', 
    '["Keep to a safe speed and give a clear, realistic update", "Say you will try to make up time where possible", "Reassure them and focus on pushing ahead", "Keep the call short and continue driving"]', 
    '["Kekalkan kelajuan selamat dan beri maklumat yang jelas serta realistik", "Beritahu bahawa anda akan cuba mengejar masa jika boleh", "Yakinkan penyelia dan fokus untuk bergerak lebih laju", "Pendekkan panggilan dan teruskan perjalanan"]', 
    0, 
    'Clear updates and safe driving help manage expectations without increasing risk.', 
    'Maklumat yang jelas dan pemanduan selamat membantu urus jangkaan tanpa menambah risiko.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '269f9e9c-55a5-4699-9fd8-2a9a39e80ad9', 
    'You increase following distance in slow traffic. The driver behind closes in and flashes headlights repeatedly.', 
    'Anda menambah jarak kenderaan dalam trafik perlahan. Pemandu di belakang merapat dan berulang kali memberi lampu tinggi.', 
    '["Keep your distance and continue without responding", "Ease closer to avoid further confrontation behind you", "Acknowledge the other driver briefly so they know you noticed", "Adjust your driving to discourage the behaviour"]', 
    '["Kekalkan jarak dan teruskan tanpa memberi respons", "Rapatkan sedikit jarak untuk mengelakkan ketegangan di belakang", "Beri isyarat ringkas supaya pemandu lain tahu anda sedar", "Sesuaikan cara pemanduan untuk menghalang tingkah laku tersebut"]', 
    0, 
    'Maintaining safe distance and not reacting helps prevent tension from escalating in traffic.', 
    'Mengekalkan jarak selamat dan tidak bertindak balas membantu mengelakkan ketegangan di jalan raya.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '9197e474-fd99-4d87-8a78-b1262eaaed39', 
    'You enter a narrow roadworks zone with barriers while members of the public are standing nearby.', 
    'Anda memasuki kawasan pembaikan jalan yang sempit dengan penghadang, sementara orang awam berada berhampiran.', 
    '["Reduce speed early and proceed cautiously", "Maintain speed to clear the zone quickly", "Follow the vehicle ahead closely to avoid delay", "Focus on steering accuracy and ignore people nearby"]', 
    '["Kurangkan kelajuan lebih awal dan lalui kawasan dengan berhati-hati", "Kekalkan kelajuan untuk melepasi kawasan dengan cepat", "Ikut rapat kenderaan di hadapan supaya tidak lewat", "Fokus pada kawalan stereng dan abaikan orang di sekitar"]', 
    0, 
    'Reducing speed early in high-risk areas helps protect the public and reduces potential harm.', 
    'Mengurangkan kelajuan lebih awal di kawasan berisiko membantu melindungi orang awam dan mengurangkan potensi bahaya.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '2314ad3a-ee3f-4218-8c8b-e71dce7c8caf', 
    'Before starting your shift, you notice dark tint film and stickers on part of the windscreen.', 
    'Sebelum memulakan syif, anda mendapati terdapat filem gelap dan pelekat pada sebahagian cermin hadapan.', 
    '["Leave them since they were already installed.", "Remove or report them because they may obstruct visibility.", "Start driving and adjust your seating position instead.", "Ignore them as long as the road ahead is visible."]', 
    '["Biarkan kerana ia telah dipasang sebelum ini.", "Tanggalkan atau laporkan kerana ia boleh menghalang penglihatan.", "Mulakan pemanduan dan laraskan kedudukan tempat duduk.", "Abaikan selagi jalan di hadapan masih kelihatan."]', 
    1, 
    'Address unauthorised modifications to protect visibility and vehicle safety.', 
    'Tangani pengubahsuaian tanpa kelulusan untuk menjaga penglihatan dan keselamatan kenderaan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'd1a785b7-1802-4ec2-a21c-60a50299a2f2', 
    'Your goods vehicle is experiencing failure on a highway and there is no nearby exit.', 
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan tiada susur keluar berhampiran.', 
    '["Stop in the current lane and switch on hazard lights.", "Move the vehicle to the far left shoulder before stopping.", "Stop immediately and place warning devices behind the vehicle.", "Slow down and remain in the lane until assistance arrives."]', 
    '["Berhenti di lorong semasa dan hidupkan lampu kecemasan.", "Gerakkan kenderaan ke bahu kiri paling luar sebelum berhenti.", "Berhenti serta-merta dan letakkan alat amaran di belakang kenderaan.", "Perlahankan kenderaan dan kekal di lorong sehingga bantuan tiba."]', 
    1, 
    'Move to a safer shoulder area to reduce exposure to traffic.', 
    'Gerakkan kenderaan ke bahu jalan yang lebih selamat untuk mengurangkan risiko terdedah kepada trafik.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'fa3f93f5-1f66-459e-a82b-7ff5050a530e', 
    'You are loading cargo and the total weight is close to the vehicle''s permitted limit.', 
    'Anda sedang memuatkan kargo dan jumlah beratnya hampir mencapai had yang dibenarkan untuk kenderaan.', 
    '["Load slightly above the limit if the distance is short.", "Ensure the load remains within the permitted weight limit.", "Proceed since the excess weight is minimal.", "Accept the customer''s weight figure without verification."]', 
    '["Muatkan sedikit melebihi had jika jarak adalah dekat.", "Pastikan muatan kekal dalam had berat yang dibenarkan.", "Teruskan perjalanan kerana lebihan berat adalah kecil.", "Terima angka berat pelanggan tanpa pengesahan."]', 
    1, 
    'Always operate within the approved weight limit.', 
    'Sentiasa pastikan kenderaan beroperasi dalam had berat yang diluluskan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '55ab7190-d1a9-4838-b0ed-f705ce61a5f4', 
    'You notice there is no compliant safety vest in the vehicle.', 
    'Anda mendapati tiada vest keselamatan yang mematuhi spesifikasi di dalam kenderaan.', 
    '["Proceed if you remain inside the vehicle.", "Ensure a compliant safety vest is available before departure.", "Wear any bright-coloured clothing instead.", "Borrow one only when entering a site."]', 
    '["Teruskan perjalanan jika anda kekal berada di dalam kenderaan.", "Pastikan vest keselamatan yang mematuhi spesifikasi tersedia sebelum memulakan perjalanan.", "Pakai sebarang pakaian berwarna terang sebagai ganti.", "Pinjam vest hanya apabila memasuki tapak."]', 
    1, 
    'Carry the required safety vest before operating.', 
    'Pastikan vest keselamatan yang diperlukan dibawa sebelum beroperasi.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '273cad41-3209-4df9-9aa0-fc2cce1393b9', 
    'You arrive at a site and the nearest space is marked as a prohibited parking area.', 
    'Anda tiba di tapak dan ruang terdekat ditanda sebagai kawasan larangan parkir.', 
    '["Park there briefly if unloading is quick.", "Find a permitted parking space.", "Park there if other vehicles are doing the same.", "Stop there with hazard lights switched on."]', 
    '["Parkir seketika jika proses menurunkan muatan adalah cepat.", "Cari ruang parkir yang dibenarkan.", "Parkir di situ jika kenderaan lain melakukan perkara yang sama.", "Berhenti di situ dengan lampu kecemasan dihidupkan."]', 
    1, 
    'Do not park in prohibited areas.', 
    'Parkir hanya di kawasan yang dibenarkan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '7230386d-7bc2-469e-9781-0c7bcc62f1d3', 
    'Before starting duty, you are choosing your footwear.', 
    'Sebelum memulakan tugas, anda memilih kasut untuk dipakai.', 
    '["Wear covered shoes for duty.", "Wear slippers for short-distance trips.", "Wear sandals if driving locally.", "Change into shoes only when entering a site."]', 
    '["Pakai kasut bertutup semasa bertugas.", "Pakai selipar untuk perjalanan jarak dekat.", "Pakai sandal jika memandu di kawasan setempat.", "Tukar kepada kasut hanya apabila memasuki tapak."]', 
    0, 
    'Wear proper shoes while on duty.', 
    'Pakai kasut yang sesuai semasa bertugas.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'a9dd3767-e09b-451e-a577-014affec24bc', 
    'You have completed a delivery at a customer site.', 
    'Anda telah menyelesaikan penghantaran di tapak pelanggan.', 
    '["Obtain the receiver''s signature only.", "Obtain signature, company stamp, time received, and receiver''s name.", "Take a photo of the unloaded goods as proof.", "Record the delivery details after returning to the office."]', 
    '["Dapatkan tandatangan penerima sahaja.", "Dapatkan tandatangan, cap syarikat, masa terima dan nama penerima.", "Ambil gambar barang yang telah diturunkan sebagai bukti.", "Rekodkan butiran penghantaran selepas kembali ke pejabat."]', 
    1, 
    'Ensure full and proper customer confirmation for every delivery.', 
    'Pastikan pengesahan penerimaan lengkap bagi setiap penghantaran.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '8735ff8e-9f6a-486c-8701-e8e06bb9f44d', 
    'Before exiting the port with an import container, you observe a small hole and cut mark.', 
    'Sebelum keluar dari pelabuhan dengan kontena import, anda mendapati terdapat lubang kecil dan kesan potongan pada kontena.', 
    '["Record the condition in the gate pass.", "Deliver first and report later.", "Ignore it if cargo is not exposed.", "Inform the customer upon arrival."]', 
    '["Rekodkan keadaan tersebut pada gate pass.", "Hantar dahulu dan laporkan kemudian.", "Abaikan jika muatan tidak terdedah.", "Maklumkan kepada pelanggan apabila tiba."]', 
    0, 
    'Declare any container damage in the gate pass before departure.', 
    'Isytiharkan sebarang kerosakan kontena pada gate pass sebelum berlepas.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '8bdd7de1-aa1a-4096-b687-0ed64d407437', 
    'Before exiting the port, you notice the container number differs in one document.', 
    'Sebelum keluar dari pelabuhan, anda mendapati nombor kontena berbeza pada satu dokumen.', 
    '["Exit and clarify after leaving the port.", "Stop, report to operations, and wait for instruction.", "Amend the document yourself.", "Proceed if the seal number matches."]', 
    '["Keluar dahulu dan jelaskan selepas meninggalkan pelabuhan.", "Berhenti, laporkan kepada bahagian operasi dan tunggu arahan lanjut.", "Pinda dokumen sendiri.", "Teruskan jika nombor seal sepadan."]', 
    1, 
    'Do not exit the port when container numbers mismatch.', 
    'Jangan keluar dari pelabuhan apabila nombor kontena tidak sepadan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'a637229b-e45d-4c4f-81e1-d2ca678829c5', 
    'Before departure, you find that the export container has no seal.', 
    'Sebelum bertolak, anda mendapati kontena eksport tersebut tidak mempunyai seal.', 
    '["Install any available seal and proceed.", "Inform operations and wait for instruction.", "Proceed since cargo is already loaded.", "Seal it yourself without reporting."]', 
    '["Pasang sebarang seal yang ada dan teruskan perjalanan.", "Maklumkan kepada bahagian operasi dan tunggu arahan lanjut.", "Teruskan perjalanan kerana muatan telah dimuatkan.", "Pasang seal sendiri tanpa membuat sebarang laporan."]', 
    1, 
    'Report missing seals before moving an export container.', 
    'Laporkan ketiadaan seal sebelum menggerakkan atau membawa kontena.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'a0878aa4-8119-4927-a265-73a7f3a85088', 
    'After a collision, you are gathering information from the other driver.', 
    'Selepas pelanggaran, anda mengumpul maklumat daripada pemandu lain.', 
    '["Take the driver''s contact number and identification details.", "Record only the vehicle number.", "Ask them to contact your office directly.", "Leave once traffic clears."]', 
    '["Ambil nombor telefon dan butiran pengenalan pemandu tersebut.", "Catat nombor pendaftaran kenderaan sahaja.", "Minta mereka hubungi pejabat anda secara terus.", "Beredar apabila trafik kembali lancar."]', 
    0, 
    'Obtain necessary contact and identification details.', 
    'Dapatkan nombor telefon dan butiran pengenalan yang diperlukan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'fad193b6-7ca6-4a32-8393-725bb10305e6', 
    'A fire on your vehicle becomes large and difficult to control.', 
    'Kebakaran pada kenderaan anda menjadi besar dan sukar dikawal.', 
    '["Contact the fire brigade immediately.", "Continue using the extinguisher repeatedly.", "Wait for operations to arrive first.", "Move the vehicle slightly before deciding."]', 
    '["Hubungi pasukan bomba dengan segera.", "Terus gunakan alat pemadam api berulang kali.", "Tunggu bahagian operasi tiba dahulu.", "Gerakkan kendaraan sedikit sebelum membuat keputusan."]', 
    0, 
    'Contact fire brigade when the fire escalates.', 
    'Hubungi bomba apabila kebakaran menjadi besar dan tidak terkawal.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    3, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '8702b149-ecce-4b5d-9795-6bd17e3b0482', 
    'You approach a site entrance from a public road. The access lane is narrow and partially obstructed.', 
    'Anda menghampiri pintu masuk tapak dari jalan awam. Laluan masuk sempit dan sebahagiannya terhalang.', 
    '["Maintain speed to avoid blocking traffic behind", "Slow early and proceed when the path is clear", "Move closer to assess space before stopping", "Enter the access lane and adjust position inside"]', 
    '["Kekalkan kelajuan untuk elakkan menghalang trafik di belakang", "Perlahankan awal dan masuk apabila laluan jelas", "Bergerak lebih dekat untuk menilai ruang sebelum berhenti", "Masuk ke laluan dan laraskan kedudukan di dalam"]', 
    1, 
    'Slow early and confirm the path is clear before entering a constrained access point.', 
    'Perlahankan kenderaan lebih awal dan pastikan laluan jelas sebelum memasuki laluan sempit.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '21815692-00e3-4983-8ceb-40c480a051a3', 
    'You drive at night in heavy rain on a downhill road. Visibility is reduced and vehicles ahead slow unpredictably.', 
    'Anda memandu pada waktu malam dalam hujan lebat di jalan menurun. Pandangan terhad dan kenderaan di hadapan memperlahankan secara tidak menentu.', 
    '["Reduce speed early for higher risk conditions", "Maintain speed and rely on headlights and braking", "Slow slightly and adjust if visibility worsens", "Keep pace with the vehicle ahead"]', 
    '["Kurangkan kelajuan lebih awal kerana keadaan berisiko tinggi", "Kekalkan kelajuan dan bergantung pada lampu serta brek", "Perlahankan sedikit dan sesuaikan kelajuan jika pandangan semakin terhad", "Ikut kelajuan kenderaan di hadapan"]', 
    0, 
    'Reduce speed in poor visibility to maintain control.', 
    'Kurangkan kelajuan apabila pandangan terhad untuk kekalkan kawalan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '2db27510-c121-44ea-941a-6e98c9fd7150', 
    'You arrive at a customer site. Access lanes are narrow and forklifts operate near the loading area.', 
    'Anda tiba di tapak pelanggan. Laluan masuk sempit dan forklift beroperasi berhampiran kawasan pemuatan.', 
    '["Hold back until access is clearly available", "Move forward slowly to secure a position near loading", "Approach while keeping visible to site staff", "Continue advancing to avoid delaying loading"]', 
    '["Tunggu di luar sehingga laluan benar-benar jelas", "Bergerak perlahan untuk mendapatkan kedudukan berhampiran kawasan pemuatan", "Hampiri kawasan tersebut dengan memastikan anda kelihatan oleh pekerja tapak", "Terus bergerak untuk elakkan kelewatan proses pemuatan."]', 
    0, 
    'Keep distance from constrained access and active loading areas.', 
    'Kekalkan jarak dari laluan sempit dan kawasan loading aktif.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '66050215-6bdf-4a21-810a-99ef1f073079', 
    'You drive inside a facility. Vehicles queue ahead and forklifts operate near the roadway.', 
    'Anda memandu di dalam kawasan fasiliti. Kenderaan beratur di hadapan dan forklift beroperasi berhampiran laluan.', 
    '["Increase following distance and keep clear sight", "Maintain spacing and close the gap if traffic slows", "Reduce the gap to avoid blocking vehicles behind", "Match the distance used by surrounding vehicles"]', 
    '["Tambah jarak kenderaan dan kekalkan pandangan jelas", "Kekalkan jarak dan rapatkan jika trafik perlahan", "Rapatkan jarak untuk elakkan menghalang kenderaan di belakang", "Ikut jarak yang digunakan oleh kenderaan sekeliling"]', 
    0, 
    'Maintain extra spacing and clear sight near operating equipment.', 
    'Kekalkan jarak tambahan dan pandangan jelas berhampiran jentera beroperasi.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'f6c93424-b85b-4780-9131-7b0c16d7eb24', 
    'You approach a busy site exit joining a public road. Space is tight and reversing may be needed to realign.', 
    'Anda menghampiri pintu keluar tapak yang bersambung dengan jalan awam. Ruang sempit dan mungkin perlu mengundur untuk melaras kedudukan.', 
    '["Edge forward to secure position and adjust if needed", "Stop, assess, and reverse slowly under control", "Use the horn and continue moving", "Reverse quickly before vehicles arrive"]', 
    '["Bergerak sedikit ke hadapan untuk mendapatkan kedudukan", "Berhenti, nilai keadaan, dan undur perlahan dengan kawalan", "Gunakan hon dan terus bergerak", "Undur dengan cepat sebelum kenderaan tiba"]', 
    1, 
    'Stop and maintain full control before reversing near junctions.', 
    'Berhenti dan kekalkan kawalan penuh sebelum mengundur berhampiran persimpangan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '5dae66fd-19da-499d-af7c-839a160b25a1', 
    'After a delivery, you find a required document was not completed according to company procedure.', 
    'Selepas selesai penghantaran, anda mendapati dokumen yang diperlukan tidak dilengkapkan mengikut prosedur syarikat.', 
    '["Complete and correct the document before closing the job", "Leave it since the delivery is already done", "Make a brief note and update it later if needed", "Proceed to the next task and rely on existing records"]', 
    '["Lengkapkan dan betulkan dokumen sebelum menyelesaikan tugasan", "Biarkan sahaja kerana penghantaran sudah selesai", "Buat catatan ringkas dan kemas kini kemudian jika perlu", "Teruskan ke tugasan seterusnya dan bergantung pada rekod sedia ada"]', 
    0, 
    'Complete documents correctly to maintain procedural compliance.', 
    'Lengkapkan dokumen dengan betul memastikan pematuhan terhadap prosedur.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '567e03b6-3fe1-41f5-88c4-2c6bd00eb0f2', 
    'Feeling unusually tired due to insufficient rest, you are about to enter a site with narrow internal lanes.', 
    'Anda berasa amat letih kerana kurang rehat dan akan memasuki tapak dengan laluan dalaman sempit.', 
    '["Delay site entry to take a short rest", "Enter carefully and rely on slow speed", "Proceed since the site is familiar", "Enter and take breaks after the manoeuvre"]', 
    '["Tangguhkan kemasukan ke tapak untuk berehat seketika", "Masuk dengan berhati-hati dan bergantung pada kelajuan rendah", "Teruskan kerana tapak tersebut sudah biasa", "Masuk dan berehat selepas selesai manuver"]', 
    0, 
    'Address fatigue before entering confined areas.', 
    'Atasi keletihan sebelum memasuki kawasan sempit.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '7a41a9e3-ef71-4742-8f42-5c0bc6979187', 
    'While waiting inside a site, an emergency alarm sounds and vehicles are directed to clear the area. Your engine is running.', 
    'Semasa menunggu di dalam tapak, penggera kecemasan berbunyi dan kenderaan diarahkan mengosongkan kawasan. Enjin anda masih hidup.', 
    '["Follow evacuation instructions and stop the engine when safe", "Keep the engine running and leave quickly", "Wait for clarification before acting", "Continue idling until site personnel approach"]', 
    '["Ikut arahan pemindahan dan matikan enjin apabila selamat", "Kekalkan enjin hidup dan keluar dengan cepat", "Tunggu penjelasan lanjut sebelum bertindak", "Terus hidupkan enjin sehingga kakitangan tapak datang"]', 
    0, 
    'Follow evacuation instructions and manage the vehicle safely.', 
    'Ikut arahan pemindahan dan kendalikan kenderaan dengan selamat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '42bf8fe1-23e2-4c6a-bb29-d88d75ea98db', 
    'You arrive at a customer premise and are told unloading will take longer than expected. The vehicle is parked safely.', 
    'Anda tiba di tempat pelanggan dan dimaklumkan proses memunggah keluar akan mengambil masa lebih lama daripada jangkaan. Kenderaan telah diparkir dengan selamat.', 
    '["Switch off the engine while waiting", "Keep the engine running to be ready to move", "Rev the engine occasionally", "Leave the engine idling and monitor the situation"]', 
    '["Matikan enjin semasa menunggu", "Biarkan enjin hidup untuk bersedia bergerak", "Tekan minyak sekali-sekala", "Biarkan enjin melahu sambil memantau keadaan"]', 
    0, 
    'Switch off the engine during long waiting periods.', 
    'Matikan enjin semasa menunggu lama untuk mengelakkan pembaziran bahan api.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'ac5cca8b-0424-4081-bbec-a6acba32f5ce', 
    'While driving, you notice unusual vibration and a new mechanical noise from the vehicle.', 
    'Semasa memandu, anda merasakan getaran tidak normal dan bunyi mekanikal baharu daripada kenderaan.', 
    '["Continue driving and observe if the noise disappears", "Stop safely and report the issue clearly to the supervisor", "Reduce speed and complete the trip as planned", "Mention the issue during the next scheduled check"]', 
    '["Teruskan memandu dan lihat sama ada bunyi itu hilang", "Berhenti di tempat selamat dan laporkan masalah kepada penyelia", "Kurangkan kelajuan dan teruskan perjalanan seperti dirancang", "Nyatakan masalah semasa pemeriksaan seterusnya"]', 
    1, 
    'Early detection and clear reporting help prevent minor issues from becoming safety risks.', 
    'Pengesanan awal dan laporan yang jelas membantu mengelakkan masalah kecil menjadi risiko keselamatan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'a1e18080-e7e2-4cb6-9f05-9ebe2fb91a34', 
    'At a site checkpoint, you notice a vehicle defect just before being cleared to proceed.', 
    'Di checkpoint tapak, anda perasan ada kerosakan pada kenderaan sejurus sebelum dibenarkan bergerak.', 
    '["Proceed through the checkpoint and report the defect afterwards", "Stop at the checkpoint and report the defect immediately", "Move past the checkpoint and assess the defect inside", "Request guidance while remaining in the queue"]', 
    '["Terus melepasi checkpoint dan laporkan kerosakan kemudian", "Berhenti di checkpoint dan laporkan kerosakan segera", "Lepasi checkpoint dan periksa kerosakan di dalam", "Minta panduan sambil kekal dalam barisan"]', 
    1, 
    'Reporting defects at checkpoints prevents unsafe entry into controlled zones.', 
    'Laporkan kerosakan sebelum bergerak untuk elakkan risiko semasa masuk atau keluar kawasan terkawal.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '5a63cc9e-81e0-4626-b0d6-bbed8dfeb396', 
    'A staff member at the delivery premise hints that a small personal favour could speed up your delivery process.', 
    'Seorang pekerja di tempat pelanggan mencadangkan bahawa bantuan peribadi kecil boleh mempercepatkan proses penghantaran.', 
    '["Decline politely and follow standard procedures", "Accept the request to maintain good customer relations", "Delay the decision and see how the situation develops", "Refer the matter to another driver on site"]', 
    '["Tolak dengan sopan dan ikut prosedur biasa", "Terima permintaan itu untuk jaga hubungan pelanggan", "Tangguhkan keputusan dan lihat perkembangan keadaan", "Rujuk perkara itu kepada pemandu lain di tapak"]', 
    0, 
    'Following standard procedures protects fairness and avoids improper influence.', 
    'Mengikut prosedur biasa membantu kekalkan keadilan dan elakkan pengaruh yang tidak wajar.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '746002f5-d9d5-4d94-b433-225229fe16a6', 
    'After a delivery, you notice the recorded details do not fully match what occurred.', 
    'Selepas penghantaran, anda mendapati butiran yang direkod tidak sepenuhnya sepadan dengan apa yang berlaku.', 
    '["Clarify the discrepancy and update the records accurately", "Leave the records unchanged to avoid reopening the discussion", "Add brief notes later so the paperwork roughly reflects events", "Ask someone else to adjust the documents if needed"]', 
    '["Jelaskan perbezaan dan kemas kini rekod dengan tepat", "Biarkan rekod seperti itu untuk elakkan perbincangan dibuka semula", "Tambah catatan ringkas kemudian supaya dokumen lebih kurang mencerminkan keadaan sebenar", "Minta orang lain mengubah dokumen jika perlu"]', 
    0, 
    'Correct records promptly to ensure accuracy and prevent misunderstandings.', 
    'Betulkan rekod dengan segera untuk memastikan ketepatan dan mengelakkan salah faham.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '3d3697da-cb43-42a2-973f-44f5af626475', 
    'After unloading in a public street, a nearby shop owner asks you to record a shorter stop time to avoid complaints.', 
    'Selepas memunggah muatan di tepi jalan awam, seorang pemilik kedai meminta anda merekod masa berhenti yang lebih singkat untuk elakkan aduan.', 
    '["Record the actual stop time and submit the document as required", "Shorten the recorded time since unloading is already completed", "Leave the timing unclear so it does not attract attention", "Explain the situation verbally and minimise what is written"]', 
    '["Catat masa berhenti sebenar dan serahkan dokumen seperti dikehendaki", "Pendekkan masa yang direkod kerana proses memunggah sudah selesai", "Biarkan catatan masa tidak jelas supaya tidak menarik perhatian", "Jelaskan secara lisan dan kurangkan maklumat bertulis"]', 
    0, 
    'Accurate records uphold accountability, even when there is public pressure.', 
    'Catatan yang tepat membantu kekalkan tanggungjawab walaupun ada tekanan dari luar.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '95e4fa51-6e43-495c-8421-e9100432b113', 
    'You are driving through a residential area where pedestrians are present and traffic is light.', 
    'Anda memandu melalui kawasan perumahan dengan kehadiran pejalan kaki dan trafik yang ringan.', 
    '["Maintain an appropriate speed and remain mindful of people nearby", "Drive slightly faster to clear the area quickly", "Match the flow of traffic and continue as usual", "Focus on the road ahead and avoid reacting to bystanders"]', 
    '["Kekalkan kelajuan yang sesuai dan peka terhadap orang di sekeliling", "Pandu sedikit lebih laju untuk keluar dari kawasan itu dengan cepat", "Ikut aliran trafik dan teruskan seperti biasa", "Fokus ke hadapan dan abaikan pergerakan orang di tepi jalan"]', 
    0, 
    'Reducing speed in residential areas shows consideration for pedestrian safety.', 
    'Mengurangkan kelajuan di kawasan perumahan menunjukkan keprihatinan terhadap keselamatan pejalan kaki.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '540d4810-a241-4e78-b7a7-c7cfae4fea00', 
    'You intend to change lanes, but another driver in your blind spot appears unsure of your intention.', 
    'Anda bercadang untuk menukar lorong, namun pemandu di titik buta kelihatan tidak pasti tentang niat anda.', 
    '["Signal early and wait until the other driver responds before moving", "Drift slightly to indicate intention and move when space appears", "Check mirrors again and change lanes once traffic slows", "Hold position and change lanes later without signalling"]', 
    '["Beri isyarat awal dan tunggu sehingga diberi ruang", "Hanyut sedikit ke sisi untuk menunjukkan niat dan masuk apabila ada ruang", "Periksa cermin sekali lagi dan tukar lorong apabila trafik menjadi perlahan", "Kekalkan kedudukan dan tukar lorong kemudian tanpa memberi isyarat"]', 
    0, 
    'Clear signalling helps other drivers understand your intention and reduces uncertainty during lane changes.', 
    'Isyarat yang jelas membantu pemandu lain memahami niat anda dan mengurangkan ketidakpastian semasa menukar lorong.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '2497afba-7c6e-467f-9f5d-eff9a08c3102', 
    'Another driver cuts in suddenly, forcing you to brake, then begins gesturing angrily at you.', 
    'Seorang pemandu memotong masuk secara tiba-tiba sehingga anda terpaksa membrek, kemudian menunjukkan isyarat marah kepada anda.', 
    '["Regain composure and continue driving without reacting", "Respond briefly to show you were affected by the move", "Accelerate to move away from the situation", "Slow further to signal your frustration"]', 
    '["Tenangkan diri dan teruskan pemanduan tanpa memberi respons", "Beri respons ringkas untuk menunjukkan anda terkesan", "Tambah kelajuan untuk menjauhkan diri daripada situasi", "Perlahankan lagi kenderaan sebagai tanda tidak puas hati"]', 
    0, 
    'Maintaining composure and not reacting helps prevent aggressive situations from escalating.', 
    'Mengekalkan ketenangan dan tidak bertindak balas membantu mengelakkan situasi agresif daripada menjadi lebih tegang.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '2c55ff9a-93c6-4263-bb96-0c87f256005d', 
    'You plan to install a sun shade, dark tint film, or stickers on the company truck windscreen.', 
    'Anda bercadang memasang pelindung matahari, filem gelap, atau pelekat pada cermin hadapan lori syarikat.', 
    '["Install them if they do not block the main driving view.", "Do not install them without company approval.", "Use removable shades only during daytime driving.", "Check whether other drivers have done similar modifications."]', 
    '["Pasang jika tidak menghalang pandangan utama ketika memandu.", "Jangan pasang tanpa kelulusan syarikat.", "Gunakan pelindung yang boleh ditanggalkan pada waktu siang sahaja.", "Periksa sama ada pemandu lain pernah membuat pengubahsuaian yang sama."]', 
    1, 
    'Avoid unauthorised vehicle modifications that may affect safety or compliance.', 
    'Elakkan pengubahsuaian pada kenderaan tanpa kelulusan yang boleh menjejaskan keselamatan atau pematuhan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'a1953a32-6f7a-4a5c-ad78-d0f20e5544c6', 
    'Your goods vehicle is experiencing failure on a highway and you have stopped on the left shoulder.', 
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda telah berhenti di bahu jalan sebelah kiri.', 
    '["Remain inside and assess the situation first.", "Switch on the hazard lights immediately.", "Call your supervisor before taking further action.", "Step out briefly to check approaching traffic."]', 
    '["Kekal di dalam kenderaan dan nilai keadaan terlebih dahulu.", "Hidupkan lampu kecemasan dengan segera.", "Hubungi penyelia sebelum mengambil tindakan lanjut.", "Keluar sebentar untuk memeriksa trafik yang menghampiri."]', 
    1, 
    'Activate hazard lights promptly to alert approaching traffic.', 
    'Hidupkan lampu kecemasan segera untuk memberi amaran kepada pengguna jalan lain.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '26e9c789-57c2-46c4-a3b1-648318eff1da', 
    'Your vehicle is due for scheduled maintenance according to the company/manufacturer''s manual.', 
    'Kenderaan anda telah tiba masa menjalani penyelenggaraan berjadual mengikut manual syarikat atau pengeluar.', 
    '["Continue operating since the vehicle is running smoothly.", "Follow the scheduled maintenance requirement.", "Postpone the service until the next trip cycle.", "Wait for further confirmation before arranging service."]', 
    '["Terus beroperasi kerana kenderaan masih berfungsi dengan baik.", "Patuhi keperluan penyelenggaraan berjadual.", "Tangguhkan servis sehingga kitaran perjalanan seterusnya.", "Tunggu pengesahan lanjut sebelum mengaturkan servis."]', 
    1, 
    'Follow the company/manufacturer''s maintenance schedule as required.', 
    'Patuhi jadual penyelenggaraan yang ditetapkan oleh syarikat atau pengeluar.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'e0c70ff9-ee2e-4696-84f0-a4195ac33d3b', 
    'You are involved in a minor incident during vehicle operation.', 
    'Anda terlibat dalam satu insiden kecil semasa mengendalikan kenderaan.', 
    '["Report the incident within 2 hours as required.", "Report it at the end of the workday.", "Report only if damage is visible.", "Wait until instructed before reporting."]', 
    '["Laporkan insiden dalam tempoh 2 jam seperti yang ditetapkan.", "Laporkan pada akhir hari kerja.", "Laporkan hanya jika terdapat kerosakan yang dapat dilihat.", "Tunggu arahan sebelum membuat laporan."]', 
    0, 
    'Report accidents or incidents within the required reporting timeframe.', 
    'Laporkan kemalangan atau insiden dalam tempoh masa pelaporan yang ditetapkan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'e9093f5b-e02c-4b1e-a12c-6782ba54cf1e', 
    'You are about to start driving the vehicle.', 
    'Anda hendak memulakan pemanduan kenderaan.', 
    '["Fasten the seat belt before moving.", "Drive first and fasten it later.", "Wear it only on highways.", "Use it only when carrying heavy cargo."]', 
    '["Pakai tali pinggang keledar sebelum bergerak.", "Mula memandu dan pakai kemudian.", "Pakai hanya di lebuh raya.", "Pakai hanya apabila membawa muatan berat."]', 
    0, 
    'Always wear the seat belt before driving.', 
    'Pakai tali pinggang keledar sebelum memandu.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'd3c0251b-1ca1-443f-85b7-a375f2951c32', 
    'You are reporting for duty after several weeks without a haircut.', 
    'Anda melapor diri untuk bertugas selepas beberapa minggu tanpa memotong rambut.', 
    '["Maintain short and neat hair as required.", "Keep long hair if tied properly.", "Trim only when reminded by HR.", "Maintain appearance only for inspections."]', 
    '["Pastikan rambut sentiasa pendek dan kemas seperti yang ditetapkan.", "Simpan rambut panjang asalkan diikat dengan kemas.", "Potong rambut hanya apabila diingatkan oleh pihak sumber manusia (HR).", "Jaga penampilan hanya semasa pemeriksaan dijalankan."]', 
    0, 
    'Maintain neat and appropriate grooming for duty.', 
    'Kekalkan penampilan yang kemas dan sesuai semasa bertugas.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'c0143f85-1442-459d-96dc-f554cbc382d7', 
    'You arrive at a delivery location and notice the address differs from the delivery note.', 
    'Anda tiba di lokasi penghantaran dan mendapati alamat berbeza daripada yang tertera pada nota penghantaran.', 
    '["Deliver to the new address if the customer confirms verbally.", "Contact operations for confirmation before proceeding.", "Deliver if the location is nearby.", "Leave the goods with the person present at the site."]', 
    '["Hantar ke alamat baharu jika pelanggan mengesahkan secara lisan.", "Hubungi bahagian operasi untuk pengesahan sebelum meneruskan penghantaran.", "Hantar jika lokasi berhampiran.", "Tinggalkan barang kepada individu yang berada di tapak."]', 
    1, 
    'Verify address changes with operations before delivery.', 
    'Sahkan sebarang perubahan alamat dengan bahagian operasi sebelum membuat penghantaran.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '585c7229-fa4d-470e-929b-ecf380a5d470', 
    'You notice a crack, repair mark, and slight bulging on an import container panel.', 
    'Anda mendapati terdapat rekahan, kesan pembaikan dan sedikit bonjolan pada panel sebuah kontena import.', 
    '["Record the condition in the gate pass.", "Proceed if the door locks properly.", "Report only if damage worsens.", "Assume it was previously declared."]', 
    '["Rekodkan keadaan tersebut pada gate pass.", "Teruskan perjalanan jika pintu boleh dikunci dengan baik.", "Laporkan hanya jika kerosakan menjadi lebih teruk.", "Anggap keadaan tersebut telah diisytiharkan sebelum ini."]', 
    0, 
    'Record abnormal container conditions in the gate pass.', 
    'Rekodkan sebarang keadaan kontena yang tidak normal pada gate pass sebelum bertolak/meneruskan perjalanan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'e0a0690f-63f2-4150-aaf6-77237024638d', 
    'Before moving the container, you inspect the seal.', 
    'Sebelum menggerakkan kontena, anda memeriksa seal.', 
    '["Ensure the seal is intact and secured.", "Proceed if the container door is locked.", "Check the seal only at delivery point.", "Rely on previous documentation."]', 
    '["Pastikan seal dalam keadaan baik dan dikunci dengan betul.", "Teruskan perjalanan jika pintu kontena telah dikunci.", "Periksa seal hanya di lokasi penghantaran.", "Bergantung kepada dokumentasi terdahulu."]', 
    0, 
    'Ensure the container seal is intact before movement.', 
    'Pastikan seal dalam keadaan baik sebelum menggerakkan kontena.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '5bb584f4-5020-4d47-a87c-87a0c07c47b7', 
    'After confirming the seal on a loaded export container, what should you do next?', 
    'Selepas mengesahkan seal pada kontena eksport yang telah dimuatkan, apakah tindakan seterusnya?', 
    '["Inform operations of the seal number.", "Proceed directly to the port.", "Record it only in your trip log.", "Provide the seal number at delivery."]', 
    '["Maklumkan nombor seal kepada bahagian operasi.", "Terus bergerak ke pelabuhan.", "Rekodkan nombor seal hanya dalam log perjalanan sahaja.", "Berikan nombor seal semasa penghantaran."]', 
    0, 
    'Inform operations of the seal number for system update.', 
    'Maklumkan nombor seal kepada bahagian operasi untuk kemas kini sistem.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'cbd09fd7-2ebe-439d-8d07-410377a8b158', 
    'Following a collision, what photographic evidence should you collect?', 
    'Selepas pelanggaran, bukti gambar apakah yang perlu anda ambil?', 
    '["Photos of the scene and vehicles involved.", "Only your own vehicle damage.", "A photo after vehicles are moved.", "No photos if witnesses are present."]', 
    '["Gambar lokasi kejadian dan kenderaan yang terlibat.", "Gambar kerosakan kenderaan anda sahaja.", "Gambar selepas kenderaan dialihkan.", "Tidak perlu ambil gambar jika ada saksi."]', 
    0, 
    'Take clear photos of the accident scene and vehicles.', 
    'Ambil gambar yang jelas bagi lokasi kejadian dan kenderaan yang terlibat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'b4a91be7-0133-4f48-bd6e-2329b8a8e435', 
    'After a road accident, the Emergency Response Team contacts you.', 
    'Selepas kemalangan jalan raya, Pasukan Tindak Balas Kecemasan menghubungi anda.', 
    '["Provide clear details of what happened, time, location, and vehicles involved.", "Inform them only that an accident occurred.", "Ask them to obtain details from witnesses.", "Provide information after returning to depot."]', 
    '["Berikan maklumat jelas tentang apa yang berlaku, masa, lokasi dan kenderaan yang terlibat.", "Maklumkan bahawa kemalangan telah berlaku sahaja.", "Minta mereka mendapatkan maklumat daripada saksi.", "Berikan maklumat selepas kembali ke depot."]', 
    0, 
    'Provide clear and accurate accident details immediately.', 
    'Berikan maklumat kemalangan yang jelas dan tepat dengan segera.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    4, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '6b764036-f466-47f9-a512-50d03b631aab', 
    'You drive inside a terminal lane where RTG lifting and yard vehicles are moving.', 
    'Anda memandu di laluan terminal di mana RTG beroperasi dan kenderaan yard sedang bergerak.', 
    '["Maintain speed and pass while watching the RTG", "Reduce speed early and pass cautiously", "Continue at moderate speed and adjust if equipment moves closer", "Slow slightly but keep moving to avoid delaying traffic"]', 
    '["Kekalkan kelajuan dan lalu sambil memerhati RTG", "Kurangkan kelajuan lebih awal dan lalu dengan berhati-hati", "Teruskan pada kelajuan sederhana dan laras jika RTG menghampiri", "Perlahankan sedikit tetapi terus bergerak untuk elakkan kelewatan trafik"]', 
    1, 
    'Reduce speed early near lifting activity to manage sudden equipment movement safely.', 
    'Kurangkan kelajuan lebih awal berhampiran aktiviti jentera untuk mengendalikan pergerakan jentera secara selamat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'd80b4f72-4c7c-44c9-9c0f-1fb9d06d6b16', 
    'You drive in slow traffic. A driver cuts in and brakes sharply.', 
    'Anda memandu dalam trafik perlahan. Seorang pemandu memotong masuk dan membrek secara mengejut.', 
    '["Reduce speed smoothly and keep a safe pace", "Maintain speed to avoid being pushed back", "Slow briefly, then speed up to create space", "Adjust speed after traffic settles"]', 
    '["Kurangkan kelajuan secara lancar dan kekalkan kelajuan selamat", "Kekalkan kelajuan untuk mengelak daripada didorong ke belakang.", "Perlahankan seketika kemudian tambah kelajuan untuk mewujudkan ruang di hadapan", "Sesuaikan kelajuan selepas trafik kembali stabil"]', 
    0, 
    'Calm speed control prevents impulsive reactions in frustrating traffic.', 
    'Kawalan kelajuan yang tenang membantu mengelakkan tindak balas impulsif dalam trafik.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.5, "discipline": 0.25, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'c4450a1f-7b4f-4009-bd2b-87da2df8de63', 
    'You are in an active loading area during heavy rain. Surfaces are wet and equipment operates nearby.', 
    'Anda berada di kawasan pemuatan aktif semasa hujan lebat. Permukaan basah dan jentera beroperasi berhampiran.', 
    '["Stay clear of the loading area until conditions stabilise", "Proceed carefully while adjusting pace for the weather", "Move closer to monitor equipment movement", "Continue approaching so loading can proceed"]', 
    '["Kekal jauh dari kawasan pemuatan sehingga keadaan stabil", "Teruskan dengan berhati-hati sambil laraskan kelajuan", "Bergerak lebih dekat untuk memantau pergerakan jentera", "Terus menghampiri supaya proses pemuatan boleh diteruskan"]', 
    0, 
    'Keep clear of loading activity when weather increases risk.', 
    'Kekalkan jarak dari aktiviti pemuatan apabila keadaan cuaca meningkatkan risiko.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'fb5de7cf-9159-4770-9c0e-4ac1354ebeab', 
    'You move from an internal roadway toward a loading area. Obstructions and movement change around you.', 
    'Anda bergerak dari laluan dalaman menuju kawasan pemunggahan. Halangan dan pergerakan berubah di sekeliling.', 
    '["Slow early and adjust your path to surrounding movement", "Maintain pace and react when a hazard appears", "Focus on the path ahead and reassess inside", "Follow vehicles ahead that pass smoothly"]', 
    '["Perlahankan kenderaan lebih awal dan sesuaikan laluan mengikut pergerakan sekitar", "Kekalkan kelajuan dan bertindak apabila bahaya muncul", "Fokus pada laluan di hadapan dan nilai semula selepas masuk", "Ikut kenderaan di hadapan yang melalui kawasan dengan lancar"]', 
    0, 
    'Anticipate early and adjust space to avoid sudden reactions.', 
    'Jangka lebih awal dan sesuaikan ruang untuk elakkan tindak balas mengejut.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '35b8f2fd-ac5c-466e-9061-4b84f815cacb', 
    'At a security checkpoint, the vehicle ahead is being cleared and the guard signals you to move closer.', 
    'Di pusat pemeriksaan keselamatan, kenderaan di hadapan sedang diperiksa dan pengawal memberi isyarat supaya anda bergerak lebih dekat.', 
    '["Close the gap to speed up clearance", "Keep a safe following distance", "Stop directly behind the vehicle", "Move slowly and rely on the guard to manage spacing"]', 
    '["Rapatkan jarak untuk mempercepatkan pemeriksaan", "Kekalkan jarak selamat dengan kenderaan di hadapan", "Berhenti tepat di belakang kenderaan", "Bergerak perlahan dan bergantung pada pengawal untuk mengawal jarak"]', 
    1, 
    'Checkpoint instructions do not replace safe spacing.', 
    'Arahan pusat pemeriksaan tidak menggantikan disiplin jarak selamat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'c3c9fddd-4b29-4af7-a4db-0232304a8426', 
    'After a delivery, you are stopped for inspection and asked to present your documents. One document was completed late but is accurate.', 
    'Selepas penghantaran, anda ditahan untuk pemeriksaan dan diminta menunjukkan dokumen. Satu dokumen dilengkapkan lewat tetapi maklumatnya tepat.', 
    '["Present the documents and clarify the late entry", "Hand over the documents without mentioning the late entry", "Say the document was completed earlier", "Offer to update the document later"]', 
    '["Tunjukkan dokumen dan jelaskan tentang pengisian lewat", "Serahkan dokumen tanpa memaklumkan tentang kelewatan pengisian", "Nyatakan bahawa dokumen telah dilengkapkan lebih awal", "Tawarkan untuk mengemas kini dokumen kemudian"]', 
    0, 
    'Present accurate documents and clarify issues during inspections.', 
    'Tunjukkan dokumen yang tepat dan jelaskan perkara berkaitan semasa pemeriksaan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'b79ec7ff-137c-4d91-943e-78f117f1a519', 
    'While driving inside a site, you see a posted speed limit.', 
    'Semasa memandu di dalam tapak, anda melihat had laju yang dipaparkan.', 
    '["Adjust speed to comply with the posted limit", "Maintain current speed since traffic is light", "Reduce speed slightly but continue comfortably", "Match the speed of other vehicles"]', 
    '["Laraskan kelajuan untuk mematuhi had laju yang dipaparkan", "Kekalkan kelajuan kerana trafik ringan", "Kurangkan kelajuan sedikit tetapi teruskan dengan selesa", "Ikut kelajuan kenderaan lain"]', 
    0, 
    'Follow posted speed limits inside operational sites.', 
    'Patuhi had laju yang ditetapkan di dalam kawasan operasi.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '6fa3ab1c-6b4e-4b4b-a20e-e0379b9ed768', 
    'After a pre-trip inspection, you feel an unusual vibration while driving.', 
    'Selepas pemeriksaan sebelum perjalanan, anda merasakan getaran tidak biasa semasa memandu.', 
    '["Stop and recheck the vehicle before continuing", "Continue driving since the inspection showed no problems", "Complete the trip and report it at the end of the shift", "Ignore it unless a warning indicator appears"]', 
    '["Berhenti dan periksa semula kenderaan", "Terus memandu kerana pemeriksaan awalan dibuat", "Selesaikan perjalanan dan laporkan pada akhir syif", "Abaikan kecuali lampu amaran muncul"]', 
    0, 
    'Unusual vehicle behaviour requires immediate checking.', 
    'Perubahan mekanikal kenderaan perlu diperiksa segera.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '4600c3ca-94d8-499a-9c1a-d9278302bf04', 
    'At the end of your shift, the vehicle cabin is cluttered with items.', 
    'Pada akhir syif, kabin kenderaan berselerak dengan barang.', 
    '["Tidy the cabin and leave it ready for the next driver", "Leave the cabin since the shift has ended", "Remove personal items and clean it the next shift", "Clean only if the next driver is known"]', 
    '["Kemas kabin dan sediakan untuk pemandu seterusnya", "Biarkan kabin kerana syif telah tamat", "Ambil barang peribadi dan kemakan kabin keesokan hari", "Bersihkan hanya jika pemandu seterusnya dikenali"]', 
    0, 
    'Leave the cabin orderly for the next user or the next shift', 
    'Tinggalkan kabin dalam keadaan kemas untuk pengguna seterusnya.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '263994c0-bf02-449f-8054-ec7ee983160a', 
    'Before departure, you identify a cargo safety concern while another party pressures you to move immediately.', 
    'Sebelum berlepas, anda mengenal pasti isu keselamatan muatan sementara pihak lain mendesak anda bergerak segera.', 
    '["Proceed carefully to avoid further discussion", "Address the safety concern and explain the delay calmly", "Agree to move briefly to reduce tension", "Remain silent and delay action"]', 
    '["Teruskan dengan berhati-hati untuk elakkan perbincangan lanjut", "Tangani isu keselamatan muatan dan jelaskan kelewatan dengan tenang", "Setuju bergerak seketika untuk mengurangkan ketegangan", "Berdiam diri dan tangguhkan tindakan"]', 
    1, 
    'Address safety concerns first while responding calmly to others.', 
    'Utamakan keselamatan sambil bertindak balas dengan tenang kepada pihak lain.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '43ed8d83-c10b-41b6-a7ff-03636c1258b5', 
    'While reversing slowly inside a site, you notice steering response feels abnormal.', 
    'Semasa mengundur perlahan di dalam tapak, anda merasakan tindak balas stereng tidak normal.', 
    '["Continue reversing carefully to clear the area", "Stop the manoeuvre and assess the defect", "Complete the reverse and report afterward", "Reduce speed further and keep moving"]', 
    '["Terus mengundur dengan berhati-hati untuk lepasi kawasan itu", "Hentikan manuver dan periksa keadaan", "Selesaikan undur dan laporkan selepas itu", "Kurangkan lagi kelajuan dan teruskan bergerak"]', 
    1, 
    'Stopping immediately when a defect is felt during manoeuvres prevents damage and injury.', 
    'Hentikan kenderaan apabila terasa tanda tidak normal semasa manuver untuk elakkan kerosakan dan kecederaan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '1199a205-7a27-4da3-9a06-9018b6a023d7', 
    'A customer becomes verbally aggressive after being told the delivery cannot proceed as requested.', 
    'Seorang pelanggan bercakap secara agresif selepas dimaklumkan bahawa penghantaran tidak dapat diteruskan seperti diminta.', 
    '["Respond firmly to assert your position", "Stay calm, acknowledge concerns, and explain the situation clearly", "End the conversation and walk away", "Repeat company policy without further engagement"]', 
    '["Jawab dengan tegas untuk pertahankan pendirian", "Kekal tenang, dengar perkara yang dibangkitkan dan terangkan keadaan dengan jelas", "Tamatkan perbualan dan beredar", "Ulang dasar syarikat tanpa perbincangan lanjut"]', 
    1, 
    'Staying calm and acknowledging concerns helps prevent escalation and keeps the situation under control.', 
    'Kekal tenang dan beri penjelasan yang jelas membantu elakkan keadaan menjadi lebih tegang dan kekalkan kawalan situasi.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '4c7d857f-9dcf-4ca3-a55b-056ea62cbc4b', 
    'During unloading, a site worker suggests a small personal favour to speed up the process.', 
    'Semasa proses memunggah, seorang pekerja tapak mencadangkan bantuan peribadi kecil untuk mempercepatkan proses.', 
    '["Decline politely and continue unloading as required", "Agree briefly since it may help everyone finish faster", "Avoid responding directly and keep working to reduce attention", "Suggest handling the request later to keep things moving"]', 
    '["Tolak dengan sopan dan teruskan proses memunggah seperti dikehendaki", "Setuju seketika kerana ia mungkin mempercepatkan kerja", "Elakkan memberi respons secara langsung dan teruskan kerja", "Cadangkan urus perkara itu kemudian supaya kerja berjalan"]', 
    0, 
    'Declining improper requests helps maintain integrity and fair working practices.', 
    'Menolak permintaan yang tidak sesuai membantu kekalkan integriti dan amalan kerja yang adil.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'b29b0ae3-a1ef-40b4-bd51-92e695addf18', 
    'During a delivery discussion, someone becomes upset after you refuse an improper request.', 
    'Semasa perbincangan penghantaran, seseorang menjadi tidak puas hati selepas anda menolak permintaan yang tidak sesuai.', 
    '["Restate your position calmly and keep the discussion respectful", "Explain in detail why the request is wrong and unacceptable", "End the discussion abruptly to avoid further disagreement", "Respond firmly to make it clear the matter is closed"]', 
    '["Nyatakan semula pendirian anda dengan tenang dan kekalkan perbincangan secara hormat", "Terangkan dengan terperinci mengapa permintaan itu salah dan tidak boleh diterima", "Tamatkan perbincangan secara mendadak untuk elak pertelingkahan lanjut", "Beri respons dengan tegas supaya jelas perkara itu telah selesai"]', 
    0, 
    'Holding your position calmly helps resolve issues without escalating conflict.', 
    'Kekalkan pendirian dengan tenang untuk selesaikan isu tanpa meningkatkan ketegangan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'e5a2657a-a463-4153-af04-909c99103259', 
    'A driver behind you flashes headlights repeatedly and gestures, appearing impatient with your speed.', 
    'Seorang pemandu di belakang anda berulang kali memberi lampu tinggi dan membuat isyarat, kelihatan tidak sabar dengan kelajuan anda.', 
    '["Keep your speed steady and avoid responding to the behaviour", "Speed up slightly so the situation does not turn into an argument", "Change lanes when possible to prevent further confrontation", "React briefly to signal you have noticed the other driver"]', 
    '["Kekalkan kelajuan secara konsisten dan elakkan memberi respons", "Tambah sedikit kelajuan supaya keadaan tidak menjadi tegang", "Tukar lorong apabila selamat untuk mengelakkan konfrontasi", "Beri respons ringkas untuk menunjukkan anda sedar akan kehadirannya"]', 
    0, 
    'Maintaining steady driving and not reacting helps prevent conflicts from escalating.', 
    'Pemanduan yang stabil dan tidak bertindak balas membantu mengelakkan situasi daripada menjadi tegang.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '5d5d145f-4f6c-4303-8f71-edf57e66cf4f', 
    'You slow to turn near pedestrians, and nearby road users appear unsure of your intention.', 
    'Anda memperlahankan kenderaan untuk membelok berhampiran pejalan kaki, dan pengguna jalan lain kelihatan tidak pasti tentang niat anda.', 
    '["Signal early and make the turn carefully", "Slow further to see how others react", "Turn once there is space without signalling", "Edge forward slightly to show what you intend to do"]', 
    '["Beri isyarat awal dan belok secara cermat", "Perlahankan lagi untuk melihat reaksi orang lain", "Belok apabila ada ruang tanpa memberi isyarat", "Gerak sedikit ke hadapan untuk menunjukkan niat"]', 
    0, 
    'Early signalling helps pedestrians and other road users understand your intention and stay safe.', 
    'Isyarat awal membantu pejalan kaki dan pengguna jalan lain memahami niat anda dan kekal selamat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'dfac1e19-429e-4ec0-946a-520f2abe40bd', 
    'A vehicle cuts in sharply, making you angry. You need to change lanes while drivers around you are unsure of your intention.', 
    'Sebuah kenderaan memotong masuk secara mengejut sehingga anda berasa marah. Anda perlu menukar lorong ketika pemandu lain di sekitar tidak pasti tentang niat anda.', 
    '["Regain composure and signal clearly before changing lanes", "Change lanes quickly to get away from the situation", "Sound the horn briefly to express frustration", "Hold your lane without signalling until traffic settles"]', 
    '["Tenangkan diri dan beri isyarat dengan jelas sebelum menukar lorong", "Tukar lorong dengan cepat untuk menjauhkan diri daripada situasi", "Bunyi hon seketika untuk meluahkan rasa tidak puas hati", "Kekalkan lorong tanpa memberi isyarat sehingga trafik kembali stabil"]', 
    0, 
    'Clear signalling after regaining composure helps others understand your intentions and keeps traffic moving safely.', 
    'Isyarat yang jelas selepas menenangkan diri membantu pemandu lain memahami niat anda dan memastikan aliran trafik kekal selamat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'b604939d-2b1e-4fbc-a943-fb904b97bd6e', 
    'You have completed 8 hours of driving for the day and one nearby delivery remains.', 
    'Anda telah memandu selama 8 jam pada hari tersebut dan satu penghantaran berhampiran masih belum selesai.', 
    '["Continue driving to complete the final delivery.", "Stop driving and report reaching the daily limit.", "Drive for another 30 minutes before stopping.", "Reduce speed and complete the delivery carefully."]', 
    '["Terus memandu untuk menyelesaikan penghantaran terakhir.", "Hentikan pemanduan dan laporkan bahawa had harian telah dicapai.", "Memandu lagi selama 30 minit sebelum berhenti.", "Kurangkan kelajuan dan selesaikan penghantaran dengan berhati-hati."]', 
    1, 
    'Follow driving hour limits to maintain safety and compliance.', 
    'Patuhi had waktu pemanduan untuk menjaga keselamatan dan pematuhan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'e7da7be4-67d7-4056-be6e-cc7fea4d3751', 
    'Your goods vehicle is experiencing failure at night and you need to step out.', 
    'Kenderaan barangan anda mengalami kerosakan pada waktu malam dan anda perlu keluar dari kenderaan.', 
    '["Exit quickly to place warning devices.", "Wear a safety vest before exiting.", "Stand beside the vehicle and observe traffic.", "Use your phone light while walking behind the vehicle."]', 
    '["Keluar dengan segera untuk meletakkan alat amaran.", "Pakai jaket keselamatan sebelum keluar.", "Berdiri di sebelah kenderaan dan perhatikan trafik.", "Gunakan lampu telefon bimbit semasa berjalan di belakang kenderaan."]', 
    1, 
    'Ensure personal visibility before exiting to reduce roadside risk.', 
    'Pastikan anda mudah dilihat sebelum keluar bagi mengurangkan risiko di tepi jalan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '09faab9e-9ab3-46f3-9a0e-1601f66775fb', 
    'During inspection, you notice the fire extinguisher has passed its expiry date.', 
    'Semasa pemeriksaan, anda mendapati alat pemadam api telah melepasi tarikh luput.', 
    '["Keep using it since it has not been discharged.", "Replace it with a compliant 9kg extinguisher within validity.", "Replace it with a compliant 6kg extinguisher within validity.", "Replace it with a compliant 12kg extinguisher within validity."]', 
    '["Terus gunakan kerana ia belum pernah digunakan.", "Gantikan dengan alat pemadam api 9kg yang mematuhi spesifikasi dan masih dalam tempoh sah.", "Gantikan dengan alat pemadam api 6kg yang mematuhi spesifikasi dan masih dalam tempoh sah.", "Gantikan dengan alat pemadam api 12kg yang mematuhi spesifikasi dan masih dalam tempoh sah."]', 
    1, 
    'Ensure the required fire extinguisher meets the approved specification and validity.', 
    'Pastikan alat pemadam api yang diperlukan mematuhi spesifikasi dan tempoh sah yang ditetapkan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '40502916-1e6e-431d-8857-a51554fe2553', 
    'You are asked to modify the vehicle''s GPS tracking or speedometer settings.', 
    'Anda diminta untuk mengubah suai tetapan sistem GPS atau meter kelajuan kenderaan.', 
    '["Make the adjustment if it improves convenience.", "Refuse any modification that violates safety or company protocol.", "Adjust the settings temporarily and restore them later.", "Modify only if other drivers have done so."]', 
    '["Buat pelarasan jika ia memudahkan urusan.", "Tolak sebarang pengubahsuaian yang melanggar peraturan keselamatan atau prosedur syarikat.", "Ubah tetapan sementara dan pulihkan kemudian.", "Buat pengubahsuaian hanya jika pemandu lain pernah melakukannya."]', 
    1, 
    'Do not alter vehicle systems against safety rules or company protocol.', 
    'Jangan mengubah suai sistem kenderaan yang bertentangan dengan peraturan keselamatan atau prosedur syarikat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '879ff289-630f-4c2b-b399-34a2e35a1d9a', 
    'You are selected for a random blood and urine test during duty.', 
    'Anda dipilih untuk menjalani ujian darah dan air kencing secara rawak semasa bertugas.', 
    '["Cooperate and undergo the test as required.", "Request to postpone the test to another day.", "Refuse the test because it is unlawful.", "Agree only if other drivers are tested first."]', 
    '["Berikan kerjasama dan jalani ujian tersebut seperti yang dikehendaki.", "Minta supaya ujian ditangguhkan ke hari lain.", "Tolak ujian tersebut kerana ia tidak sah di sisi undang-undang.", "Bersetuju hanya jika pemandu lain diuji terlebih dahulu."]', 
    0, 
    'Comply with random substance testing as required.', 
    'Patuhi ujian saringan bahan terlarang secara rawak seperti yang ditetapkan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'a6778a3b-8aeb-44f3-a4e5-d8913a5c21cb', 
    'You are starting your work shift for the day.', 
    'Anda memulakan syif kerja pada hari tersebut.', 
    '["Record your attendance at the end of the shift.", "Record your attendance at the beginning and end of the shift.", "Inform your supervisor.", "Record attendance only when requested."]', 
    '["Rekodkan kehadiran pada akhir syif.", "Rekodkan kehadiran pada awal dan akhir syif.", "Maklumkan kepada penyelia.", "Rekodkan kehadiran hanya apabila diminta."]', 
    1, 
    'Record attendance properly at the start and end of duty.', 
    'Rekod kehadiran dengan betul pada awal dan akhir tugas.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'b90c073f-0ccf-470e-bd0b-f02ee7a9670b', 
    'Before departing with a container, you notice visible damage on its exterior.', 
    'Anda akan bertolak dengan sebuah kontena namun mendapati terdapat kerosakan yang jelas pada bahagian luarnya.', 
    '["Proceed since the container is already sealed.", "Record the damage in the required document.", "Inform the customer verbally and continue.", "Proceed if the cargo inside appears intact."]', 
    '["Teruskan perjalanan kerana kontena telah dimeterai.", "Rekodkan kerosakan dalam dokumen yang diperlukan.", "Maklumkan pelanggan secara lisan dan teruskan perjalanan.", "Teruskan jika muatan di dalam kelihatan baik."]', 
    1, 
    'Record any container damage before proceeding.', 
    'Rekodkan sebarang kerosakan kontena sebelum meneruskan perjalanan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '046248de-7a81-48f2-9b71-cae3d099ddf7', 
    'While inspecting a reefer import container, you notice the power cable appears damaged.', 
    'Semasa memeriksa kontena import berpendingin, anda mendapati kabel kuasa kelihatan rosak.', 
    '["Record the issue in the gate pass before exiting.", "Continue if temperature display is normal.", "Inform operations after delivery.", "Secure it temporarily and proceed."]', 
    '["Catat isu tersebut pada gate pass sebelum keluar.", "Teruskan perjalanan jika paparan suhu normal.", "Maklumkan kepada bahagian operasi selepas penghantaran.", "Ikat sementara dan teruskan perjalanan."]', 
    0, 
    'Record any reefer equipment damage in the gate pass before departure.', 
    'Catat sebarang kerosakan peralatan kontena import berpendingin pada gate pass sebelum berlepas.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '6e74a6a0-b6ad-4950-b3d5-a480850226b9', 
    'Before departure, you notice there is no seal on the container.', 
    'Sebelum bertolak, anda mendapati tiada seal pada kontena.', 
    '["Install any available seal and continue.", "Report to operations and wait for instruction.", "Proceed if the cargo appears secured.", "Inform the customer after delivery."]', 
    '["Pasang mana-mana seal yang ada dan teruskan perjalanan.", "Laporkan kepada bahagian operasi dan tunggu arahan lanjut.", "Teruskan perjalanan jika muatan kelihatan selamat.", "Maklumkan kepada pelanggan selepas penghantaran."]', 
    1, 
    'Report missing seals before moving the container.', 
    'Laporkan seal yang tiada sebelum menggerakkan kontena.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '8e7313dc-6463-4d89-8844-22b7494f71cf', 
    'You are hauling a loaded export container to the designated port.', 
    'Anda sedang membawa kontena eksport yang telah dimuatkan ke pelabuhan yang ditetapkan.', 
    '["Drive directly to the port without unnecessary stops.", "Stop briefly for personal errands.", "Park overnight and continue the next day.", "Divert to another site before heading to port."]', 
    '["Pandu terus ke pelabuhan tanpa membuat hentian yang tidak perlu.", "Berhenti seketika untuk urusan peribadi.", "Parkir semalaman dan sambung perjalanan pada hari berikutnya.", "Singgah ke tapak lain sebelum ke pelabuhan."]', 
    0, 
    'Haul export containers directly to the designated port unless emergency arises.', 
    'Bawa kontena eksport terus ke pelabuhan yang ditetapkan kecuali berlaku kecemasan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'd91b2984-0ba9-46f1-9039-9b5ae2fbc1e9', 
    'After ensuring safety at the accident scene, what should you do next?', 
    'Selepas memastikan keselamatan di lokasi kemalangan, apakah tindakan seterusnya?', 
    '["Report immediately to office.", "Complete delivery first and report later.", "Wait until returning to depot.", "Inform only if damage is serious."]', 
    '["Laporkan segera kepada pejabat.", "Selesaikan penghantaran dahulu dan laporkan kemudian.", "Tunggu sehingga kembali ke depot.", "Maklumkan hanya jika kerosakan adalah serius."]', 
    0, 
    'Report the incident immediately and await instruction.', 
    'Laporkan kejadian segera dan tunggu arahan lanjut.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'd41f7731-16fc-4306-9deb-d6462eeb2445', 
    'After a collision, operations asks for your location.', 
    'Selepas pelanggaran, bahagian operasi meminta lokasi anda.', 
    '["Provide the exact location using junctions or landmarks.", "Say you are \"near the highway\".", "Share the location after police arrival.", "Wait for GPS tracking to update automatically."]', 
    '["Berikan lokasi tepat dengan menyatakan simpang atau mercu tanda.", "Berikan anggaran lokasi berdasarkan kawasan sekitar.", "Kongsi lokasi selepas polis tiba.", "Tunggu sistem GPS dikemas kini secara automatik."]', 
    0, 
    'Provide precise accident location details.', 
    'Berikan butiran lokasi kemalangan dengan tepat dan jelas.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    5, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '81d76b4f-c305-4ec6-9230-1dafca13c408', 
    'You drive in steady multi-lane traffic. Motorcycles filter between lanes and traffic slows near an exit.', 
    'Anda memandu dalam trafik berbilang lorong yang lancar. Motosikal bergerak di antara lorong dan trafik perlahan berhampiran susur keluar.', 
    '["Maintain lane position and prepare for sudden movement", "Change lanes early to avoid slowing traffic", "Hold lane but move closer to the lane marking", "Continue normally and react only if traffic slows"]', 
    '["Kekalkan kedudukan lorong dan bersedia untuk pergerakan mengejut", "Tukar lorong lebih awal untuk mengelakkan trafik perlahan", "Kekalkan lorong tetapi bergerak lebih dekat ke garisan lorong", "Teruskan seperti biasa dan bertindak hanya jika trafik perlahan"]', 
    0, 
    'Maintain stable lane position and anticipate sudden movement.', 
    'Kekalkan kedudukan lorong yang stabil dan jangka pergerakan mengejut.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '60c185a0-599a-491d-b6ab-69dc6ab78df1', 
    'You follow a slow vehicle on a busy road. Traffic flows on the adjacent lane.', 
    'Anda mengekori kenderaan perlahan di jalan sibuk. Trafik bergerak di lorong sebelah.', 
    '["Wait for a clear safe gap before overtaking", "Overtake quickly to avoid staying behind", "Move closer to signal your intent", "Begin overtaking and adjust as traffic responds"]', 
    '["Tunggu ruang yang benar-benar selamat sebelum memotong", "Memotong dengan cepat supaya tidak terus terperangkap", "Bergerak lebih dekat untuk memberi isyarat niat", "Mulakan memotong dan sesuaikan kedudukan mengikut trafik"]', 
    0, 
    'Manage frustration and wait for a clear safe gap before overtaking.', 
    'Kawal rasa marah dan tunggu ruang yang benar-benar selamat sebelum memotong.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '760fc45e-c4ae-4a29-abbc-4c3b4fbe6c7c', 
    'You are inside a terminal yard. A marshal signals you to hold while equipment moves in your path.', 
    'Anda berada di dalam kawasan terminal. Seorang marshal memberi isyarat supaya berhenti sementara jentera bergerak di laluan anda.', 
    '["Remain stationary until the marshal signals to proceed", "Ease forward slightly to improve visibility", "Hold briefly, then advance once equipment clears", "Follow the vehicle ahead if it begins moving"]', 
    '["Kekal berhenti sehingga marshal memberi isyarat untuk bergerak", "Bergerak sedikit ke hadapan untuk meningkatkan jarak penglihatan", "Berhenti seketika kemudian bergerak apabila jentera beredar", "Ikut kenderaan di hadapan jika ia mula bergerak"]', 
    0, 
    'Follow marshal instructions and keep distance from operating equipment.', 
    'Patuhi arahan marshal dan kekalkan jarak daripada jentera yang sedang beroperasi.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'a01ea827-f472-4a82-ae8b-00e3375652be', 
    'You approach a junction inside an industrial site. Internal lanes intersect and site rules require vehicles to yield.', 
    'Anda menghampiri persimpangan di dalam kawasan industri. Laluan dalaman bersilang dan peraturan tapak memerlukan kenderaan memberi laluan.', 
    '["Slow down and follow the site junction rule", "Roll forward and proceed when the path looks clear", "Edge into the junction to signal intention", "Enter if nearby vehicles move through safely"]', 
    '["Perlahankan kenderaan dan ikut peraturan persimpangan tapak", "Bergerak perlahan dan masuk apabila laluan kelihatan jelas", "Masuk sedikit ke persimpangan untuk memberi isyarat niat", "Masuk jika kenderaan berhampiran kelihatan melalui dengan selamat"]', 
    0, 
    'Apply site junction rules to prevent conflicts at internal intersections.', 
    'Patuhi peraturan persimpangan tapak untuk mengelakkan konflik di persimpangan dalaman.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'd2e223e2-14be-46e7-8ebd-bdbcad6eb4c9', 
    'You drive inside a container terminal. RTGs and reach stackers operate nearby and containers restrict visibility.', 
    'Anda memandu di dalam terminal kontena. RTG dan reach stacker beroperasi berhampiran dan kontena menghadkan pandangan.', 
    '["Reduce speed early and proceed cautiously", "Maintain normal speed and rely on operators to yield", "Accelerate briefly to clear the area", "Match the speed of nearby terminal vehicles"]', 
    '["Kurangkan kelajuan lebih awal dan teruskan dengan berhati-hati", "Kekalkan kelajuan biasa dan bergantung pada pengendali untuk memberi laluan", "Tambah kelajuan seketika untuk melepasi kawasan itu", "Ikut kelajuan kenderaan terminal berhampiran"]', 
    0, 
    'Reduce speed near operating terminal equipment.', 
    'Kurangkan kelajuan berhampiran jentera terminal yang beroperasi.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '55978549-82bd-4c9f-9776-7a5fb77c5b41', 
    'During a roadside inspection, an officer approaches and you realise you are not wearing a safety vest.', 
    'Semasa pemeriksaan di tepi jalan, seorang pegawai menghampiri dan anda sedar anda tidak memakai vest keselamatan.', 
    '["Put on the safety vest and cooperate with the inspection", "Continue the inspection and wear it if instructed", "Answer the officer''s questions and address it later", "Remain where you are until the inspection ends"]', 
    '["Pakai vest keselamatan dan beri kerjasama semasa pemeriksaan", "Teruskan pemeriksaan dan pakai jika diarahkan", "Jawab soalan pegawai dan uruskan kemudian", "Kekal di tempat anda sehingga pemeriksaan selesai"]', 
    0, 
    'Wear required safety equipment during inspections.', 
    'Pakai peralatan keselamatan yang diperlukan semasa pemeriksaan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '8c1af03b-7c6d-41b9-882b-cda9265bb91b', 
    'While driving inside a site, you encounter uneven surfaces and hazards along the route. You are within the speed limit.', 
    'Semasa memandu di dalam tapak, anda menghadapi permukaan tidak rata dan bahaya di laluan. Anda masih dalam had laju dibenarkan.', 
    '["Reduce speed to suit the hazards", "Maintain speed since it is within the limit", "Adjust speed only near visible obstacles", "Continue at normal speed and rely on steering"]', 
    '["Kurangkan kelajuan mengikut keadaan", "Kekalkan kelajuan kerana masih dalam had laju", "Sesuaikan kelajuan hanya berhampiran halangan yang jelas", "Teruskan pada kelajuan biasa dan bergantung pada kawalan stereng"]', 
    0, 
    'Adjust speed to suit conditions even within the limit.', 
    'Sesuaikan kelajuan mengikut keadaan walaupun masih dalam had laju.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '9aefa98c-926c-438c-9c4b-b5aedca6e541', 
    'After a pre-trip inspection, the vehicle behaves differently once you begin moving.', 
    'Selepas pemeriksaan sebelum perjalanan, kenderaan menunjukkan keadaan tidak biasa apabila anda mula bergerak.', 
    '["Continue driving to see if it settles", "Stop safely and reassess the vehicle", "Adjust driving style to compensate", "Complete the trip and report later"]', 
    '["Terus memandu untuk melihat sama ada keadaan kembali normal", "Berhenti dengan selamat dan periksa semula kenderaan", "Laraskan cara pemanduan untuk menyesuaikan keadaan", "Selesaikan perjalanan dan laporkan kemudian"]', 
    1, 
    'Vehicle behaviour should match inspection results.', 
    'Jika kenderaan menunjukkan keadaan tidak biasa, berhenti dan periksa semula sebelum meneruskan perjalanan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '51ec3a28-4c4a-4860-b738-58849a9e26d4', 
    'While preparing for delivery, you notice the cargo is not fully secured and the customer is waiting.', 
    'Semasa bersedia untuk penghantaran, anda mendapati muatan tidak dikunci dengan sempurna dan pelanggan sedang menunggu.', 
    '["Pause and secure the cargo before proceeding", "Continue carefully and address it afterward", "Proceed to avoid delay and handle carefully", "Proceed while explaining the situation to the customer"]', 
    '["Berhenti seketika dan pastikan muatan dikunci dengan betul sebelum meneruskan", "Teruskan dengan berhati-hati dan selesaikan isu kemudian", "Teruskan untuk mengelakkan kelewatan dan kendalikan dengan berhati-hati", "Teruskan sambil menerangkan keadaan kepada pelanggan"]', 
    0, 
    'Secure cargo before delivery despite time pressure.', 
    'Pastikan muatan selamat sebelum meneruskan penghantaran walaupun terdapat tekanan masa.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '8323574e-014e-4162-90c9-b76353fecb31', 
    'Before entering an industrial site, you have not completed the required pre-trip inspection.', 
    'Sebelum memasuki tapak industri, anda belum melengkapkan pemeriksaan pra-perjalanan kenderaan.', 
    '["Enter the site carefully and complete checks later", "Complete the inspection and follow site entry rules", "Rely on previous checks and proceed as directed", "Ask site staff to guide you inside immediately"]', 
    '["Masuk ke tapak dengan berhati-hati dan lakukan pemeriksaan kemudian", "Lengkapkan pemeriksaan dan patuhi peraturan kemasukan tapak", "Bergantung pada pemeriksaan sebelumnya dan teruskan seperti diarahkan", "Minta kakitangan tapak membimbing anda masuk segera"]', 
    1, 
    'Complete inspections before site entry to ensure readiness and compliance.', 
    'Lengkapkan pemeriksaan sebelum memasuki tapak untuk memastikan kesiapsiagaan dan pematuhan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'b20663bf-eab1-46a0-9fd2-d958b6dee125', 
    'While waiting inside a confined site area, the vehicle is idling near structures and pedestrians.', 
    'Semasa menunggu di kawasan tapak yang sempit, enjin masih hidup berhampiran struktur dan pejalan kaki.', 
    '["Keep the engine idling so you can move off quickly", "Switch off the engine while waiting", "Keep idling until instructed to move", "Remain stationary with the engine running"]', 
    '["Biarkan enjin hidup supaya boleh bergerak segera", "Matikan enjin semasa menunggu", "Terus biarkan enjin hidup sehingga diarahkan bergerak", "Kekal berhenti dengan enjin masih hidup"]', 
    1, 
    'Switching off the engine when stationary reduces risk and unnecessary exposure in confined areas.', 
    'Matikan enjin semasa berhenti untuk kurangkan risiko dan pendedahan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'c7133712-d373-47c7-8487-c3333b2201d2', 
    'During a delivery, a customer begins recording your interaction on a mobile phone.', 
    'Semasa penghantaran, seorang pelanggan mula merakam interaksi anda menggunakan telefon bimbit.', 
    '["Continue the discussion calm and professional", "Ask the customer to stop recording before continuing", "Keep responses brief and focus on completing the task", "Proceed with the delivery without acknowledging the recording"]', 
    '["Teruskan perbincangan dengan tenang dan profesional", "Minta pelanggan berhenti merakam sebelum meneruskan", "Jawab secara ringkas dan fokus untuk selesaikan tugas", "Teruskan penghantaran tanpa mengendahkan rakaman"]', 
    0, 
    'Maintaining professional behaviour protects your image when interactions are visible or recorded.', 
    'Kekalkan tingkah laku profesional apabila interaksi dirakam atau dilihat orang lain.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '46b3a672-3123-4d24-a9a0-f2e865ca9ca6', 
    'During unloading, a disagreement with site staff begins to escalate over the unloading sequence.', 
    'Semasa proses memunggah, berlaku perbezaan pendapat dengan kakitangan tapak mengenai turutan memunggah muatan dan keadaan mula menjadi tegang.', 
    '["Pause briefly, acknowledge the concern, and suggest resolving it calmly", "Explain in detail why your unloading sequence is correct and safer", "Continue unloading quietly to avoid making the situation worse", "Justify your approach so everyone understands your reasoning"]', 
    '["Berhenti seketika dan bincang dengan tenang", "Terangkan dengan panjang lebar mengapa turutan anda lebih betul dan selamat", "Teruskan proses memunggah secara senyap untuk elak keadaan menjadi lebih tegang", "Pertahankan cara anda supaya semua faham sebabnya"]', 
    0, 
    'Pausing and responding calmly helps defuse tension.', 
    'Berhenti seketika dan beri respons dengan tenang membantu redakan ketegangan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '2ec8edaf-b3f8-4f06-ad3b-7a58de0041fa', 
    'After unloading, someone pressures you to change delivery records so the issue does not escalate.', 
    'Selepas proses memunggah, seseorang menekan anda supaya mengubah rekod penghantaran agar isu tersebut tidak menjadi lebih besar.', 
    '["Say the records must stay as they are and continue calmly", "Change the records slightly so the discussion can end", "Leave the records for now to avoid further disagreement", "Explain repeatedly why the records cannot be changed"]', 
    '["Nyatakan rekod mesti kekal seperti sedia ada dan teruskan dengan tenang", "Ubah sedikit rekod supaya perbincangan boleh dihentikan", "Biarkan rekod dahulu untuk elak pertelingkahan lanjut", "Terangkan berulang kali mengapa rekod tidak boleh diubah"]', 
    0, 
    'Keeping records accurate while staying calm helps prevent conflict from escalating.', 
    'Kekalkan rekod yang tepat sambil bersikap tenang untuk elakkan keadaan menjadi lebih tegang.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'a2d74b92-3651-43af-bd03-f28802cc458c', 
    'While driving through a community area, people nearby gesture for you to slow down as you pass.', 
    'Semasa melalui kawasan komuniti, orang di sekitar memberi isyarat supaya anda memperlahankan kenderaan.', 
    '["Reduce speed and continue driving considerately", "Maintain your speed since you are within the limit", "Slow briefly, then resume your previous speed", "Focus ahead and avoid reacting to the gestures"]', 
    '["Kurangkan kelajuan dan teruskan pemanduan dengan penuh pertimbangan", "Kekalkan kelajuan kerana masih dalam had yang dibenarkan", "Perlahankan seketika, kemudian sambung semula kelajuan asal", "Fokus ke hadapan dan abaikan isyarat tersebut"]', 
    0, 
    'Adjusting speed in response to community signals shows courtesy and respect for local conditions.', 
    'Melaras kelajuan mengikut keadaan setempat menunjukkan sikap hormat dan prihatin terhadap komuniti.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'b18ad25c-699b-4017-8d3b-7fad2cfa0eea', 
    'In a local area, another driver gestures courteously for you to merge while traffic slows.', 
    'Di kawasan tempatan, seorang pemandu memberi isyarat sopan untuk membenarkan anda masuk ketika trafik semakin perlahan.', 
    '["Signal clearly and merge when safe", "Merge promptly to return the courtesy", "Hesitate briefly to avoid appearing disrespectful", "Acknowledge the gesture and continue moving"]', 
    '["Beri isyarat dengan jelas dan masuk apabila selamat", "Masuk segera untuk membalas kesopanan tersebut", "Tangguh seketika supaya tidak kelihatan tidak menghormati", "Balas isyarat tersebut dan teruskan bergerak"]', 
    0, 
    'Clear signalling should guide merging decisions, even when courtesy is shown by others.', 
    'Isyarat yang jelas dan pertimbangan keselamatan perlu menjadi panduan walaupun diberi laluan oleh pemandu lain.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '4691c926-12e3-4477-9fde-5fa3fd01f237', 
    'You plan to install a sun shade, dark tint film, or stickers on the company truck windscreen.', 
    'Anda bercadang memasang pelindung matahari, filem gelap, atau pelekat pada cermin hadapan lori syarikat.', 
    '["Install them if they do not block the main driving view.", "Do not install them without company approval.", "Use removable shades only during daytime driving.", "Check whether other drivers have done similar modifications."]', 
    '["Pasang jika tidak menghalang pandangan utama ketika memandu.", "Jangan pasang tanpa kelulusan syarikat.", "Gunakan pelindung yang boleh ditanggalkan pada waktu siang sahaja.", "Periksa sama ada pemandu lain pernah membuat perubahan yang sama."]', 
    1, 
    'Avoid unauthorised vehicle modifications that may affect safety or compliance.', 
    'Elakkan pengubahsuaian kenderaan tanpa kelulusan yang boleh menjejaskan keselamatan atau pematuhan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'df621732-cbe4-4b99-871f-c87f31d8d52a', 
    'You have been on duty for 10 hours and are asked to continue working.', 
    'Anda telah bertugas selama 10 jam dan diminta untuk terus bekerja.', 
    '["Continue if the remaining task is short.", "Stop working after reaching the 10-hour limit.", "Work another hour and rest later.", "Continue if traffic conditions are light."]', 
    '["Teruskan jika baki tugasan adalah singkat.", "Hentikan bekerja selepas mencapai had 10 jam.", "Bekerja satu jam lagi dan berehat kemudian.", "Teruskan jika keadaan trafik tidak sibuk."]', 
    1, 
    'Adhere to the maximum daily working hour limit.', 
    'Patuhi had maksimum waktu kerja harian.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '6bef96b5-58c1-46b9-bc1d-471191163bb3', 
    'Your goods vehicle is experiencing failure on a highway and you are placing safety cones behind it.', 
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda sedang meletakkan kon keselamatan di belakangnya.', 
    '["Place cones a few metres behind the vehicle to alert nearby traffic.", "Position cones to the rear, spaced about 10 metres apart.", "Place one cone directly behind the vehicle as a marker.", "Set the cones beside the vehicle to save time."]', 
    '["Letakkan kon beberapa meter di belakang kenderaan untuk memberi amaran kepada trafik berhampiran.", "Letakkan kon di bahagian belakang dengan jarak kira-kira 10 meter antara satu sama lain.", "Letakkan satu kon tepat di belakang kenderaan sebagai penanda.", "Letakkan kon di sisi kenderaan untuk menjimatkan masa."]', 
    1, 
    'Position warning devices correctly to provide clear rear hazard warning.', 
    'Letakkan alat amaran dengan jarak yang sesuai untuk memberi amaran yang jelas kepada trafik dari belakang.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'ab7ac826-e2fe-4492-8261-a237b050356e', 
    'During inspection, you realise the vehicle has no working torchlight.', 
    'Semasa pemeriksaan, anda mendapati tiada lampu suluh yang berfungsi di dalam kenderaan.', 
    '["Proceed if driving is during daytime only.", "Replace the torchlight before operating the vehicle.", "Use your phone light if needed.", "Continue since other safety items are present."]', 
    '["Teruskan perjalanan jika pemanduan hanya pada waktu siang.", "Gantikan lampu suluh tersebut sebelum mengendalikan kenderaan.", "Gunakan lampu telefon bimbit jika perlu.", "Teruskan kerana peralatan keselamatan lain masih ada."]', 
    1, 
    'Ensure required safety equipment is present and functional.', 
    'Pastikan peralatan keselamatan yang diperlukan tersedia dan berfungsi dengan baik.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'a6842341-a06c-4cda-868b-48516da886c3', 
    'Before starting your trip, you review the vehicle''s licensing documents.', 
    'Sebelum memulakan perjalanan, anda menyemak dokumen lesen kenderaan.', 
    '["Proceed if the documents were checked last month.", "Verify that all required vehicle licences are valid.", "Continue driving and check only if stopped.", "Rely on the office to monitor document validity."]', 
    '["Teruskan perjalanan jika dokumen telah diperiksa bulan lepas.", "Pastikan semua lesen kenderaan yang diperlukan masih sah.", "Terus memandu dan semak hanya jika ditahan.", "Bergantung kepada pejabat untuk memantau tempoh sah dokumen."]', 
    1, 
    'Ensure vehicle licensing documents are valid before operating.', 
    'Pastikan semua dokumen lesen kenderaan masih sah sebelum mengendalikan kenderaan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '3777aab2-45ce-4d58-becf-f515077fd817', 
    'You are scheduled to begin duty at 5:00 AM.', 
    'Anda dijadualkan untuk memulakan tugas pada pukul 8:00 pagi.', 
    '["Arrive early to prepare before starting duty.", "Arrive exactly at 8:00 AM and prepare afterward.", "Arrive a few minutes late if traffic is light.", "Inform colleagues to cover while you arrive."]', 
    '["Tiba lebih awal untuk membuat persediaan sebelum bertugas.", "Tiba tepat pukul 8:00 pagi dan buat persediaan selepas itu.", "Tiba lewat beberapa minit jika trafik lancar.", "Maklumkan rakan sekerja untuk mengambil alih tugas sementara anda tiba."]', 
    0, 
    'Arrive early to prepare and start duty on time.', 
    'Tiba lebih awal untuk membuat persediaan dan memulakan tugas tepat pada masanya.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '500064b7-2a8b-4dbc-be30-044e1cd0c172', 
    'Before starting a trip, you check the prime mover and trailer documents.', 
    'Sebelum memulakan perjalanan, anda menyemak dokumen kepala lori dan treler.', 
    '["Ensure the permit, road tax, and inspection certificate are valid.", "Proceed if the road tax is still valid.", "Check only the prime mover documents.", "Verify documents only when stopped by enforcement."]', 
    '["Pastikan permit, cukai jalan dan sijil pemeriksaan masih sah.", "Teruskan perjalanan jika cukai jalan masih sah.", "Periksa dokumen kepala lori sahaja.", "Sahkan dokumen hanya apabila ditahan penguat kuasa."]', 
    0, 
    'Ensure all required vehicle documents are valid before operating.', 
    'Pastikan semua dokumen kenderaan yang diperlukan masih sah sebelum beroperasi.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '4bfc0c0b-c1d1-41b8-8482-2e6e26c63205', 
    'Before leaving the port, you check the container seal.', 
    'Sebelum meninggalkan pelabuhan, anda memeriksa seal kontena.', 
    '["Proceed if the seal appears attached.", "Ensure the seal is properly locked before departure.", "Leave immediately if the container door is closed.", "Rely on port staff to confirm the seal."]', 
    '["Teruskan perjalanan jika seal kelihatan terpasang.", "Pastikan seal dikunci dengan betul sebelum bertolak.", "Bertolak segera jika pintu kontena telah ditutup.", "Bergantung kepada kakitangan pelabuhan untuk mengesahkan seal."]', 
    1, 
    'Ensure the container seal is securely locked before departure.', 
    'Pastikan seal kontena dikunci dengan selamat sebelum bertolak.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'b655c7d2-20dd-476a-9e0f-94099737ced1', 
    'Before leaving the port, you find the container door slightly misaligned.', 
    'Sebelum meninggalkan pelabuhan, anda mendapati pintu kontena sedikit tidak sejajar.', 
    '["Record the door condition in the gate pass.", "Proceed since it can still be locked.", "Deliver first and update later.", "Ignore if seal is intact."]', 
    '["Rekodkan keadaan pintu pada gate pass.", "Teruskan perjalanan kerana pintu masih boleh dikunci.", "Hantar dahulu dan kemas kini kemudian.", "Abaikan keadaan jika seal masih baik."]', 
    0, 
    'Record any container door defect in the gate pass before exit.', 
    'Rekodkan sebarang kecacatan pintu kontena pada gate pass sebelum keluar.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '7827828d-1339-4677-852e-021fe2d05907', 
    'You notice damage on the container but are unsure whether the cargo inside is affected.', 
    'Anda mendapati terdapat kerosakan pada kontena dan tidak pasti sama ada muatan di dalamnya terjejas.', 
    '["Inform operations and wait for instruction.", "Proceed if the seal is intact.", "Deliver first and inspect at destination.", "Continue if external damage appears minor."]', 
    '["Maklumkan bahagian operasi dan tunggu arahan lanjut.", "Teruskan perjalanan jika seal masih utuh.", "Hantar dahulu dan periksa di lokasi penghantaran.", "Teruskan perjalanan jika kerosakan luar kelihatan kecil."]', 
    0, 
    'Report uncertain damage before moving the container.', 
    'Laporkan kerosakan yang tidak pasti sebelum menggerakkan kontena.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '6e768c1c-07d5-4573-bffe-2822c1d37d49', 
    'During a delivery, a customer raises their voice and provokes you.', 
    'Semasa membuat penghantaran, seorang pelanggan meninggikan suara dan memprovokasi anda.', 
    '["Respond firmly to defend your position.", "Avoid confrontation and report to operations.", "Leave the site immediately without informing anyone.", "Continue arguing until the issue is resolved."]', 
    '["Bertindak balas dengan tegas untuk mempertahankan diri.", "Elakkan pertelingkahan dan laporkan kepada bahagian operasi.", "Tinggalkan tapak serta-merta tanpa memaklumkan kepada sesiapa.", "Terus berdebat sehingga isu selesai."]', 
    1, 
    'Do not engage in confrontation; report the matter to operations.', 
    'Elakkan pertelingkahan dan laporkan perkara tersebut kepada bahagian operasi.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '786dfc49-f974-4989-8542-76e9b87a162c', 
    'After a collision, the third party offers to settle repair costs privately.', 
    'Selepas pelanggaran, pihak ketiga menawarkan untuk menyelesaikan kos pembaikan secara persendirian.', 
    '["Accept the offer to avoid paperwork.", "Inform operations and wait for instruction.", "Negotiate and settle on the spot.", "Accept payment and continue duty."]', 
    '["Terima tawaran untuk mengelakkan urusan dokumentasi.", "Maklumkan bahagian operasi dan tunggu arahan selanjutnya.", "Berunding dan selesaikan di tempat kejadian.", "Terima bayaran dan teruskan tugas."]', 
    1, 
    'Do not agree to private settlements without company instruction.', 
    'Jangan bersetuju dengan penyelesaian persendirian tanpa arahan syarikat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '82b20837-2787-42c3-a2b7-cca2d5338079', 
    'Your vehicle is carrying chemical cargo and is involved in an accident.', 
    'Kenderaan anda membawa muatan bahan kimia dan terlibat dalam kemalangan.', 
    '["Inform operations of the cargo type and any hazard risk.", "Report the vehicle damage.", "Wait for emergency responders to identify the cargo.", "Mention cargo details when asked."]', 
    '["Maklumkan kepada bahagian operasi jenis muatan dan sebarang risiko bahaya.", "Laporkan kerosakan kenderaan.", "Tunggu pasukan kecemasan mengenal pasti jenis muatan.", "Nyatakan butiran muatan bila ditanya."]', 
    0, 
    'Communicate cargo hazards immediately during an accident.', 
    'Maklumkan risiko bahaya muatan dengan segera semasa kemalangan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    6, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '199f4f2b-616d-4528-801d-94bc223ab8cc', 
    'You drive at cruising speed. Vehicles ahead brake intermittently and motorcycles filter between lanes.', 
    'Anda memandu pada kelajuan tetap. Kenderaan di hadapan membrek dan motosikal bergerak di antara lorong.', 
    '["Increase following distance for sudden slowing", "Maintain distance and brake if traffic slows", "Move closer to match the pace ahead", "Change lanes to avoid unpredictable movement"]', 
    '["Tambah jarak kenderaan untuk lebih bersedia", "Kekalkan jarak dan brek jika trafik perlahan", "Bergerak lebih dekat untuk ikut kelajuan di hadapan", "Tukar lorong untuk elakkan pergerakan tidak menentu"]', 
    0, 
    'Extra space gives more time to respond to hazards ahead.', 
    'Ruang tambahan memberi lebih masa untuk bertindak terhadap bahaya di hadapan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '62f6f8e1-dbad-46fc-890b-5206f303a520', 
    'You drive at night in heavy rain. Spray from vehicles ahead reduces visibility.', 
    'Anda memandu pada waktu malam dalam keadaan hujan lebat. Percikan air dari kenderaan di hadapan mengurangkan pandangan.', 
    '["Increase following distance for more reaction time", "Maintain distance since traffic speed is steady", "Close the gap to keep sight of the vehicle ahead", "Keep the same distance and react if traffic slows"]', 
    '["Tambah jarak kenderaan untuk lebih masa bertindak", "Kekalkan jarak kerana kelajuan trafik stabil", "Rapatkan jarak untuk mengekalkan pandangan kenderaan di hadapan", "Kekalkan jarak dan bertindak jika trafik perlahan"]', 
    0, 
    'Increase spacing in poor visibility to manage sudden slowing safely.', 
    'Tingkatkan jarak antara kenderaan ketika penglihatan terhad bagi menangani tindakan brek mengejut dengan selamat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '9b7b2178-bc95-4572-8bd5-beb237918576', 
    'You are inside a container terminal where RTGs operate across marked lanes with clear zones.', 
    'Anda berada di dalam terminal kontena di mana RTG beroperasi merentasi lorong bertanda dengan zon larangan.', 
    '["Remain outside the clear zone until access is given", "Move along the lane edge while staying alert", "Advance slowly when the RTG appears to reposition", "Follow the vehicle ahead past the RTG"]', 
    '["Kekal di luar zon larangan sehingga laluan dibenarkan", "Bergerak di tepi lorong sambil kekal peka", "Bergerak perlahan apabila RTG kelihatan beralih", "Ikut kenderaan di hadapan melepasi RTG"]', 
    0, 
    'Respect clear zones and wait for safe access near lifting equipment.', 
    'Hormati zon larangan dan tunggu laluan selamat berhampiran jentera angkat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '44a8afd7-b42f-4721-ae19-1712798ff0be', 
    'Inside a site yard, you merge into an internal lane while equipment operates nearby.', 
    'Di dalam kawasan tapak, anda perlu masuk ke lorong dalaman sementara jentera beroperasi berhampiran.', 
    '["Wait for a clear gap with safe equipment clearance", "Merge when a small gap appears to maintain flow", "Move forward gradually to secure space", "Follow the vehicle ahead into the lane"]', 
    '["Tunggu ruang jelas dengan jarak selamat daripada jentera", "Masuk apabila terdapat ruang kecil untuk kekalkan aliran trafik", "Bergerak ke hadapan secara beransur untuk mendapatkan ruang", "Ikut kenderaan di hadapan masuk ke lorong"]', 
    0, 
    'Choose a clear gap and keep safe distance from operating equipment.', 
    'Tunggu ruang yang jelas dan kekalkan jarak selamat dari jentera beroperasi.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '5592de33-fdaf-49f5-a723-3b4e4cb6b188', 
    'You approach an area where containers are being lifted and repositioned. Equipment movement is ongoing.', 
    'Anda menghampiri kawasan di mana kontena sedang dialihkan. Jentera masih beroperasi.', 
    '["Stop outside the lifting zone until operations are complete", "Proceed slowly while monitoring the lifting activity", "Continue moving and adjust if equipment comes closer", "Follow another vehicle that enters the zone"]', 
    '["Berhenti di luar zon pengangkatan sehingga operasi selesai", "Terus bergerak perlahan sambil memantau aktiviti pengangkatan", "Terus bergerak dan sesuaikan kedudukan jika jentera menghampiri", "Ikut kenderaan lain yang memasuki zon tersebut"]', 
    0, 
    'Keep clear of active lifting zones.', 
    'Jauhi zon pengangkatan yang sedang aktif.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'def869ba-2d04-4688-bc2e-2ad65e901493', 
    'After a delivery, you park in a designated area where idling is prohibited.', 
    'Selepas penghantaran, anda parkir di kawasan yang ditetapkan di mana enjin tidak dibenarkan hidup.', 
    '["Switch off the engine and follow the parking procedure", "Leave the engine running briefly to save time", "Complete the procedure and address the engine later", "Wait in the vehicle with the engine on"]', 
    '["Matikan enjin dan ikut prosedur parkir", "Biarkan enjin hidup seketika untuk menjimatkan masa", "Lengkapkan prosedur dahulu dan matikan enjin kemudian", "Tunggu di dalam kenderaan dengan enjin masih hidup"]', 
    0, 
    'Follow procedures and switch off the engine where idling is prohibited.', 
    'Ikut prosedur dan matikan enjin di kawasan yang melarang melahu enjin.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '258653d8-70f8-4180-a84a-4765275fb806', 
    'While driving inside a site with pedestrians and equipment moving nearby, your phone receives a message.', 
    'Semasa memandu di dalam tapak dengan pekerja dan jentera bergerak berhampiran, telefon anda menerima mesej.', 
    '["Ignore the message and maintain full attention", "Check the message briefly since speed is low", "Slow down and glance when the area looks clear", "Respond quickly."]', 
    '["Abaikan mesej dan kekalkan tumpuan penuh", "Periksa mesej seketika kerana kelajuan rendah", "Perlahankan dan lihat mesej apabila kawasan kelihatan selamat", "Balas mesej dengan cepat."]', 
    0, 
    'Avoid distractions in mixed-movement areas.', 
    'Elakkan gangguan di kawasan pergerakan bercampur.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '03457514-5d9a-4db1-a6c1-a06e56e1e2d5', 
    'After a pre-trip inspection, you notice a twist lock is not fully secured though the container appears stable.', 
    'Selepas pemeriksaan sebelum perjalanan, anda mendapati twist lock tidak dikunci sepenuhnya walaupun kontena kelihatan stabil.', 
    '["Secure the twist lock before departing", "Start the trip but drive carefully", "Proceed since the container appears stable", "Monitor the load and act if it shifts"]', 
    '["Pastikan twist lock dikunci dengan betul sebelum bergerak", "Mulakan perjalanan tetapi memandu dengan berhati-hati", "Teruskan kerana kontena kelihatan stabil", "Pantau muatan semasa perjalanan dan bertindak jika ia bergerak"]', 
    0, 
    'Correct load security issues before moving.', 
    'Pastikan keselamatan muatan disahkan sebelum bergerak.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '2f0ea6b7-0503-4f11-aa10-ec503d984c0a', 
    'During a slow loading manoeuvre in a confined space, a nearby worker offers guidance.', 
    'Semasa manuver perlahan untuk pemuatan di ruang sempit, seorang pekerja memberi panduan.', 
    '["Pause and coordinate clearly with the worker before continuing", "Continue manoeuvring slowly and rely on hand signals as they appear", "Proceed carefully without engaging to avoid confusion", "Continue cautiously while listening for instructions and adjusting if needed"]', 
    '["Berhenti seketika dan sesuaikan komunikasi dengan pekerja sebelum meneruskan", "Teruskan manuver perlahan dan bergantung pada isyarat tangan yang diberi", "Teruskan dengan berhati-hati tanpa berinteraksi untuk elakkan kekeliruan", "Teruskan dengan berhati-hati sambil mendengar arahan dan melaras jika perlu"]', 
    0, 
    'Clear coordination during manoeuvres helps prevent damage and supports safe cooperation.', 
    'Koordinasi yang jelas semasa manuver membantu mencegah kerosakan dan menyokong kerjasama yang selamat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '60a1bfa4-d9c2-4fdc-8ec2-aafa053baf4a', 
    'While moving through a busy site, you feel abnormal resistance and hear a new mechanical sound.', 
    'Semasa bergerak di tapak yang sibuk, anda merasakan rintangan tidak normal dan bunyi mekanikal baharu.', 
    '["Continue moving slowly to clear the area", "Stop safely, assess the issue, and proceed only when clear", "Adjust steering and throttle to maintain site flow", "Complete the movement and report the issue afterward"]', 
    '["Terus bergerak perlahan untuk keluar dari kawasan itu", "Berhenti di tempat selamat, periksa keadaan, dan teruskan hanya apabila jelas selamat", "Laraskan stereng dan pendikit untuk mengekalkan aliran pergerakan tapak", "Selesaikan pergerakan dan laporkan masalah selepas itu"]', 
    1, 
    'Respond promptly to mechanical cues and ensure the area is safe before proceeding.', 
    'Bertindak segera terhadap tanda mekanikal dan pastikan kawasan selamat sebelum meneruskan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'ef630196-1f8a-428c-ba1f-fb0ca6c4cc0f', 
    'At a site gate, you notice a wheel chock and tool left unsecured on the vehicle before entry.', 
    'Di pintu masuk tapak, anda perasan pengadang tayar dan peralatan tidak diikat kemas pada kenderaan sebelum masuk.', 
    '["Enter the site and secure them at the first parking point", "Secure the items before entering the site", "Proceed inside since the items are not in use", "Ask security to allow entry first"]', 
    '["Masuk tapak dan kemaskan di tempat parkir pertama", "Kemaskan dahulu sebelum masuk tapak", "Terus masuk kerana alat itu tidak digunakan", "Minta kebenaran masuk daripada pengawal dahulu"]', 
    1, 
    'Securing loose equipment before entry prevents avoidable risks inside controlled areas.', 
    'Kemaskan peralatan sebelum masuk tapak untuk elakkan risiko.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '776036bf-e763-46b7-88e4-1da21964cf4c', 
    'A customer asks you to change delivery details on the paperwork.', 
    'Seorang pelanggan meminta anda mengubah butiran penghantaran dalam dokumen.', 
    '["Complete the paperwork accurately and explain the situation", "Adjust the delivery details as requested by the customer", "Leave the paperwork unchanged and submit it later", "Submit the paperwork as requested without explanation"]', 
    '["Lengkapkan dokumen dengan tepat dan jelaskan keadaan sebenar", "Ubah butiran penghantaran seperti diminta", "Biarkan dokumen seperti itu dan serahkan kemudian", "Serahkan dokumen seperti diminta tanpa penjelasan"]', 
    0, 
    'Accurate documentation ensures transparency and protects everyone involved.', 
    'Dokumentasi yang tepat memastikan ketelusan dan melindungi semua pihak.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'f64437e9-80e1-470e-95f2-e6f23a821287', 
    'During unloading, a tense exchange with site staff starts attracting attention from people nearby.', 
    'Semasa proses memunggah, perbualan tegang dengan kakitangan tapak mula menarik perhatian orang di sekeliling.', 
    '["Keep your tone calm and behaviour professional", "Explain your actions in detail so observers understand your position", "Continue the task while limiting further interaction", "Justify your response to avoid appearing at fault"]', 
    '["Kekalkan nada tenang dan tingkah laku profesional", "Terangkan tindakan anda dengan terperinci supaya orang lain faham", "Teruskan tugas sambil hadkan interaksi lanjut", "Jelaskan respons anda untuk elak kelihatan bersalah"]', 
    0, 
    'Maintaining calm, professional behaviour protects your image when situations draw public attention.', 
    'Kekalkan sikap tenang dan profesional apabila situasi menarik perhatian orang ramai.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'fd7ab232-bcdc-4853-8365-60a80fb22448', 
    'During a delivery, a customer explains that a small personal gift is customary in their culture.', 
    'Semasa penghantaran, seorang pelanggan menjelaskan bahawa pemberian kecil peribadi adalah amalan dalam budayanya.', 
    '["Decline respectfully and continue with the delivery as planned", "Accept briefly to avoid appearing disrespectful", "Delay responding and see how others handle it", "Explain carefully why such gifts can cause problems"]', 
    '["Tolak dengan hormat dan teruskan penghantaran seperti dirancang", "Terima seketika supaya tidak kelihatan tidak hormat", "Tangguhkan respons dan lihat bagaimana orang lain bertindak", "Terangkan dengan teliti mengapa pemberian itu boleh menimbulkan isu"]', 
    0, 
    'Respecting culture does not require accepting gifts that compromise integrity.', 
    'Menghormati budaya tidak bermaksud menerima pemberian yang boleh menjejaskan integriti.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '555ef83c-72cb-4349-b6e0-07b634370922', 
    'You approach a road section with temporary cones where pedestrians are crossing near your lane.', 
    'Anda menghampiri laluan yang dipasang kon sementara dengan pejalan kaki melintas berhampiran lorong anda.', 
    '["Maintain correct lane position and proceed cautiously past the area", "Move closer to the lane edge to pass through more quickly", "Adjust position to follow vehicles ahead without slowing", "Focus on traffic flow and avoid reacting to people nearby"]', 
    '["Kekalkan kedudukan lorong yang betul dan pandu dengan berhati-hati melalui kawasan tersebut", "Rapat ke tepi lorong untuk melepasi kawasan dengan lebih cepat", "Laraskan kedudukan mengikut kenderaan di hadapan tanpa memperlahankan", "Fokus pada aliran trafik dan abaikan orang di sekitar"]', 
    0, 
    'Maintaining lane discipline and caution protects pedestrians and reflects responsible public conduct.', 
    'Disiplin lorong dan pemanduan berhati-hati melindungi pejalan kaki serta mencerminkan sikap bertanggungjawab di tempat awam.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '706c4199-4bc9-4c9f-b409-39dde6baa8bf', 
    'You prepare to merge into a moving lane when another driver accelerates and blocks the available gap.', 
    'Anda bersedia untuk masuk ke lorong yang sedang bergerak apabila seorang pemandu lain memecut dan menutup ruang yang ada.', 
    '["Hold back and wait for a clearer gap", "Force the merge to assert your position", "Move closer to pressure the other driver to yield", "Gesture briefly to signal dissatisfaction"]', 
    '["Tahan dan tunggu ruang yang lebih jelas serta selamat", "Paksa masuk untuk mempertahankan kedudukan anda", "Rapatkan kenderaan untuk memberi tekanan supaya pemandu lain mengalah", "Buat isyarat ringkas tanda tidak puas hati"]', 
    0, 
    'Waiting for a safe gap and avoiding confrontation reduces risk and prevents unnecessary conflict.', 
    'Menunggu ruang yang selamat dan mengelakkan konfrontasi membantu mengurangkan risiko serta ketegangan di jalan raya.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '4db025dd-e42a-42e4-bc4f-52ae26c1e056', 
    'You have completed 8 hours of driving for the day and one nearby delivery remains.', 
    'Anda telah memandu selama 8 jam pada hari itu dan satu penghantaran berhampiran masih belum selesai.', 
    '["Continue driving to complete the final delivery.", "Stop driving and report reaching the daily limit.", "Drive for another 30 minutes before stopping.", "Reduce speed and complete the delivery carefully."]', 
    '["Terus memandu untuk menyelesaikan penghantaran terakhir.", "Hentikan pemanduan dan laporkan bahawa had harian telah dicapai.", "Memandu lagi selama 30 minit sebelum berhenti.", "Kurangkan kelajuan dan selesaikan penghantaran dengan berhati-hati."]', 
    1, 
    'Follow driving hour limits to maintain safety and compliance.', 
    'Patuhi had waktu pemanduan untuk menjaga keselamatan dan pematuhan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'e31763d2-5e14-4746-afd2-71210e229cd5', 
    'You have worked six consecutive days and are scheduled for another duty.', 
    'Anda telah bekerja selama enam hari berturut-turut dan dijadualkan untuk bertugas lagi.', 
    '["Continue working if you feel fit.", "Take one rest day after six working days.", "Work half a day before taking leave.", "Swap shifts without taking a rest day."]', 
    '["Terus bekerja jika anda berasa cergas.", "Ambil satu hari rehat selepas enam hari bekerja.", "Bekerja separuh hari sebelum mengambil cuti.", "Tukar syif tanpa mengambil hari rehat."]', 
    1, 
    'Take the required rest day after six consecutive working days.', 
    'Ambil hari rehat yang ditetapkan selepas bekerja enam hari berturut-turut.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '7ba81c6c-6ee9-4d6e-b3cc-81bb8ace7859', 
    'Your goods vehicle is experiencing failure on a highway and you are placing a warning triangle.', 
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda sedang meletakkan segi tiga amaran.', 
    '["Place it a few metres behind the vehicle for quick visibility.", "Place it about 50 metres to the rear of the vehicle.", "Place it beside the vehicle near the shoulder.", "Hold it while standing near traffic to alert drivers."]', 
    '["Letakkan beberapa meter di belakang kenderaan supaya mudah dilihat dengan cepat.", "Letakkan kira-kira 50 meter di belakang kenderaan.", "Letakkan di sisi kenderaan berhampiran bahu jalan.", "Pegang sambil berdiri berhampiran trafik untuk memberi amaran."]', 
    1, 
    'Position warning devices at a safe rear distance to alert approaching traffic early.', 
    'Letakkan alat amaran pada jarak selamat di belakang kenderaan untuk memberi amaran awal kepada trafik yang menghampiri.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '2078a78f-5751-45e3-b176-e557fd201dc6', 
    'You check the vehicle and the warning triangle is missing.', 
    'Anda memeriksa kenderaan dan mendapati segi tiga amaran tiada.', 
    '["Continue driving if hazard lights are working.", "Replace the safety triangle before departure.", "Borrow one only when needed.", "Use cones instead of a triangle."]', 
    '["Terus memandu jika lampu kecemasan berfungsi.", "Gantikan segi tiga amaran sebelum memulakan perjalanan.", "Pinjam satu hanya apabila diperlukan.", "Gunakan kon sebagai ganti segi tiga amaran."]', 
    1, 
    'Carry the required warning triangle before operating.', 
    'Bawa segi tiga amaran yang diperlukan sebelum mengendalikan kenderaan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'b30f58f0-702d-4e5b-8b42-8f2fb946bee1', 
    'During inspection, you check the engine system before departure.', 
    'Semasa pemeriksaan, anda memeriksa sistem enjin sebelum memulakan perjalanan.', 
    '["Skip the check if the engine started normally.", "Verify the engine system as part of the safety inspection.", "Check only when warning lights appear.", "Inspect the engine only during scheduled servicing."]', 
    '["Abaikan pemeriksaan jika enjin dapat dihidupkan seperti biasa.", "Sahkan sistem enjin sebagai sebahagian daripada pemeriksaan keselamatan.", "Periksa hanya apabila lampu amaran menyala.", "Periksa enjin hanya semasa servis berjadual."]', 
    1, 
    'Include engine system checks in daily safety inspections.', 
    'Periksa sistem enjin setiap hari sebagai sebahagian daripada pemeriksaan keselamatan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'f038b1e3-b544-4eb0-aad0-e962d21af346', 
    'You are starting and completing a delivery trip.', 
    'Anda memulakan dan menamatkan satu perjalanan penghantaran.', 
    '["Record the meter reading only at the end of the trip.", "Record the meter reading before and after the trip.", "Record it only if fuel usage seems unusual.", "Estimate the reading based on distance travelled."]', 
    '["Catat bacaan meter hanya pada akhir perjalanan.", "Catat bacaan meter sebelum dan selepas perjalanan.", "Catat hanya jika penggunaan bahan api kelihatan luar biasa.", "Anggarkan bacaan berdasarkan jarak perjalanan."]', 
    1, 
    'Record meter readings before and after each trip.', 
    'Catat bacaan meter sebelum dan selepas setiap perjalanan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'f881bc73-82d2-4c17-8450-c12cf807e7d3', 
    'Before departure, you review the prime mover and trailer documents. One document has expired.', 
    'Sebelum memulakan perjalanan, anda menyemak dokumen kepala lori dan treler. Salah satu dokumen telah tamat tempoh.', 
    '["Proceed if the other documents are still valid.", "Inform operations and do not operate until resolved.", "Continue the trip and update after delivery.", "Drive and renew the document at the next service."]', 
    '["Teruskan perjalanan jika dokumen lain masih sah.", "Maklumkan bahagian operasi dan jangan beroperasi sehingga diselesaikan.", "Teruskan perjalanan dan kemas kini selepas penghantaran selesai.", "Memandu dahulu dan perbaharui dokumen pada servis seterusnya."]', 
    1, 
    'Do not operate if required vehicle documents have expired and inform operations immediately.', 
    'Jangan beroperasi jika dokumen kenderaan yang diperlukan telah tamat tempoh dan maklumkan kepada bahagian operasi segera.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'aa885e0c-7a84-4162-9239-4fc402584393', 
    'Before exiting the port, you compare the seal number with the gate pass.', 
    'Sebelum keluar dari pelabuhan, anda membandingkan nombor seal dengan maklumat pada gate pass.', 
    '["Proceed if the seal is intact.", "Confirm the seal number matches the document.", "Check the number only at delivery point.", "Ignore minor number differences."]', 
    '["Teruskan perjalanan jika seal kelihatan baik.", "Pastikan nombor seal sepadan dengan dokumen.", "Semak nombor hanya apabila tiba di lokasi penghantaran.", "Abaikan perbezaan kecil pada nombor."]', 
    1, 
    'Verify that the seal number matches the documented record.', 
    'Pastikan nombor seal sepadan dengan rekod dalam dokumen sebelum berlepas.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'd355107a-ac35-4011-9cd8-9b3bcb9d1575', 
    'You collect a container from a customer premise and notice exterior damage.', 
    'Anda mengambil sebuah kontena dari premis pelanggan dan mendapati terdapat kerosakan pada bahagian luarnya.', 
    '["Record it internally and inform operations.", "Inform the customer and proceed.", "Continue if the container is sealed.", "Deliver first and update later."]', 
    '["Catat dalam rekod dalaman dan maklumkan bahagian operasi.", "Maklumkan pelanggan dan teruskan perjalanan.", "Teruskan jika kontena telah dimeterai.", "Hantar dahulu dan kemas kini kemudian."]', 
    0, 
    'Record and report container damage before movement.', 
    'Rekodkan dan laporkan kerosakan kontena sebelum meneruskan perjalanan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '17b2c49e-d194-46d8-a9e3-b68ca960f1e8', 
    'You are uncertain about the extent of container or cargo damage.', 
    'Anda tidak pasti tahap kerosakan pada kontena atau muatan di dalamnya.', 
    '["Proceed cautiously and monitor during transit.", "Seek operations approval before movement.", "Inform the customer and continue.", "Move the container to a nearby safe area first."]', 
    '["Teruskan perjalanan dengan berhati-hati dan pantau semasa perjalanan.", "Dapatkan kelulusan daripada bahagian operasi sebelum bergerak.", "Maklumkan kepada pelanggan dan teruskan perjalanan.", "Alihkan kontena ke kawasan selamat berhampiran terlebih dahulu."]', 
    1, 
    'Do not move the container without operations approval when damage is unclear.', 
    'Jangan gerakkan kontena tanpa kelulusan bahagian operasi apabila tahap kerosakan tidak jelas.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'd51a5aad-5283-4a3b-aa76-97db547ebec4', 
    'While driving, a member of the public provokes you aggressively.', 
    'Semasa memandu, seorang orang awam bertindak agresif dan memprovokasi anda.', 
    '["React quickly to assert your position.", "Remain calm and report the incident.", "Stop and confront the person.", "Follow the person to clarify the issue."]', 
    '["Bertindak segera untuk mempertahankan pendirian anda.", "Kekal tenang dan laporkan kejadian tersebut.", "Berhenti dan bersemuka dengan individu tersebut.", "Ikut individu tersebut untuk menjelaskan keadaan."]', 
    1, 
    'Avoid impulsive actions and report the incident appropriately.', 
    'Kekal tenang dan laporkan kejadian dengan cara yang sesuai.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'f5d912c1-8214-4e42-b2ca-896ba1fa959d', 
    'While driving on a highway, you notice smoke coming from the trailer.', 
    'Semasa memandu di lebuh raya, anda mendapati asap keluar dari treler.', 
    '["Stop at a safe roadside area without blocking traffic.", "Continue slowly to reach the nearest rest area.", "Stop immediately in the current lane.", "Park close to nearby buildings for assistance."]', 
    '["Berhenti di kawasan tepi jalan yang selamat tanpa menghalang trafik.", "Teruskan memandu perlahan untuk sampai ke kawasan rehat terdekat.", "Berhenti serta-merta di lorong semasa.", "Parkir berhampiran bangunan untuk mendapatkan bantuan."]', 
    0, 
    'Stop in a safe open area that does not obstruct traffic.', 
    'Berhenti di kawasan terbuka yang selamat dan tidak menghalang trafik.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '7549788e-2ed5-426e-8e33-68009a5a05be', 
    'After an accident, operations asks about injuries.', 
    'Selepas kemalangan, bahagian operasi bertanya tentang kecederaan.', 
    '["Confirm injuries to yourself and others involved.", "Say everyone seems fine without checking.", "Wait for medical staff to assess first.", "Report injuries after confirmed by hospital."]', 
    '["Sahkan kecederaan kepada diri sendiri dan pihak yang terlibat.", "Maklumkan semua kelihatan baik tanpa membuat pemeriksaan.", "Tunggu petugas perubatan membuat penilaian terlebih dahulu.", "Laporkan kecederaan selepas disahkan oleh pihak hospital."]', 
    0, 
    'Provide accurate injury status information promptly.', 
    'Berikan maklumat status kecederaan dengan tepat dan segera.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    7, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'c6783eb9-e437-48d6-a979-8f657e83af0d', 
    'You prepare to change lanes in steady traffic. Motorcycles filter between lanes and traffic slows near an exit.', 
    'Anda bersedia untuk menukar lorong dalam trafik lancar. Motosikal bergerak di antara lorong dan trafik perlahan berhampiran susur keluar.', 
    '["Signal early and complete full mirror checks before moving", "Signal as you move and rely on others to adjust", "Check mirrors quickly and move when the lane looks clear", "Wait for traffic to stabilise before signalling"]', 
    '["Beri isyarat awal dan periksa cermin sepenuhnya sebelum bergerak", "Beri isyarat semasa bergerak dan harap pemandu lain menyesuaikan diri", "Periksa cermin dengan cepat dan bergerak apabila lorong kelihatan jelas", "Tunggu trafik stabil sebelum memberi isyarat"]', 
    0, 
    'Signal early and complete full checks before changing lanes.', 
    'Beri isyarat awal dan lakukan pemeriksaan penuh sebelum menukar lorong.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '70557534-556b-41a5-8659-703047e0c4eb', 
    'You drive inside a depot with marked lanes. Equipment operates nearby and stacked loads restrict visibility.', 
    'Anda memandu di dalam depot dengan lorong bertanda. Jentera beroperasi berhampiran dan susunan muatan menghadkan pandangan.', 
    '["Keep to the marked lane and slow until movement is clear", "Adjust position to see past the equipment", "Continue moving so you do not block equipment behind", "Proceed as usual and rely on operators"]', 
    '["Kekalkan lorong bertanda dan perlahankan sehingga pergerakan jelas", "Sesuaikan kedudukan untuk melihat melepasi jentera", "Terus bergerak supaya tidak menghalang jentera di belakang", "Teruskan seperti biasa dan bergantung pada pengendali jentera"]', 
    0, 
    'Keep lane discipline and reduce speed near operating equipment.', 
    'Amalkan disiplin lorong dan kurangkan kelajuan berhampiran peralatan beroperasi.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '9c920d68-fa30-4b9a-ae34-58e80abe5ca1', 
    'At a container terminal, lifting operations are in progress. Vehicles and personnel move nearby.', 
    'Di terminal kontena, operasi mengangkat kontena sedang dijalankan. Kenderaan dan pekerja bergerak berhampiran.', 
    '["Keep clear of the lifting zone until the operation ends", "Move closer to observe the lift and prepare to move", "Wait nearby and approach when the container is almost down", "Move forward carefully to avoid delaying trucks behind"]', 
    '["Jauhi zon pengangkatan sehingga operasi selesai", "Bergerak lebih dekat untuk memerhati operasi pengangkatan dan bersedia bergerak", "Tunggu berhampiran dan hampiri apabila kontena hampir diturunkan", "Bergerak ke hadapan dengan berhati-hati supaya tidak melambatkan lori di belakang"]', 
    0, 
    'Stay clear of lifting zones to avoid sudden movement and falling objects.', 
    'Kekalkan jarak dari zon pengangkatan untuk elakkan pergerakan mengejut dan risiko objek jatuh.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '83835452-d047-4348-910e-8b92307f2e0c', 
    'You approach an industrial access road. Surfaces are uneven, obstructions present, and visibility is reduced.', 
    'Anda menghampiri laluan masuk kawasan industri. Permukaan jalan tidak rata, terdapat halangan, dan pandangan terhad.', 
    '["Reduce speed early and adjust your path for hazards", "Maintain a cautious pace and react if conditions worsen", "Proceed steadily while focusing on the access route", "Follow the vehicle ahead navigating the area"]', 
    '["Kurangkan kelajuan lebih awal dan sesuaikan laluan untuk elakkan bahaya", "Kekalkan kelajuan berhati-hati dan bertindak jika keadaan bertambah buruk", "Terus bergerak secara stabil sambil fokus pada laluan utama", "Ikut kenderaan di hadapan yang melalui kawasan itu"]', 
    0, 
    'Adjust early to surface and visibility risks to maintain control.', 
    'Sesuaikan pemanduan lebih awal terhadap risiko permukaan dan pandangan untuk kekalkan kawalan kenderaan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'f3a7b242-e03a-4e8d-a824-e968c2075e09', 
    'You prepare to park and deploy trailer landing legs on uneven ground.', 
    'Anda bersedia untuk parkir dan menurunkan kaki sokongan treler di permukaan tidak rata.', 
    '["Stop and ensure the ground is stable before deploying", "Deploy slowly and monitor for sinking", "Proceed as usual since the area is commonly used", "Rely on visual checks and adjust if movement appears"]', 
    '["Berhenti dan pastikan permukaan stabil sebelum menurunkan kaki sokongan treler", "Turunkan secara perlahan dan pantau jika berlaku mendapan", "Teruskan seperti biasa kerana kawasan tersebut biasa digunakan", "Bergantung pada pemeriksaan visual dan pelarasan jika pergerakan berlaku"]', 
    0, 
    'Assess ground stability before deploying landing legs.', 
    'Periksa kestabilan permukaan sebelum menurunkan kaki sokongan treler.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'b0944847-fb9f-4d48-9f69-16cc9e193305', 
    'At a container terminal, lifting operations are in progress and you enter a marked lifting zone without a safety helmet.', 
    'Di terminal kontena, operasi pengangkatan kontena sedang dijalankan dan anda memasuki zon pengangkatan tanpa topi keselamatan.', 
    '["Put on the required PPE and remain clear of lifting", "Stay where you are since equipment is not moving toward you", "Move quickly through the area to minimise time", "Wait for terminal staff instructions before addressing PPE"]', 
    '["Pakai PPE yang diperlukan dan kekal jauh dari operasi loading", "Kekal di tempat kerana jentera tidak bergerak ke arah anda", "Bergerak cepat melalui kawasan itu untuk kurangkan masa", "Tunggu arahan kakitangan terminal sebelum mengurus PPE"]', 
    0, 
    'Wear required PPE and keep clear of lifting zones.', 
    'Pakai PPE yang diperlukan dan kekalkan jarak dari zon loading.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'e0202902-56d6-40ce-b2ad-5625c9e67f50', 
    'While reversing to park, your phone receives a message.', 
    'Semasa mengundur untuk parkir, telefon anda menerima mesej.', 
    '["Ignore the message and complete the manoeuvre", "Pause and check the message before continuing", "Continue reversing while glancing at the phone", "Stop midway and respond to the message"]', 
    '["Abaikan mesej dan selesaikan manuver", "Berhenti seketika dan periksa mesej sebelum meneruskan", "Terus mengundur sambil melihat telefon", "Berhenti di tengah dan balas mesej"]', 
    0, 
    'Avoid device use during manoeuvres.', 
    'Elakkan penggunaan telefon semasa manuver.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '2f4a75d4-2d1e-413b-a8a4-911f2d9fc5d4', 
    'After completing your trip, you notice a minor defect that developed during the drive.', 
    'Selepas selesai perjalanan, anda mendapati kerosakan kecil berlaku semasa memandu.', 
    '["Report the defect and ensure the vehicle is checked before reuse", "Note the defect later since the trip is completed", "Mention it informally to the next driver", "Leave the vehicle available since it still operates"]', 
    '["Laporkan kerosakan dan pastikan kenderaan diperiksa sebelum digunakan semula", "Catat kerosakan kemudian kerana perjalanan telah selesai", "Beritahu secara tidak rasmi kepada pemandu seterusnya", "Biarkan kenderaan digunakan kerana masih boleh beroperasi"]', 
    0, 
    'Report defects promptly to prevent risk in the next operation.', 
    'Laporkan kerosakan dengan segera untuk mengelakkan risiko dalam operasi seterusnya.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '4f0b9790-6273-440c-a72b-d11156a30989', 
    'After a trip, you identify a minor defect before completing the handover documentation.', 
    'Selepas tamat perjalanan, anda mengesan kerosakan kecil sebelum melengkapkan dokumentasi serahan kenderaan.', 
    '["Record the defect accurately and submit the documentation", "Submit the documentation first and update the defect record later", "Delay recording the defect until the next scheduled inspection", "Note the defect informally and proceed with documentation"]', 
    '["Rekodkan kerosakan dengan tepat dan serahkan dokumentasi", "Serahkan dokumentasi dahulu dan kemas kini rekod kerosakan kemudian", "Tangguhkan merekod kerosakan sehingga pemeriksaan seterusnya", "Catat kerosakan secara tidak rasmi dan teruskan dokumentasi"]', 
    0, 
    'Defects must be formally recorded to ensure proper documentation and accountability.', 
    'kerosakan mesti direkod secara rasmi untuk memastikan dokumentasi dan akauntabiliti yang betul.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '1048438d-c54b-422e-8e54-464447a350dc', 
    'While moving on a wet, uneven surface, you notice abnormal vibration and reduced vehicle response.', 
    'Semasa bergerak di permukaan basah dan tidak rata, anda merasakan getaran tidak normal dan tindak balas kenderaan berkurang.', 
    '["Maintain steady movement to avoid wheel slip", "Stop and assess before continuing", "Adjust speed slightly and continue through the area", "Complete the movement and report the issue later"]', 
    '["Kekalkan pergerakan stabil untuk elakkan gelinciran tayar", "Berhenti dan periksa sebelum meneruskan", "Laraskan kelajuan sedikit dan teruskan melalui kawasan itu", "Selesaikan pergerakan dan laporkan masalah kemudian"]', 
    1, 
    'Pause to assess mechanical signals under challenging surface conditions.', 
    'Berhenti dan periksa isu mekanikal dalam keadaan permukaan yang mencabar.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'f5ddf8da-81dc-4aa8-810f-0827410c1d96', 
    'While parked inside a site, an emergency alarm sounds and evacuation routes must be kept clear.', 
    'Semasa parkir di dalam tapak, penggera kecemasan berbunyi dan laluan keluar mesti dikekalkan bebas halangan.', 
    '["Remain in the cabin and wait for instructions", "Secure cabin items and clear the evacuation path immediately", "Leave the vehicle as it is and exit quickly", "Move the vehicle slightly to create more space"]', 
    '["Kekal di dalam kabin dan tunggu arahan", "Pastikan barang dalam kabin tidak bergerak dan kosongkan laluan keluar segera", "Tinggalkan kenderaan seperti sedia ada dan keluar dengan cepat", "Gerakkan kenderaan sedikit untuk beri lebih ruang"]', 
    1, 
    'Secure loose items and clear evacuation routes immediately.', 
    'Pastikan barang tidak bergerak dan kekalkan laluan keluar jelas dengan segera.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '5022baea-a4f1-4bec-afab-d6ef23690c3d', 
    'During a delivery, a customer follows cultural practices unfamiliar to you.', 
    'Semasa membuat penghantaran, seorang pelanggan mengikut amalan budaya yang tidak biasa bagi anda.', 
    '["Acknowledge the practice and respond respectfully", "Continue the task without engaging further", "Question the practice to clarify expectations", "Follow your usual approach and proceed"]', 
    '["Hormati amalan tersebut dan beri respons dengan sesuai", "Teruskan tugas tanpa melibatkan diri", "Persoalkan amalan itu untuk jelaskan jangkaan", "Ikut cara biasa anda dan teruskan"]', 
    0, 
    'Respecting cultural differences helps maintain positive and professional interactions.', 
    'Menghormati perbezaan budaya membantu kekalkan interaksi yang profesional dan baik.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '82fe9f66-9e2a-4599-b492-aca1d2cdb9ac', 
    'During unloading, site staff suggest recording different details on the delivery documents to save time.', 
    'Semasa proses memunggah, kakitangan tapak mencadangkan supaya butiran pada dokumen penghantaran direkod berbeza untuk jimat masa.', 
    '["Record the actual details accurately", "Adjust the details slightly so unloading can finish smoothly", "Note the change later to keep the paperwork acceptable", "Leave the documents for someone else to complete"]', 
    '["Catat butiran yang sebenarnya dengan tepat", "Ubah sedikit butiran supaya proses memunggah selesai dengan lancar", "Catat perubahan kemudian supaya dokumen masih kelihatan boleh diterima", "Biarkan dokumen untuk disiapkan oleh orang lain"]', 
    0, 
    'Recording accurate details supports accountability and prevents issues later.', 
    'Merekod butiran dengan tepat membantu pastikan tanggungjawab jelas dan elakkan masalah pada masa akan datang.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'c53c2be3-1e26-4abf-a4f8-fe9ec6224ae4', 
    'During a delivery, a cultural misunderstanding causes tension between you and the customer.', 
    'Semasa penghantaran, berlaku salah faham berkaitan budaya yang menyebabkan ketegangan antara anda dan pelanggan.', 
    '["Acknowledge the concern respectfully and respond calmly", "Explain your intentions in detail to clear the misunderstanding", "Step back from the discussion to prevent further discomfort", "Defend your position to avoid being seen as disrespectful"]', 
    '["Ambil maklum dengan hormat dan beri respons dengan tenang", "Terangkan niat anda dengan terperinci untuk jelaskan salah faham", "Undur diri daripada perbincangan untuk elak keadaan menjadi lebih tidak selesa", "Pertahankan pendirian supaya tidak dianggap tidak hormat"]', 
    0, 
    'Respectful acknowledgement and calm response help ease tension caused by misunderstandings.', 
    'Pengakuan yang hormat dan respons yang tenang membantu redakan ketegangan akibat salah faham.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '82edf819-8666-485b-b831-42121b892e7d', 
    'You are holding your lane in slow traffic when another driver begins tailgating and sounding the horn.', 
    'Anda mengekalkan lorong dalam trafik perlahan apabila pemandu di belakang mula mengekori rapat dan membunyikan hon.', 
    '["Maintain your lane position and avoid reacting to the behaviour", "Shift position slightly to signal cooperation and reduce tension", "Change lanes quickly to get away from the situation", "Gesture briefly to show you have noticed the other driver"]', 
    '["Kekalkan kedudukan lorong dan elakkan memberi respons", "Ubah sedikit kedudukan untuk menunjukkan kerjasama dan mengurangkan ketegangan", "Tukar lorong dengan cepat untuk menjauhkan diri daripada situasi", "Buat isyarat ringkas untuk menunjukkan anda sedar akan kehadirannya"]', 
    0, 
    'Holding lane discipline and not reacting helps prevent aggressive situations from escalating.', 
    'Mengekalkan disiplin lorong dan tidak bertindak balas membantu mengelakkan situasi agresif daripada menjadi lebih tegang.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'a3ddb079-2936-4bc4-b29d-8669ad9d1f04', 
    'You spot debris ahead and slow early, while vehicles behind continue approaching at speed.', 
    'Anda terlihat objek di atas jalan di hadapan lalu memperlahankan kenderaan lebih awal, sementara kenderaan di belakang masih menghampiri dengan laju.', 
    '["Ease off smoothly and press brakes smoothly to warn others", "Maintain speed to avoid confusing traffic behind", "Brake later so following vehicles react together", "Slow suddenly once the debris is closer"]', 
    '["Perlahankan kenderaan secara beransur supaya lampu brek memberi amaran kepada kenderaan belakang", "Kekalkan kelajuan supaya tidak mengelirukan trafik di belakang", "Brek kemudian supaya kenderaan belakang bertindak serentak", "Perlahankan kenderaan secara mengejut apabila objek semakin hampir"]', 
    0, 
    'Early slowing with clear signals helps other drivers adjust safely to hazards ahead.', 
    'Memperlahankan kenderaan lebih awal membantu memberi amaran awal kepada pemandu lain dan membolehkan mereka menyesuaikan diri dengan selamat.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.5, "discipline": 0.25, "professionalism": 0.25}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '59f55cc2-6d81-4339-91c6-1b72c686048d', 
    'You have been on duty for 10 hours and are asked to continue working.', 
    'Anda telah bertugas selama 10 jam dan diminta untuk terus bekerja.', 
    '["Continue if the remaining task is short.", "Stop working after reaching the 10-hour limit.", "Work another hour and rest later.", "Continue if traffic conditions are light."]', 
    '["Teruskan jika baki tugasan adalah singkat.", "Hentikan kerja selepas mencapai had 10 jam.", "Bekerja satu jam lagi dan berehat kemudian.", "Teruskan jika keadaan trafik ringan."]', 
    1, 
    'Adhere to the maximum daily working hour limit.', 
    'Patuhi had maksimum waktu kerja harian.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '14e0933b-2193-478f-af47-7afe63fa3224', 
    'While driving, you notice the sun shade and stickers on the windscreen reduce your side visibility.', 
    'Semasa memandu, anda mendapati pelindung matahari dan pelekat pada cermin hadapan mengurangkan penglihatan sisi.', 
    '["Continue driving carefully despite reduced visibility.", "Stop at a safe location and remove or adjust the obstruction.", "Reduce speed and rely more on mirrors.", "Adjust your lane position to compensate for the blind area."]', 
    '["Terus memandu dengan berhati-hati walaupun penglihatan terhad.", "Berhenti di lokasi yang selamat dan tanggalkan/laraskan halangan tersebut.", "Kurangkan kelajuan dan lebih bergantung pada cermin sisi.", "Laraskan kedudukan lorong untuk mengimbangi kawasan yang terhalang."]', 
    1, 
    'Ensure full visibility before continuing to drive safely.', 
    'Pastikan penglihatan jelas sepenuhnya sebelum meneruskan pemanduan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '5df75db6-c41f-4e6f-8b5c-688527a93ca4', 
    'Your goods vehicle is experiencing failure on a highway and assistance has arrived.', 
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan bantuan telah tiba.', 
    '["Leave the vehicle where it stopped since help is present.", "Move the vehicle to a safer location when possible.", "Wait until traffic reduces before relocating.", "Relocate only if other drivers signal it is safe."]', 
    '["Biarkan kenderaan di tempat ia berhenti kerana bantuan telah tiba.", "Alihkan kenderaan ke lokasi yang lebih selamat jika keadaan mengizinkan.", "Tunggu sehingga trafik berkurangan sebelum mengalihkan kenderaan.", "Alihkan hanya jika pemandu lain memberi isyarat selamat."]', 
    1, 
    'Relocate the vehicle to minimise continued traffic exposure.', 
    'Alihkan kenderaan ke lokasi lebih selamat untuk mengurangkan pendedahan berterusan kepada trafik.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '284da40a-9662-481f-a9ed-55de8f78a94d', 
    'You find that the first aid kit is incomplete.', 
    'Anda mendapati kit pertolongan cemas tidak lengkap.', 
    '["Continue if no emergency is expected.", "Replenish the first aid kit before operating.", "Rely on site facilities if needed.", "Inform later after completing the trip."]', 
    '["Teruskan perjalanan jika tiada kecemasan dijangka berlaku.", "Lengkapkan kit pertolongan cemas sebelum mengendalikan kenderaan.", "Bergantung kepada kemudahan di lokasi jika perlu.", "Maklumkan kemudian selepas menamatkan perjalanan."]', 
    1, 
    'Maintain a complete and ready first aid kit at all times.', 
    'Pastikan kit pertolongan cemas sentiasa lengkap dan sedia digunakan pada setiap masa.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'd7685975-6974-4c47-9aba-15eedc026d4f', 
    'Before departure, you conduct a safety inspection.', 
    'Sebelum memulakan perjalanan, anda menjalankan pemeriksaan keselamatan.', 
    '["Focus only on tyres since they wear faster.", "Check brakes, tyres, steering, and vehicle lights.", "Inspect brakes only if carrying heavy cargo.", "Check lights after beginning the journey."]', 
    '["Periksa tayar sahaja kerana ia lebih cepat haus.", "Periksa brek, tayar, stereng dan lampu kenderaan.", "Periksa brek hanya jika membawa muatan berat.", "Periksa lampu selepas memulakan perjalanan."]', 
    1, 
    'Inspect all critical control and lighting systems before driving.', 
    'Periksa semua sistem kawalan dan lampu sebelum memandu.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '241f9a52-c9e0-4f3d-a53a-5a76c4323cd9', 
    'Your driving document will expire in three weeks.', 
    'Dokumen pemanduan anda akan tamat tempoh dalam tiga minggu.', 
    '["Renew it two weeks before expiry.", "Renew it on your next off day.", "Renew it when you have free time.", "Renew it during the expiry week."]', 
    '["Perbaharui dua minggu sebelum tamat tempoh.", "Perbaharui pada hari cuti anda yang seterusnya.", "Perbaharui apabila ada masa lapang.", "Perbaharui pada minggu tamat tempoh."]', 
    0, 
    'Renew required documents at least two weeks before expiry.', 
    'Perbaharui dokumen yang diperlukan sekurang-kurangnya dua minggu sebelum tamat tempoh.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '8a0acf5b-702d-4bb4-afea-5ca4d47012ff', 
    'After completing your assignment, you are returning the vehicle.', 
    'Selepas menamatkan tugasan, anda hendak memulangkan kenderaan.', 
    '["Park the truck at any available space nearby.", "Park the truck at the company''s designated area.", "Leave the truck where it is most convenient.", "Park outside temporarily and inform later."]', 
    '["Parkir lori di mana-mana ruang yang tersedia berhampiran.", "Parkir lori di kawasan yang ditetapkan oleh syarikat.", "Tinggalkan lori di tempat yang paling mudah.", "Parkir di luar buat sementara dan maklumkan kemudian."]', 
    1, 
    'Park company vehicles only at approved locations.', 
    'Parkir kenderaan syarikat hanya di lokasi yang diluluskan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '025cb6a9-5183-44cb-9d3a-b8c132a59e47', 
    'You review the container number, type, and size against the gate pass and delivery note.', 
    'Anda menyemak nombor kontena, jenis dan saiz dengan membandingkannya kepada gate pass dan nota penghantaran.', 
    '["Proceed if the container looks correct.", "Confirm all container details match the documents.", "Check only the container number.", "Deliver first and update discrepancies later."]', 
    '["Teruskan jika kontena kelihatan betul.", "Pastikan semua butiran kontena sepadan dengan dokumen.", "Periksa nombor kontena sahaja.", "Hantar dahulu dan kemas kini perbezaan kemudian."]', 
    1, 
    'Ensure all container details match the official documents.', 
    'Pastikan semua butiran kontena sepadan dengan dokumen rasmi sebelum berlepas.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '6cf67af7-82ff-4164-91e6-3daeedae4789', 
    'You collect a reefer container and observe a worn power cable.', 
    'Anda mengambil kontena berpendingin dari premis pelanggan dan mendapati terdapat kerosakan pada bahagian luar.', 
    '["Record it internally and inform operations.", "Secure the cable and continue.", "Inform operations after delivery.", "Proceed if cooling is active."]', 
    '["Catat dalam rekod dalaman dan maklumkan bahagian operasi.", "Amankan kabel dan teruskan perjalanan.", "Maklumkan kepada bahagian operasi selepas penghantaran selesai.", "Teruskan perjalanan jika sistem penyejukan masih berfungsi."]', 
    0, 
    'Document and report equipment defects before departure.', 
    'Rekodkan dan laporkan kerosakan kontena sebelum meneruskan pergerakan.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'bdb2e174-ba7b-4a97-929d-72b8d3c1857f', 
    'You arrive at the customer site to position the container.', 
    'Anda tiba di tapak pelanggan untuk meletakkan kontena.', 
    '["Position it at the nearest available space.", "Obtain customer approval before positioning.", "Follow previous delivery practice.", "Place it where it is easiest to exit."]', 
    '["Letakkan di ruang terdekat yang tersedia.", "Dapatkan kelulusan pelanggan sebelum meletakkan kontena.", "Ikut amalan penghantaran sebelum ini.", "Letakkan di tempat yang paling mudah untuk keluar."]', 
    1, 
    'Obtain customer approval before positioning the container.', 
    'Dapatkan kelulusan pelanggan sebelum meletakkan kontena.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '29c03e65-95e8-4383-980c-eb722a003846', 
    'A roadside altercation with a member of the public escalates and feels unsafe.', 
    'Berlaku pertelingkahan di tepi jalan dengan orang awam dan keadaan menjadi tidak selamat.', 
    '["Handle the matter personally.", "Go to the nearest police station and report.", "Ignore it and continue driving.", "Confront the individual to settle it."]', 
    '["Uruskan sendiri situasi tersebut.", "Pergi ke balai polis terdekat dan buat laporan.", "Abaikan dan teruskan pemanduan.", "Bersemuka untuk menyelesaikan isu."]', 
    1, 
    'Seek police assistance when safety is threatened.', 
    'Dapatkan bantuan polis apabila keselamatan terancam.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '587a5448-2754-48df-be86-0c7ef8c49749', 
    'While stopped due to a fire on the trailer, flames are visible near the rear section.', 
    'Semasa berhenti akibat kebakaran pada treler, api kelihatan di bahagian belakang.', 
    '["Separate the prime mover from the trailer if safe.", "Keep the unit connected to maintain stability.", "Move the vehicle slightly before taking action.", "Wait to confirm the exact fire source."]', 
    '["Pisahkan kepala lori daripada treler jika keadaan selamat.", "Kekalkan sambungan untuk mengekalkan kestabilan.", "Gerakkan kenderaan sedikit sebelum mengambil tindakan.", "Tunggu untuk mengesahkan punca kebakaran."]', 
    0, 
    'Separate units when safe to reduce fire spread.', 
    'Pisahkan unit jika keadaan selamat untuk mengurangkan risiko api merebak.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);
INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    'ed08d476-aff1-402c-8ce5-d60a29bc5709', 
    'After a collision, operations asks whether the vehicle can be moved.', 
    'Selepas pelanggaran, bahagian operasi bertanya sama ada kenderaan boleh dialihkan.', 
    '["Inform whether the vehicle can be moved or is blocking traffic.", "Move the vehicle without informing anyone.", "Leave it as it is and end the call.", "Decide later after completing documentation."]', 
    '["Maklumkan sama ada kenderaan boleh dialihkan atau sedang menghalang trafik.", "Alihkan kenderaan tanpa memaklumkan kepada sesiapa.", "Biarkan sahaja dan tamatkan panggilan.", "Buat keputusan kemudian selepas melengkapkan dokumen."]', 
    0, 
    'Inform operations about vehicle condition and obstruction status.', 
    'Maklumkan keadaan kenderaan dan sama ada ia menghalang trafik.', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    8, 
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'
);