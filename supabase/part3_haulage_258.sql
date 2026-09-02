-- ==========================================================================
-- SafePass Questions Part 3 of 4: Container Haulage (258 MCQs)
-- ==========================================================================
INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'eddbbbb0-a521-4d16-ac9e-e76b41c377d7',
    NULL,
    'After a collision, operations asks whether the vehicle can be moved.',
    'Selepas pelanggaran, bahagian operasi bertanya sama ada kenderaan boleh dialihkan.',
    '["Inform whether the vehicle can be moved or is blocking traffic.", "Move the vehicle without informing anyone.", "Leave it as it is and end the call.", "Decide later after completing documentation."]'::jsonb,
    '["Maklumkan sama ada kenderaan boleh dialihkan atau sedang menghalang trafik.", "Alihkan kenderaan tanpa memaklumkan kepada sesiapa.", "Biarkan sahaja dan tamatkan panggilan.", "Buat keputusan kemudian selepas melengkapkan dokumen."]'::jsonb,
    0,
    'Inform operations about vehicle condition and obstruction status.',
    'Maklumkan keadaan kenderaan dan sama ada ia menghalang trafik.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fb9e2541-aaff-4e87-aafd-9e8e382bacab',
    NULL,
    'You drive in slow traffic. A driver cuts in and brakes sharply.',
    'Anda memandu dalam trafik perlahan. Seorang pemandu memotong masuk dan membrek secara mengejut.',
    '["Reduce speed smoothly and keep a safe pace", "Maintain speed to avoid being pushed back", "Slow briefly, then speed up to create space", "Adjust speed after traffic settles"]'::jsonb,
    '["Kurangkan kelajuan secara lancar dan kekalkan kelajuan selamat", "Kekalkan kelajuan untuk mengelak daripada didorong ke belakang.", "Perlahankan seketika kemudian tambah kelajuan untuk mewujudkan ruang di hadapan", "Sesuaikan kelajuan selepas trafik kembali stabil"]'::jsonb,
    0,
    'Calm speed control prevents impulsive reactions in frustrating traffic.',
    'Kawalan kelajuan yang tenang membantu mengelakkan tindak balas impulsif dalam trafik.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.25, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f775567d-0d60-40ca-9617-12b3fb21b110',
    NULL,
    'You need to reverse into a tight space in a site yard. Vehicles and equipment move nearby.',
    'Anda perlu mengundur ke ruang sempit di kawasan tapak. Kenderaan dan jentera bergerak berhampiran.',
    '["Stop and reverse only when space and visibility are clear", "Reverse slowly and adjust speed as conditions change", "Complete the manoeuvre to minimise disruption", "Follow nearby vehicles to guide your reversing speed"]'::jsonb,
    '["Berhenti dan undur hanya apabila ruang dan pandangan jelas", "Undur perlahan dan sesuaikan kelajuan mengikut keadaan", "Selesaikan manuver untuk kurangkan gangguan kepada orang lain", "Ikut pergerakan kenderaan berhampiran untuk panduan kelajuan mengundur"]'::jsonb,
    0,
    'Confirm space and visibility before reversing in busy yards.',
    'Pastikan ruang dan pandangan jelas sebelum mengundur di kawasan tapak sibuk.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'eb4b4f6c-a64d-40d0-9187-100e889cd0c6',
    NULL,
    'During unloading, site staff give instructions abruptly while you are positioning the vehicle.',
    'Semasa memunggah muatan, kakitangan tapak memberi arahan secara tiba-tiba ketika anda sedang memposisikan kenderaan.',
    '["Respond minimally and focus only on vehicle positioning", "Acknowledge the instructions and coordinate calmly", "Challenge the tone and clarify who is responsible", "Proceed without engaging further"]'::jsonb,
    '["Jawab secara minimum dan fokus pada posisi kenderaan sahaja", "Akui arahan tersebut dan bekerjasama dengan tenang", "Persoalkan nada arahan dan jelaskan siapa bertanggungjawab", "Teruskan tanpa melibatkan diri"]'::jsonb,
    1,
    'Calm coordination helps tasks run smoothly, even when instructions are delivered abruptly.',
    'Bekerjasama dengan tenang membantu kerja berjalan lancar walaupun arahan diberi secara tiba-tiba.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '52fecefe-706c-4ae1-88d0-f3fa8d9578b9',
    NULL,
    'During unloading, a disagreement with site staff begins to escalate over the unloading sequence.',
    'Semasa proses memunggah, berlaku perbezaan pendapat dengan kakitangan tapak mengenai turutan memunggah muatan dan keadaan mula menjadi tegang.',
    '["Pause unloading until someone else decides the unloading sequence.", "Explain calmly in detail why your unloading sequence is correct and safer.", "Continue unloading quietly to avoid making the situation worse", "Justify your approach so everyone understands your reasoning"]'::jsonb,
    '["Hentikan unloading sehingga orang lain menentukan urutan unloading.", "Terangkan dengan tenang secara terperinci mengapa urutan unloading anda adalah betul dan lebih selamat.", "Teruskan proses memunggah secara senyap untuk elak keadaan menjadi lebih tegang", "Pertahankan cara anda supaya semua faham sebabnya"]'::jsonb,
    1,
    'Calm and respectful communication helps resolve disagreements while maintaining safe unloading operations.',
    'Komunikasi yang tenang dan profesional membantu menyelesaikan perselisihan sambil mengekalkan operasi unloading yang selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4a0a0f16-6b3c-4681-b593-649118293c28',
    NULL,
    'Traffic ahead slows sharply. You increase following distance while vehicles behind close in without warning.',
    'Trafik di hadapan menjadi perlahan secara mendadak. Anda menambah jarak hadapan sementara kenderaan di belakang semakin menghampiri tanpa amaran.',
    '["Reduce speed gradually and maintain a safe following distance", "Maintain speed to avoid confusing drivers behind", "Close the gap to match traffic flow", "Brake later so others are forced to react"]'::jsonb,
    '["Lepaskan pedal minyak lebih awal dan perlahankan kenderaan secara beransur-ansur", "Kekalkan kelajuan supaya tidak mengelirukan pemandu di belakang", "Rapatkan jarak untuk mengikut aliran trafik", "Tekan brek secara mengejut supaya pemandu lain terpaksa bertindak balas"]'::jsonb,
    0,
    'Creating space early and signalling clearly helps others adjust safely to changing traffic conditions.',
    'Mewujudkan ruang lebih awal dan memberi isyarat dengan jelas membantu pemandu lain menyesuaikan diri dengan selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4030fac6-9c76-4930-a76c-dd4978ea8de6',
    NULL,
    'You are dressing for your driving shift.',
    'Anda sedang berpakaian untuk syif pemanduan.',
    '["Wear long trousers as required.", "Wear shorts if the weather is hot.", "Wear track pants for comfort.", "Wear any trousers only when visiting customer sites."]'::jsonb,
    '["Pakai seluar panjang seperti yang ditetapkan.", "Pakai seluar pendek jika cuaca panas.", "Pakai seluar trek untuk keselesaan.", "Pakai apa-apa seluar hanya apabila melawat tapak pelanggan."]'::jsonb,
    0,
    'Wear long trousers as part of required duty attire.',
    'Pakai seluar panjang seperti yang ditetapkan semasa bertugas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6f72dea7-e220-4b71-b992-e1bb6ffe4182',
    NULL,
    'During a delivery, a customer raises their voice and provokes you.',
    'Semasa membuat penghantaran, seorang pelanggan meninggikan suara dan memprovokasi anda.',
    '["Respond firmly to defend your position.", "Avoid confrontation and report to operations.", "Leave the site immediately without informing anyone.", "Continue arguing until the issue is resolved."]'::jsonb,
    '["Bertindak balas dengan tegas untuk mempertahankan diri.", "Elakkan pertelingkahan dan laporkan kepada bahagian operasi.", "Tinggalkan tapak serta-merta tanpa memaklumkan kepada sesiapa.", "Terus berdebat sehingga isu selesai."]'::jsonb,
    1,
    'Do not engage in confrontation; report the matter to operations.',
    'Elakkan pertelingkahan dan laporkan perkara tersebut kepada bahagian operasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6d5d26f1-79e4-43f5-9a24-9bb8c61ecd4b',
    NULL,
    'You position your vehicle in a loading area where forklifts and pedestrians are moving.',
    'Anda meletakkan kenderaan di kawasan pemunggahan di mana forklift dan pejalan kaki sedang bergerak.',
    '["Move forward quickly before equipment approaches", "Position only when the area is clear of movement", "Continue moving slowly and watch for operator signals", "Stop close to the loading area to reduce walking"]'::jsonb,
    '["Bergerak cepat ke hadapan sebelum peralatan menghampiri", "Letakkan kenderaan hanya apabila kawasan itu tiada pergerakan", "Terus bergerak perlahan sambil perhatikan isyarat pengendali", "Berhenti dekat kawasan pemunggahan untuk kurangkan berjalan"]'::jsonb,
    1,
    'Keep clear of active loading zones to reduce collision and injury risk.',
    'Kekalkan jarak dari kawasan pemunggahan aktif untuk mengurangkan risiko pelanggaran dan kecederaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6f2dee1b-3ce1-410d-993b-7d562f175f42',
    NULL,
    'You drive inside a facility. Vehicles queue ahead and forklifts operate near the roadway.',
    'Anda memandu di dalam kawasan fasiliti. Kenderaan beratur di hadapan dan forklift beroperasi berhampiran laluan.',
    '["Increase following distance and keep clear sightlines", "Maintain spacing and close the gap if traffic slows", "Reduce the gap to avoid blocking vehicles behind", "Match the distance used by surrounding vehicles"]'::jsonb,
    '["Tambah jarak kenderaan dan kekalkan pandangan jelas", "Kekalkan jarak dan rapatkan jika trafik perlahan", "Rapatkan jarak untuk elakkan menghalang kenderaan di belakang", "Ikut jarak yang digunakan oleh kenderaan sekeliling"]'::jsonb,
    0,
    'Maintain extra spacing and clear sightlines near operating equipment.',
    'Kekalkan jarak tambahan dan pandangan jelas berhampiran jentera beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fab9788b-3125-435f-970a-8e8b8c572ceb',
    NULL,
    'You plan to install a sun shade, dark tint film, or stickers on the company truck windscreen.',
    'Anda bercadang memasang pelindung matahari, filem gelap, atau pelekat pada cermin hadapan lori syarikat.',
    '["Install them if they do not block the main driving view.", "Do not install them without company approval.", "Use removable shades only during daytime driving.", "Check whether other drivers have done similar modifications."]'::jsonb,
    '["Pasang jika tidak menghalang pandangan utama ketika memandu.", "Jangan pasang tanpa kelulusan syarikat.", "Gunakan pelindung yang boleh ditanggalkan pada waktu siang sahaja.", "Periksa sama ada pemandu lain pernah membuat pengubahsuaian yang sama."]'::jsonb,
    1,
    'Avoid unauthorised vehicle modifications that may affect safety or compliance.',
    'Elakkan pengubahsuaian pada kenderaan tanpa kelulusan yang boleh menjejaskan keselamatan atau pematuhan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '386bb8e1-e5f7-4023-9577-57dcc0168ccc',
    NULL,
    'During inspection, you review emergency and fire equipment in the vehicle.',
    'Semasa pemeriksaan, anda menyemak peralatan kecemasan dan pemadam api di dalam kenderaan.',
    '["Check only for long-distance trips.", "Ensure emergency and fire equipment is complete and valid.", "Assume it is sufficient if previously used.", "Check after starting the trip."]'::jsonb,
    '["Periksa hanya untuk perjalanan jarak jauh.", "Pastikan peralatan kecemasan dan pemadam api lengkap dan masih sah untuk digunakan.", "Anggap mencukupi jika pernah digunakan sebelum ini.", "Periksa selepas memulakan perjalanan."]'::jsonb,
    1,
    'Ensure emergency and fire equipment is complete and valid before driving.',
    'Pastikan peralatan kecemasan dan pemadam api lengkap dan masih sah untuk digunakan sebelum memandu.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3fa040d7-6322-400d-9c63-f7fe022f14fe',
    NULL,
    'After a collision, you are gathering information from the other driver.',
    'Selepas pelanggaran, anda mengumpul maklumat daripada pemandu lain.',
    '["Take the driver\u2019s contact number and identification details.", "Record only the vehicle number.", "Ask them to contact your office directly.", "Leave once traffic clears."]'::jsonb,
    '["Ambil nombor telefon dan butiran pengenalan pemandu tersebut.", "Catat nombor pendaftaran kenderaan sahaja.", "Minta mereka hubungi pejabat anda secara terus.", "Beredar apabila trafik kembali lancar."]'::jsonb,
    0,
    'Obtain necessary contact and identification details.',
    'Dapatkan nombor telefon dan butiran pengenalan yang diperlukan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '70797836-766b-46bb-9b3a-604da782e2ab',
    NULL,
    'Your vehicle catches fire during transit.',
    'Kenderaan anda terbakar semasa dalam perjalanan.',
    '["Inform operations or the company safety team immediately.", "Attempt to control the fire fully before reporting.", "Inform the customer first.", "Report only if damage is severe."]'::jsonb,
    '["Maklumkan kepada bahagian operasi atau pasukan keselamatan syarikat dengan segera.", "Cuba kawal kebakaran sepenuhnya sebelum melaporkan.", "Maklumkan kepada pelanggan terlebih dahulu.", "Laporkan hanya jika kerosakan adalah serius."]'::jsonb,
    0,
    'Report fire incidents immediately.',
    'Laporkan kejadian kebakaran dengan segera.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1d6decda-de5f-43fd-8510-bb434308ed5b',
    NULL,
    'After a collision, operations asks for your location.',
    'Selepas pelanggaran, bahagian operasi meminta lokasi anda.',
    '["Provide the exact location using junctions or landmarks.", "Say you are \u201cnear the highway\u201d.", "Share the location after police arrival.", "Wait for GPS tracking to update automatically."]'::jsonb,
    '["Berikan lokasi tepat dengan menyatakan simpang atau mercu tanda.", "Berikan anggaran lokasi berdasarkan kawasan sekitar.", "Kongsi lokasi selepas polis tiba.", "Tunggu sistem GPS dikemas kini secara automatik."]'::jsonb,
    0,
    'Provide precise accident location details.',
    'Berikan butiran lokasi kemalangan dengan tepat dan jelas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '38b540d1-81c3-4d08-aae1-ed267ff7d286',
    NULL,
    'You drive in steady multi-lane traffic. Motorcycles filter between lanes and traffic slows near an exit.',
    'Anda memandu dalam trafik berbilang lorong yang lancar. Motosikal bergerak di antara lorong dan trafik perlahan berhampiran susur keluar.',
    '["Maintain lane position and prepare for sudden movement", "Change lanes early to avoid slowing traffic", "Hold lane but move closer to the lane marking", "Continue normally and react only if traffic slows"]'::jsonb,
    '["Kekalkan kedudukan lorong dan bersedia untuk pergerakan mengejut", "Tukar lorong lebih awal untuk mengelakkan trafik perlahan", "Kekalkan lorong tetapi bergerak lebih dekat ke garisan lorong", "Teruskan seperti biasa dan bertindak hanya jika trafik perlahan"]'::jsonb,
    0,
    'Maintain stable lane position and anticipate sudden movement.',
    'Kekalkan kedudukan lorong yang stabil dan jangka pergerakan mengejut.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '504558b9-ad9d-42c0-a958-2fde48a7ed9c',
    NULL,
    'You approach a checkpoint inside a facility. Vehicles queue unevenly and lanes split toward inspection points.',
    'Anda menghampiri pusat pemeriksaan di dalam fasiliti. Kenderaan beratur tidak sekata dan lorong berpecah ke beberapa laluan pemeriksaan.',
    '["Remain in your lane and wait for checkpoint direction", "Shift early to a less congested lane", "Move forward and adjust position near the checkpoint", "Follow the vehicle ahead if its lane clears faster"]'::jsonb,
    '["Kekalkan lorong dan tunggu arahan pusat pemeriksaan", "Tukar awal ke lorong yang kurang sesak", "Bergerak ke hadapan dan sesuaikan kedudukan berhampiran pusat pemeriksaan", "Ikut kenderaan di hadapan jika lorongnya bergerak lebih cepat"]'::jsonb,
    0,
    'Remain orderly and wait for checkpoint direction in controlled zones.',
    'Kekalkan pergerakan teratur dan tunggu arahan pusat pemeriksaan di kawasan kawalan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ddc6e940-6317-4e2b-81ed-507dfbba21c4',
    NULL,
    'A customer becomes verbally aggressive after being told the delivery cannot proceed as requested.',
    'Seorang pelanggan bercakap secara agresif selepas dimaklumkan bahawa penghantaran tidak dapat diteruskan seperti diminta.',
    '["Respond firmly to assert your position", "Stay calm, acknowledge concerns, and explain the situation clearly", "End the conversation and walk away", "Repeat company policy without further engagement"]'::jsonb,
    '["Jawab dengan tegas untuk pertahankan pendirian", "Kekal tenang, dengar perkara yang dibangkitkan dan terangkan keadaan dengan jelas", "Tamatkan perbualan dan beredar", "Ulang dasar syarikat tanpa perbincangan lanjut"]'::jsonb,
    1,
    'Staying calm and acknowledging concerns helps prevent escalation and keeps the situation under control.',
    'Kekal tenang dan beri penjelasan yang jelas membantu elakkan keadaan menjadi lebih tegang dan kekalkan kawalan situasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '55497242-6421-46b1-b41d-d3652b6b78d7',
    NULL,
    'During a delivery, a customer explains that a small personal gift is customary in their culture.',
    'Semasa penghantaran, seorang pelanggan menjelaskan bahawa pemberian kecil peribadi adalah amalan dalam budayanya.',
    '["Decline respectfully and continue with the delivery as planned", "Accept briefly to avoid appearing disrespectful", "Delay responding and see how others handle it", "Explain carefully why such gifts can cause problems"]'::jsonb,
    '["Tolak dengan hormat dan teruskan penghantaran seperti dirancang", "Terima seketika supaya tidak kelihatan tidak hormat", "Tangguhkan respons dan lihat bagaimana orang lain bertindak", "Terangkan dengan teliti mengapa pemberian itu boleh menimbulkan isu"]'::jsonb,
    0,
    'Respecting culture does not require accepting gifts that compromise integrity.',
    'Menghormati budaya tidak bermaksud menerima pemberian yang boleh menjejaskan integriti.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e098de22-7cbc-4884-a3f9-a942b2b5823f',
    NULL,
    'You have completed 8 hours of driving for the day and one nearby delivery remains.',
    'Anda telah memandu selama 8 jam pada hari tersebut dan satu penghantaran berhampiran masih belum selesai.',
    '["Continue driving to complete the final delivery.", "Stop driving and report reaching the daily limit.", "Drive for another 30 minutes before stopping.", "Reduce speed and complete the delivery carefully."]'::jsonb,
    '["Terus memandu untuk menyelesaikan penghantaran terakhir.", "Hentikan pemanduan dan laporkan bahawa had harian telah dicapai.", "Memandu lagi selama 30 minit sebelum berhenti.", "Kurangkan kelajuan dan selesaikan penghantaran dengan berhati-hati."]'::jsonb,
    1,
    'Follow driving hour limits to maintain safety and compliance.',
    'Patuhi had waktu pemanduan untuk menjaga keselamatan dan pematuhan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '10626cca-2238-4f5f-a874-a8956d40e0f9',
    NULL,
    'You check the vehicle and the warning triangle is missing.',
    'Anda memeriksa kenderaan dan mendapati segi tiga amaran tiada.',
    '["Continue driving if hazard lights are working.", "Replace the safety triangle before departure.", "Borrow one only when needed.", "Use cones instead of a triangle."]'::jsonb,
    '["Terus memandu jika lampu kecemasan berfungsi.", "Gantikan segi tiga amaran sebelum memulakan perjalanan.", "Pinjam satu hanya apabila diperlukan.", "Gunakan kon sebagai ganti segi tiga amaran."]'::jsonb,
    1,
    'Carry the required warning triangle before operating.',
    'Bawa segi tiga amaran yang diperlukan sebelum mengendalikan kenderaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '70c9b888-8af6-44bb-abd5-0c9889c66fc9',
    NULL,
    'After a delivery, you notice the recorded details do not fully match what occurred.',
    'Selepas penghantaran, anda mendapati butiran yang direkod tidak sepenuhnya sepadan dengan apa yang berlaku.',
    '["Clarify the discrepancy and update the records accurately", "Leave the records unchanged to avoid reopening the discussion", "Add brief notes later so the paperwork roughly reflects events", "Ask someone else to adjust the documents if needed"]'::jsonb,
    '["Jelaskan perbezaan dan kemas kini rekod dengan tepat", "Biarkan rekod seperti itu untuk elakkan perbincangan dibuka semula", "Tambah catatan ringkas kemudian supaya dokumen lebih kurang mencerminkan keadaan sebenar", "Minta orang lain mengubah dokumen jika perlu"]'::jsonb,
    0,
    'Correct records promptly to ensure accuracy and prevent misunderstandings.',
    'Betulkan rekod dengan segera untuk memastikan ketepatan dan mengelakkan salah faham.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3111258d-4262-4da8-bf01-27d9d96df073',
    NULL,
    'In a public area, a bystander becomes upset about where your vehicle is stopped.',
    'Di kawasan awam, seorang individu berasa tidak puas hati tentang lokasi kenderaan anda berhenti.',
    '["Stay quiet and wait for the bystander to calm down", "Explain calmly in detail why the stop is necessary and allowed", "Avoid engagement and continue the task to prevent escalation", "Justify your position firmly so the complaint does not continue"]'::jsonb,
    '["Berdiam diri dan tunggu sehingga orang itu bertenang", "Terangkan dengan terperinci mengapa berhenti di situ perlu dan dibenarkan", "Elakkan berinteraksi dan teruskan tugas", "Pertahankan posisi anda dengan tegas supaya aduan tidak berlanjutan"]'::jsonb,
    1,
    'Calm acknowledgement helps ease public tension and prevents situations from escalating.',
    'Respons yang tenang dan jelas membantu redakan ketegangan dan elakkan keadaan menjadi lebih serius.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '635eae69-567c-429e-9417-6610eaebb9a8',
    NULL,
    'Your goods vehicle is experiencing failure at night and you need to step out.',
    'Kenderaan barangan anda mengalami kerosakan pada waktu malam dan anda perlu keluar dari kenderaan.',
    '["Exit quickly to place warning devices.", "Wear a safety vest before exiting.", "Stand beside the vehicle and observe traffic.", "Use your phone light while walking behind the vehicle."]'::jsonb,
    '["Keluar dengan segera untuk meletakkan alat amaran.", "Pakai jaket keselamatan sebelum keluar.", "Berdiri di sebelah kenderaan dan perhatikan trafik.", "Gunakan lampu telefon bimbit semasa berjalan di belakang kenderaan."]'::jsonb,
    1,
    'Ensure personal visibility before exiting to reduce roadside risk.',
    'Pastikan anda mudah dilihat sebelum keluar bagi mengurangkan risiko di tepi jalan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f4e71d35-ebd0-414c-94c5-6ea2a5e84ec4',
    NULL,
    'You drive inside an industrial site where equipment operates near the roadway.',
    'Anda memandu di dalam kawasan industri di mana jentera beroperasi berhampiran laluan.',
    '["Reduce speed early and keep extra clearance from equipment", "Maintain pace and adjust if equipment enters your path", "Continue slowly to pass before equipment repositions", "Follow the vehicle ahead past the equipment"]'::jsonb,
    '["Kurangkan kelajuan lebih awal dan kekalkan jarak daripada jentera", "Kekalkan kelajuan dan sesuaikan jika jentera memasuki laluan anda", "Terus bergerak perlahan untuk melepasi sebelum jentera beralih", "Ikut kenderaan di hadapan melepasi jentera"]'::jsonb,
    0,
    'Reduce speed early and keep clear of operating equipment.',
    'Kurangkan kelajuan lebih awal dan kekalkan jarak dari jentera beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7f9e2af9-684a-425e-b335-d0af611fda8d',
    NULL,
    'You arrive at a customer site to uncouple the trailer on uneven, soft ground.',
    'Anda tiba di tapak pelanggan untuk membuka sambungan treler di atas permukaan tanah yang tidak rata dan lembut.',
    '["Lower the landing legs carefully and check stability after uncoupling.", "Place strong wooden planks under the landing legs before uncoupling.", "Adjust the trailer position slightly to find firmer ground before uncoupling.", "Ask site staff to observe the trailer during the process."]'::jsonb,
    '["Turunkan kaki sokongan dengan berhati-hati dan periksa kestabilan selepas membuka sambungan.", "Letakkan papan kayu yang kukuh di bawah kaki sokongan sebelum membuka sambungan.", "Laraskan sedikit kedudukan treler untuk mencari tanah yang lebih kukuh sebelum membuka sambungan.", "Minta kakitangan tapak memerhati treler semasa proses tersebut."]'::jsonb,
    1,
    'Ensure stable ground support before uncoupling to prevent trailer instability.',
    'Pastikan sokongan tanah stabil sebelum membuka sambungan bagi mengelakkan treler menjadi tidak stabil.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0bbaf7d8-1ec1-47f3-9930-b01509cd4869',
    NULL,
    'You notice a mismatch between the seal number and the gate pass record.',
    'Anda mendapati nombor seal tidak sepadan dengan rekod pada gate pass.',
    '["Proceed if the container is sealed.", "Report to operations for further instruction.", "Correct the document yourself.", "Continue if the customer is waiting."]'::jsonb,
    '["Teruskan jika kontena telah dimeterai.", "Laporkan kepada bahagian operasi untuk arahan selanjutnya.", "Betulkan dokumen sendiri.", "Teruskan perjalanan jika pelanggan sedang menunggu."]'::jsonb,
    1,
    'Report any container or seal discrepancy before proceeding.',
    'Laporkan sebarang perbezaan pada kontena atau seal sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ad977396-48e9-42db-8bfd-208cafc6a862',
    NULL,
    'You collect a container from a customer premise and notice exterior damage.',
    'Anda mengambil sebuah kontena dari premis pelanggan dan mendapati terdapat kerosakan pada bahagian luarnya.',
    '["Record it internally and inform operations.", "Inform the customer and proceed.", "Continue if the container is sealed.", "Deliver first and update later."]'::jsonb,
    '["Catat dalam rekod dalaman dan maklumkan bahagian operasi.", "Maklumkan pelanggan dan teruskan perjalanan.", "Teruskan jika kontena telah dimeterai.", "Hantar dahulu dan kemas kini kemudian."]'::jsonb,
    0,
    'Record and report container damage before movement.',
    'Rekodkan dan laporkan kerosakan kontena sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c26b69bb-2c5e-4d6b-850d-0c2a2f6cb80b',
    NULL,
    'Before departure, you notice there is no seal on the container.',
    'Sebelum bertolak, anda mendapati tiada seal pada kontena.',
    '["Install any available seal and continue.", "Report to operations and wait for instruction.", "Proceed if the cargo appears secured.", "Inform the customer after delivery."]'::jsonb,
    '["Pasang mana-mana seal yang ada dan teruskan perjalanan.", "Laporkan kepada bahagian operasi dan tunggu arahan lanjut.", "Teruskan perjalanan jika muatan kelihatan selamat.", "Maklumkan kepada pelanggan selepas penghantaran."]'::jsonb,
    1,
    'Report missing seals and wait for operations instruction',
    'Laporkan seal yang tiada dan tunggu arahan selanjutnya dari operasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '47ec2ede-4154-41c4-9f9e-b082d2ca6155',
    NULL,
    'You are hauling a loaded export container to the designated port.',
    'Anda sedang membawa kontena eksport yang telah dimuatkan ke pelabuhan yang ditetapkan.',
    '["Drive directly to the port without unnecessary stops.", "Stop briefly for personal errands.", "Park overnight and continue the next day.", "Divert to another site before heading to port."]'::jsonb,
    '["Pandu terus ke pelabuhan tanpa membuat hentian yang tidak perlu.", "Berhenti seketika untuk urusan peribadi.", "Parkir semalaman dan sambung perjalanan pada hari berikutnya.", "Singgah ke tapak lain sebelum ke pelabuhan."]'::jsonb,
    0,
    'Haul export containers directly to the designated port unless emergency arises.',
    'Bawa kontena eksport terus ke pelabuhan yang ditetapkan kecuali berlaku kecemasan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1228760b-2714-4f3e-9454-231c3665e8f4',
    NULL,
    'You drive inside a terminal lane where RTG lifting and yard vehicles are moving.',
    'Anda memandu di laluan terminal di mana RTG beroperasi dan kenderaan yard sedang bergerak.',
    '["Maintain speed and pass while watching the RTG", "Reduce speed early and pass cautiously", "Continue at moderate speed and adjust if equipment moves closer", "Slow slightly but keep moving to avoid delaying traffic"]'::jsonb,
    '["Kekalkan kelajuan dan lalu sambil memerhati RTG", "Kurangkan kelajuan lebih awal dan lalu dengan berhati-hati", "Teruskan pada kelajuan sederhana dan laras jika RTG menghampiri", "Perlahankan sedikit tetapi terus bergerak untuk elakkan kelewatan trafik"]'::jsonb,
    1,
    'Reduce speed early near lifting activity to manage sudden equipment movement safely.',
    'Kurangkan kelajuan lebih awal berhampiran aktiviti jentera untuk mengendalikan  pergerakan jentera secara selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9f989211-bae8-4cb9-9224-1cc466d2d88b',
    NULL,
    'At a container terminal, lifting operations are in progress. Vehicles and personnel move nearby.',
    'Di terminal kontena, operasi mengangkat kontena sedang dijalankan. Kenderaan dan pekerja bergerak berhampiran.',
    '["Keep clear of the lifting zone until the operation ends", "Move closer to observe the lift and prepare to move", "Wait nearby and approach when the container is almost down", "Move forward carefully to avoid delaying trucks behind"]'::jsonb,
    '["Jauhi zon pengangkatan sehingga operasi selesai", "Bergerak lebih dekat untuk memerhati operasi pengangkatan dan bersedia bergerak", "Tunggu berhampiran dan hampiri apabila kontena hampir diturunkan", "Bergerak ke hadapan dengan berhati-hati supaya tidak melambatkan lori di belakang"]'::jsonb,
    0,
    'Stay clear of lifting zones to avoid sudden movement and falling objects.',
    'Kekalkan jarak dari zon pengangkatan untuk elakkan pergerakan mengejut dan risiko objek jatuh.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c07489eb-9c20-4cd1-abbc-bec6cddcfd9e',
    NULL,
    'At a container depot or terminal, lifting operations are in progress and you enter a marked lifting zone without a safety helmet.',
    'Di terminal atau depot kontena, operasi pengangkatan kontena sedang dijalankan dan anda memasuki zon pengangkatan tanpa topi keselamatan.',
    '["Put on the required PPE and remain clear of lifting", "Stay where you are since equipment is not moving toward you", "Move quickly through the area to minimise time", "Wait for terminal or depot staff instructions before addressing PPE"]'::jsonb,
    '["Pakai PPE yang diperlukan dan kekal jauh dari operasi loading", "Kekal di tempat kerana jentera tidak bergerak ke arah anda", "Bergerak cepat melalui kawasan itu untuk kurangkan masa", "Tunggu arahan kakitangan terminal atau depot sebelum mengurus PPE"]'::jsonb,
    0,
    'Wear required PPE and keep clear of lifting zones.',
    'Pakai PPE yang diperlukan dan kekalkan jarak dari zon loading.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'aeb186d3-ebc1-4468-8f1c-e99fd8183f23',
    NULL,
    'Your driving document will expire in three weeks.',
    'Dokumen pemanduan anda akan tamat tempoh dalam tiga minggu.',
    '["Renew it two weeks before expiry.", "Renew it on your next off day.", "Renew it when you have free time.", "Renew it during the expiry week."]'::jsonb,
    '["Perbaharui dua minggu sebelum tamat tempoh.", "Perbaharui pada hari cuti anda yang seterusnya.", "Perbaharui apabila ada masa lapang.", "Perbaharui pada minggu tamat tempoh."]'::jsonb,
    0,
    'Renew required documents at least two weeks before expiry.',
    'Perbaharui dokumen yang diperlukan sekurang-kurangnya dua minggu sebelum tamat tempoh.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7e17240a-ed3a-4520-93bd-49e9728d7b60',
    NULL,
    'You position your vehicle in a loading area where forklifts are operating.',
    'Anda meletakkan kenderaan di Kawasan memuat/memunggah barang di mana forklift sedang beroperasi.',
    '["Move forward quickly and stop near loading", "Stop at a safe distance and proceed when clear", "Continue moving and rely on forklift guidance", "Park as close as possible despite limited space"]'::jsonb,
    '["Bergerak cepat ke hadapan dan berhenti berhampiran kawasan memuat/memunggah barang", "Berhenti pada jarak selamat dan bergerak apabila laluan sudah jelas", "Terus bergerak dan bergantung pada panduan forklift", "Parkir sedekat mungkin walaupun ruang terhad"]'::jsonb,
    1,
    'Keep a safe distance from active loading zones to reduce collision risk.',
    'Kekalkan jarak selamat dari kawasan kawasan pemuatan aktif untuk mengurangkan risiko pelanggaran.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1cd2c37b-3f46-4a46-aefa-ed9d351d2c78',
    NULL,
    'After a pre-trip inspection, you feel an unusual vibration while driving.',
    'Selepas pemeriksaan sebelum perjalanan, anda merasakan getaran tidak biasa semasa memandu.',
    '["Stop and recheck the vehicle before continuing", "Continue driving since the inspection showed no problems", "Complete the trip and report it at the end of the shift", "Ignore it unless a warning indicator appears"]'::jsonb,
    '["Berhenti dan periksa semula kenderaan", "Terus memandu kerana pemeriksaan awalan dizbuat", "Selesaikan perjalanan dan laporkan pada akhir syif", "Abaikan kecuali lampu amaran muncul"]'::jsonb,
    0,
    'Unusual vehicle behaviour requires immediate checking.',
    'Perubahan mekanikal kenderaan perlu diperiksa segera.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c3f62a29-e447-423f-8ddb-1e7c5e28685a',
    NULL,
    'While driving, the engine feels strained during acceleration though no warning lights appear.',
    'Semasa memandu, enjin terasa kurang responsive semasa memecut walaupun tiada lampu amaran menyala.',
    '["Ease acceleration and monitor the condition", "Maintain normal acceleration since no lights show", "Increase engine output to test the response", "Continue driving and act only if it worsens"]'::jsonb,
    '["Kurangkan pecutan dan pantau keadaan", "Kekalkan pecutan kerana tiada lampu amaran", "Tingkatkan kuasa enjin untuk menguji tindak balas", "Terus memandu dan bertindak hanya jika keadaan bertambah teruk"]'::jsonb,
    0,
    'Respond early to unusual vehicle performance.',
    'Bertindak awal apabila prestasi kenderaan tidak biasa.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '876ef303-166e-4637-89b7-368d69f86bce',
    NULL,
    'You notice a large piece of debris on the road ahead while vehicles behind are approaching quickly.',
    'Anda terlihat serpihan besar di jalan di hadapan ketika kenderaan di belakang menghampiri dengan laju.',
    '["Ease off smoothly and press brakes smoothly to warn others", "Maintain speed to avoid confusing traffic behind", "Brake later so following vehicles react together", "Slow suddenly once the debris is closer"]'::jsonb,
    '["Perlahankan kenderaan  secara beransur supaya lampu brek memberi amaran kepada kenderaan belakang", "Kekalkan kelajuan supaya tidak mengelirukan trafik di belakang", "Brek kemudian supaya kenderaan belakang bertindak serentak", "Perlahankan kenderaan secara mengejut apabila objek semakin hampir"]'::jsonb,
    0,
    'Early slowing with clear signals helps other drivers adjust safely to hazards ahead.',
    'Memperlahankan kenderaan lebih awal membantu memberi amaran awal kepada pemandu lain dan membolehkan mereka menyesuaikan diri dengan selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.25, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a11c2a87-17b7-426b-9af0-f01b729bca8d',
    NULL,
    'Your goods vehicle is experiencing failure on a highway and you are placing safety cones behind it.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda sedang meletakkan kon keselamatan di belakangnya.',
    '["Place cones a few metres behind the vehicle to alert nearby traffic.", "Position cones to the rear, spaced about 10 metres apart.", "Place one cone directly behind the vehicle as a marker.", "Set the cones beside the vehicle to save time."]'::jsonb,
    '["Letakkan kon beberapa meter di belakang kenderaan untuk memberi amaran kepada trafik berhampiran.", "Letakkan kon di bahagian belakang dengan jarak kira-kira 10 meter antara satu sama lain.", "Letakkan satu kon tepat di belakang kenderaan sebagai penanda.", "Letakkan kon di sisi kenderaan untuk menjimatkan masa."]'::jsonb,
    1,
    'Position warning devices correctly to provide clear rear hazard warning.',
    'Letakkan alat amaran dengan jarak yang sesuai untuk memberi amaran yang jelas kepada trafik dari belakang.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f97aec3c-96cb-431a-ad7d-a457913b2947',
    NULL,
    'You approach a busy site exit joining a public road. Space is tight and reversing may be needed to realign.',
    'Anda menghampiri pintu keluar tapak yang bersambung dengan jalan awam. Ruang sempit dan mungkin perlu mengundur untuk melaras kedudukan.',
    '["Edge forward to secure position and adjust if needed", "Stop, assess, and reverse slowly under control", "Use the horn and continue moving", "Reverse quickly before vehicles arrive"]'::jsonb,
    '["Bergerak sedikit ke hadapan untuk mendapatkan kedudukan", "Berhenti, nilai keadaan, dan undur perlahan dengan kawalan", "Gunakan hon dan terus bergerak", "Undur dengan cepat sebelum kenderaan tiba"]'::jsonb,
    1,
    'Stop and maintain full control before reversing near junctions.',
    'Berhenti dan kekalkan kawalan penuh sebelum mengundur berhampiran persimpangan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4798c9b7-a783-4c39-8ac2-fc53b1a5ac17',
    NULL,
    'During unloading, a tense exchange with site staff starts attracting attention from people nearby.',
    'Semasa proses memunggah, perbualan tegang dengan kakitangan tapak mula menarik perhatian orang di sekeliling.',
    '["Keep your tone calm and behaviour professional", "Raise your voice to make sure everyone understands your position", "Continue the task while limiting further interaction", "Justify your response to avoid appearing at fault"]'::jsonb,
    '["Kekalkan nada tenang dan tingkah laku profesional", "Tinggikan suara supaya semua orang memahami pendirian anda", "Teruskan tugas sambil hadkan interaksi lanjut", "Jelaskan respons anda untuk elak kelihatan bersalah"]'::jsonb,
    0,
    'Maintaining calm, professional behaviour protects your image when situations draw public attention.',
    'Kekalkan sikap tenang dan profesional apabila situasi menarik perhatian orang ramai.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '76376b42-c79e-49df-b8c2-b6ad592dbb06',
    NULL,
    'While driving, a member of the public provokes you aggressively.',
    'Semasa memandu, seorang orang awam bertindak agresif dan memprovokasi anda.',
    '["React quickly to assert your position.", "Remain calm and report the incident.", "Stop and confront the person.", "Follow the person to clarify the issue."]'::jsonb,
    '["Bertindak segera untuk mempertahankan pendirian anda.", "Kekal tenang dan laporkan kejadian tersebut.", "Berhenti dan bersemuka dengan individu tersebut.", "Ikut individu tersebut untuk menjelaskan keadaan."]'::jsonb,
    1,
    'Avoid impulsive actions and report the incident appropriately.',
    'Kekal tenang dan laporkan kejadian dengan cara yang sesuai.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8dab3ec4-cb85-4073-bf6b-5bd57707f407',
    NULL,
    'You intend to change lanes, but another driver in your blind spot appears unsure of your intention',
    'Anda bercadang untuk menukar lorong, namun pemandu di titik buta kelihatan tidak pasti tentang niat anda.',
    '["Signal early and wait until the other driver responds before moving", "Drift slightly to indicate intention and move when space appears", "Check mirrors again and change lanes once traffic slows", "Hold position and change lanes later without signalling"]'::jsonb,
    '["Beri isyarat awal dan tunggu sehingga diberi ruang", "Hanyut sedikit ke sisi untuk menunjukkan niat dan masuk apabila ada ruang", "Periksa cermin sekali lagi dan tukar lorong apabila trafik menjadi perlahan", "Kekalkan kedudukan dan tukar lorong kemudian tanpa memberi isyarat"]'::jsonb,
    0,
    'Clear signalling helps other drivers understand your intention and reduces uncertainty during lane changes.',
    'Isyarat yang jelas membantu pemandu lain memahami niat anda dan mengurangkan ketidakpastian semasa menukar lorong.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b201673d-41e7-468f-b5d6-8794865540c8',
    NULL,
    'You are about to start driving the vehicle.',
    'Anda hendak memulakan pemanduan kenderaan.',
    '["Fasten the seat belt before moving.", "Drive first and fasten it later.", "Wear it only on highways.", "Use it only when carrying heavy cargo."]'::jsonb,
    '["Pakai tali pinggang keledar sebelum bergerak.", "Mula memandu dan pakai kemudian.", "Pakai hanya di lebuh raya.", "Pakai hanya apabila membawa muatan berat."]'::jsonb,
    0,
    'Always wear the seat belt before driving.',
    'Pakai tali pinggang keledar sebelum memandu.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '19dc119a-fdb1-4cdc-939a-bf2297f03420',
    NULL,
    'Following a collision, what photographic evidence should you collect?',
    'Selepas pelanggaran, bukti gambar apakah yang perlu anda ambil?',
    '["Photos of the scene and vehicles involved.", "Only your own vehicle damage.", "A photo after vehicles are moved.", "No photos if witnesses are present."]'::jsonb,
    '["Gambar lokasi kejadian dan kenderaan yang terlibat.", "Gambar kerosakan kenderaan anda sahaja.", "Gambar selepas kenderaan dialihkan.", "Tidak perlu ambil gambar jika ada saksi."]'::jsonb,
    0,
    'Take clear photos of the accident scene and vehicles.',
    'Ambil gambar yang jelas bagi lokasi kejadian dan kenderaan yang terlibat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'dafc8220-cb7d-4cef-b0b3-7b7d78376f62',
    NULL,
    'You drive inside a depot with marked lanes. Equipment operates nearby and stacked loads restrict visibility.',
    'Anda memandu di dalam depot dengan lorong bertanda. Jentera beroperasi berhampiran dan susunan muatan menghadkan pandangan.',
    '["Keep to the marked lane and slow until movement is clear", "Adjust position to see past the equipment", "Continue moving so you do not block equipment behind", "Proceed as usual and rely on operators"]'::jsonb,
    '["Kekalkan lorong bertanda dan perlahankan sehingga pergerakan jelas", "Sesuaikan kedudukan untuk melihat melepasi jentera", "Terus bergerak supaya tidak menghalang jentera di belakang", "Teruskan seperti biasa dan bergantung pada pengendali jentera"]'::jsonb,
    0,
    'Keep lane discipline and reduce speed near operating equipment.',
    'Amalkan disiplin lorong dan kurangkan kelajuan berhampiran peralatan beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd2890435-bfcd-4eb2-9f65-f7d50d48709b',
    NULL,
    'Your vehicle is carrying chemical cargo and is involved in an accident.',
    'Kenderaan anda membawa muatan bahan kimia dan terlibat dalam kemalangan.',
    '["Inform operations of the cargo type and any hazard risk.", "Report the vehicle damage.", "Wait for emergency responders to identify the cargo.", "Mention cargo details when asked."]'::jsonb,
    '["Maklumkan kepada bahagian operasi jenis muatan dan sebarang risiko bahaya.", "Laporkan kerosakan kenderaan.", "Tunggu pasukan kecemasan mengenal pasti jenis muatan.", "Nyatakan butiran muatan bila ditanya."]'::jsonb,
    0,
    'Communicate cargo hazards immediately during an accident.',
    'Maklumkan risiko bahaya muatan dengan segera semasa kemalangan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c9b792f3-f01b-46f6-9144-9610f7a4188a',
    NULL,
    'You drive at night in heavy rain on a downhill road. Visibility is reduced and vehicles ahead slow unpredictably.',
    'Anda memandu pada waktu malam dalam hujan lebat di jalan menurun. Pandangan terhad dan kenderaan di hadapan memperlahan secara tidak menentu.',
    '["Reduce speed early for higher risk conditions", "Maintain speed and rely on headlights and braking", "Slow slightly and adjust if visibility worsens", "Keep pace with the vehicle ahead"]'::jsonb,
    '["Kurangkan kelajuan lebih awal kerana keadaan berisiko tinggi", "Kekalkan kelajuan dan bergantung pada lampu serta brek", "Perlahankan sedikit dan sesuaikan kelajuan jika pandangan semakin terhad", "Ikut kelajuan kenderaan di hadapan"]'::jsonb,
    0,
    'Reduce speed in poor visibility to maintain time and control.',
    'Kurangkan kelajuan apabila pandangan terhad untuk kekalkan masa dan kawalan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5c4b770b-9be3-4c12-b294-7f11b92cdc16',
    NULL,
    'You are in an active loading area during heavy rain. Surfaces are wet and equipment operates nearby.',
    'Anda berada di kawasan pemuatan aktif semasa hujan lebat. Permukaan basah dan jentera beroperasi berhampiran.',
    '["Stay clear of the loading area until conditions stabilise", "Proceed carefully while adjusting pace for the weather", "Move closer to monitor equipment movement", "Continue approaching so loading can proceed"]'::jsonb,
    '["Kekal jauh dari kawasan pemuatan sehingga keadaan stabil", "Teruskan dengan berhati-hati sambil laraskan kelajuan", "Bergerak lebih dekat untuk memantau pergerakan jentera", "Terus menghampiri supaya proses pemuatan boleh diteruskan"]'::jsonb,
    0,
    'Keep clear of loading activity when weather increases risk.',
    'Kekalkan jarak dari aktiviti pemuatan apabila keadaan cuaca meningkatkan risiko.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '07103f7e-2ccb-412e-b453-d7e43d662277',
    NULL,
    'A customer questions a delivery delay and speaks to you in a frustrated tone.',
    'Seorang pelanggan mempersoalkan kelewatan penghantaran dan bercakap dengan nada tidak puas hati.',
    '["Respond briefly and focus on completing the delivery", "Explain the situation calmly and confirm the next steps", "Defend your actions and point out factors beyond your control", "Avoid discussion and request the customer to contact the office"]'::jsonb,
    '["Jawab secara ringkas dan fokus selesaikan penghantaran", "Terangkan keadaan dengan tenang dan sahkan langkah seterusnya", "Pertahankan tindakan anda dan jelaskan faktor di luar kawalan", "Elakkan perbincangan dan minta pelanggan berhubung dengan pejabat"]'::jsonb,
    1,
    'Calm, clear explanation helps reduce frustration and keeps the interaction professional.',
    'Penjelasan yang tenang dan jelas membantu kurangkan ketegangan dan kekalkan profesionalisme.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a7dca4da-cc35-4a9e-8c10-db48cabc4065',
    NULL,
    'During a delivery, a customer begins recording your interaction on a mobile phone.',
    'Semasa penghantaran, seorang pelanggan mula merakam interaksi anda menggunakan telefon bimbit.',
    '["Continue the discussion calmly and professionally", "Ask the customer to stop recording before continuing", "Keep responses brief and focus on completing the task", "Proceed with the delivery without acknowledging the recording"]'::jsonb,
    '["Teruskan perbincangan dengan tenang dan profesional", "Minta pelanggan berhenti merakam sebelum meneruskan", "Jawab secara ringkas dan fokus untuk selesaikan tugas", "Teruskan penghantaran tanpa mengendahkan rakaman"]'::jsonb,
    0,
    'Maintaining professional behaviour protects your image when interactions are visible or recorded.',
    'Kekalkan tingkah laku profesional apabila interaksi dirakam atau dilihat orang lain.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6b5757b0-d4f9-4e4c-b356-de594f1e42c6',
    NULL,
    'You have been on duty for 10 hours and are asked to continue working.',
    'Anda telah bertugas selama 10 jam dan diminta untuk terus bekerja.',
    '["Continue if the remaining task is short.", "Stop working after reaching the 10-hour limit.", "Work another hour and rest later.", "Continue if traffic conditions are light."]'::jsonb,
    '["Teruskan jika baki tugasan adalah singkat.", "Hentikan bekerja selepas mencapai had 10 jam.", "Bekerja satu jam lagi dan berehat kemudian.", "Teruskan jika keadaan trafik tidak sibuk."]'::jsonb,
    1,
    'Adhere to the maximum daily working hour limit.',
    'Patuhi had maksimum waktu kerja harian.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2758da1b-2b7b-4ce4-9333-bdaf124ad75a',
    NULL,
    'During a routine pre-trip inspection, what should you check?',
    'Semasa pemeriksaan pra-perjalanan rutin, apakah yang perlu anda periksa?',
    '["Skip the check if the engine started normally.", "Verify the engine system as part of the safety inspection.", "Check only when warning lights appear.", "Inspect the engine only during scheduled servicing."]'::jsonb,
    '["Abaikan pemeriksaan jika enjin dapat dihidupkan seperti biasa.", "Sahkan sistem enjin sebagai sebahagian daripada pemeriksaan keselamatan.", "Periksa hanya apabila lampu amaran menyala.", "Periksa enjin hanya semasa servis berjadual."]'::jsonb,
    1,
    'Include engine system checks in daily safety inspections.',
    'Periksa sistem enjin setiap hari sebagai sebahagian daripada pemeriksaan keselamatan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '25828416-ebd8-47a8-bac2-367a8f50771a',
    NULL,
    'You move from an internal roadway toward a loading area. Obstructions and movement change around you.',
    'Anda bergerak dari laluan dalaman menuju kawasan pemunggahan. Halangan dan pergerakan berubah di sekeliling.',
    '["Slow early and adjust your path to surrounding movement", "Maintain pace and react when a hazard appears", "Focus on the path ahead and reassess inside", "Follow vehicles ahead that pass smoothly"]'::jsonb,
    '["Perlahankan kenderaan lebih awal dan sesuaikan laluan mengikut pergerakan sekitar", "Kekalkan kelajuan dan bertindak apabila bahaya muncul", "Fokus pada laluan di hadapan dan nilai semula selepas masuk", "Ikut kenderaan di hadapan yang melalui kawasan dengan lancar"]'::jsonb,
    0,
    'Anticipate early and adjust space to avoid sudden reactions.',
    'Jangka lebih awal dan sesuaikan ruang untuk elakkan tindak balas mengejut.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '778af142-b572-4dfe-9b4a-bfe5d1cd66ea',
    NULL,
    'During a roadside inspection, an officer approaches and you realise you are not wearing a safety vest.',
    'Semasa pemeriksaan di tepi jalan, seorang pegawai menghampiri dan anda sedar anda tidak memakai vest keselamatan.',
    '["Put on the safety vest and cooperate with the inspection", "Continue the inspection and wear it if instructed", "Answer the officer\u2019s questions and address it later", "Remain where you are until the inspection ends"]'::jsonb,
    '["Pakai vest keselamatan dan beri kerjasama semasa pemeriksaan", "Teruskan pemeriksaan dan pakai jika diarahkan", "Jawab soalan pegawai dan uruskan kemudian", "Kekal di tempat anda sehingga pemeriksaan selesai"]'::jsonb,
    0,
    'Wear required safety equipment during inspections.',
    'Pakai peralatan keselamatan yang diperlukan semasa pemeriksaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '508a9a7b-42b7-4509-8583-0732dcc6a711',
    NULL,
    'In a public area, people nearby are watching and filming while you interact with others.',
    'Di kawasan awam, orang di sekeliling memerhati dan merakam semasa anda berinteraksi dengan orang lain.',
    '["Keep your behaviour calm and professional throughout", "Explain your actions clearly so observers understand your position", "Limit interaction and focus on finishing the task", "Respond firmly to avoid appearing uncertain"]'::jsonb,
    '["Kekalkan tingkah laku tenang dan profesional sepanjang masa", "Terangkan tindakan anda supaya orang yang memerhati faham", "Hadkan interaksi dan fokus selesaikan tugas", "Beri respons dengan tegas supaya tidak kelihatan ragu-ragu"]'::jsonb,
    0,
    'Professional behaviour matters most when actions are visible to the public.',
    'Tingkah laku profesional amat penting apabila tindakan anda dapat dilihat oleh orang awam.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b61b4f2c-021c-4d04-9a7b-ba4140de14cd',
    NULL,
    'Before entering an unfamiliar delivery location, you are unsure whether there is enough space to exit safely.',
    'Sebelum memasuki lokasi penghantaran yang tidak dikenali, anda tidak pasti sama ada terdapat ruang yang mencukupi untuk keluar dengan selamat.',
    '["Confirm a safe exit route before entering.", "Enter slowly and decide on the exit after unloading.", "Ask the customer for directions after parking.", "Enter if there appears to be enough space to turn around."]'::jsonb,
    '["Pastikan laluan keluar yang selamat sebelum memasuki kawasan tersebut.", "Masuk dengan perlahan dan tentukan laluan keluar selepas selesai memunggah.", "Tanya pelanggan arah keluar selepas meletakkan kenderaan.", "Masuk jika kelihatan mempunyai ruang yang mencukupi untuk berpusing."]'::jsonb,
    0,
    'Plan a safe exit route before entering unfamiliar locations to reduce the risk of reversing hazards and vehicle damage.',
    'Rancang laluan keluar yang selamat sebelum memasuki lokasi yang tidak dikenali bagi mengurangkan risiko mengundur dan kerosakan pada kenderaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7e340a6b-229a-43bf-ac21-0e7f6542cecb',
    NULL,
    'What makes good photographic evidence?',
    'Apakah yang menjadikan bukti bergambar yang baik?',
    '["Clear photos showing the condition from several angles", "One close-up photo only", "Photos edited to highlight the damage", "Photos taken after the goods have been moved"]'::jsonb,
    '["Gambar yang jelas menunjukkan keadaan barang dari beberapa sudut", "Satu gambar jarak dekat sahaja", "Gambar yang telah disunting untuk menonjolkan kerosakan", "Gambar yang diambil selepas barang dialihkan"]'::jsonb,
    0,
    'Clear photographs from multiple angles provide stronger evidence for delivery verification and damage investigations.',
    'Ambil gambar yang jelas dari beberapa sudut sebagai bukti yang kukuh.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6e53a5f7-0d72-4756-ae89-7b66a682a195',
    NULL,
    'Before starting a trip, you check the prime mover and trailer documents.',
    'Sebelum memulakan perjalanan, anda menyemak dokumen kepala lori dan treler.',
    '["Ensure the permit, road tax, and inspection certificate are valid.", "Proceed if the road tax is still valid.", "Check only the prime mover documents.", "Verify documents only when stopped by enforcement."]'::jsonb,
    '["Pastikan permit, cukai jalan dan sijil pemeriksaan masih sah.", "Teruskan perjalanan jika cukai jalan masih sah.", "Periksa dokumen kepala lori sahaja.", "Sahkan dokumen hanya apabila ditahan penguat kuasa."]'::jsonb,
    0,
    'Ensure all required vehicle documents are valid before operating.',
    'Pastikan semua dokumen kenderaan yang diperlukan masih sah sebelum beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6d971338-d1fd-4e19-b44e-7a5737e25d4a',
    NULL,
    'Before departing with a container, you notice visible damage on its exterior.',
    'Anda akan bertolak dengan sebuah kontena namun mendapati terdapat kerosakan yang jelas pada bahagian luarnya.',
    '["Proceed since the container is already sealed.", "Record the damage in the required document.", "Inform the customer verbally and continue.", "Proceed if the cargo inside appears intact."]'::jsonb,
    '["Teruskan perjalanan kerana kontena telah dimeterai.", "Rekodkan kerosakan dalam dokumen yang diperlukan.", "Maklumkan pelanggan secara lisan dan teruskan perjalanan.", "Teruskan jika muatan di dalam kelihatan baik."]'::jsonb,
    1,
    'Record any container damage before proceeding.',
    'Rekodkan sebarang kerosakan kontena sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '96df4425-7ee0-4f15-9ede-60233035e85f',
    NULL,
    'Before exiting the port with an import container, you observe a small hole and cut mark.',
    'Sebelum keluar dari pelabuhan dengan kontena import, anda mendapati terdapat lubang kecil dan kesan potongan pada kontena.',
    '["Record the condition in the gate pass.", "Deliver first and report later.", "Ignore it if cargo is not exposed.", "Inform the customer upon arrival."]'::jsonb,
    '["Rekodkan keadaan tersebut pada gate pass.", "Hantar dahulu dan laporkan kemudian.", "Abaikan jika muatan tidak terdedah.", "Maklumkan kepada pelanggan apabila tiba."]'::jsonb,
    0,
    'Declare any container damage in the gate pass before departure.',
    'Isytiharkan sebarang kerosakan kontena pada gate pass sebelum berlepas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '174b4d86-45da-478d-9aa3-3de07b9e79d9',
    NULL,
    'At the customer site, the container door appears misaligned.',
    'Di premis pelanggan, pintu kontena kelihatan tidak sejajar.',
    '["Record it internally and inform operations.", "Lock it and continue.", "Deliver first and explain later.", "Adjust it without reporting."]'::jsonb,
    '["Catat dalam rekod dalaman dan maklumkan bahagian operasi.", "Kunci pintu dan teruskan perjalanan.", "Hantar dahulu dan jelaskan kemudian.", "Laraskan tanpa melaporkan."]'::jsonb,
    0,
    'Report container defects before moving.',
    'Laporkan kecacatan kontena sebelum meneruskan pergerakan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a1d4c0e9-013b-4a6f-aaec-c9a62fc45653',
    NULL,
    'You are uncertain about the extent of container or cargo damage.',
    'Anda tidak pasti tahap kerosakan pada kontena atau muatan di dalamnya.',
    '["Proceed cautiously and monitor during transit.", "Seek operations approval before movement.", "Inform the customer and continue.", "Move the container to a nearby safe area first."]'::jsonb,
    '["Teruskan perjalanan dengan berhati-hati dan pantau semasa perjalanan.", "Dapatkan kelulusan daripada bahagian operasi sebelum bergerak.", "Maklumkan kepada pelanggan dan teruskan perjalanan.", "Alihkan kontena ke kawasan selamat berhampiran terlebih dahulu."]'::jsonb,
    1,
    'Do not move the container without operations approval when damage is unclear.',
    'Jangan gerakkan kontena tanpa kelulusan bahagian operasi apabila tahap kerosakan tidak jelas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '269cd484-efa1-4cd9-9d89-8169cf38020f',
    NULL,
    'While driving on a highway, you notice smoke coming from the trailer.',
    'Semasa memandu di lebuh raya, anda mendapati asap keluar dari treler.',
    '["Stop at a safe roadside area without blocking traffic.", "Continue slowly to reach the nearest rest area.", "Stop immediately in the current lane.", "Park close to nearby buildings for assistance."]'::jsonb,
    '["Berhenti di kawasan tepi jalan yang selamat tanpa menghalang trafik.", "Teruskan memandu perlahan untuk sampai ke kawasan rehat terdekat.", "Berhenti serta-merta di lorong semasa.", "Parkir berhampiran bangunan untuk mendapatkan bantuan."]'::jsonb,
    0,
    'Stop in a safe open area that does not obstruct traffic.',
    'Berhenti di kawasan terbuka yang selamat dan tidak menghalang trafik.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9bc3bcb7-c58b-455b-ad38-f35a419b0533',
    NULL,
    'You have worked six consecutive days and are scheduled for another duty.',
    'Anda telah bekerja selama enam hari berturut-turut dan dijadualkan untuk bertugas lagi.',
    '["Continue working if you feel fit.", "Take one rest day after six working days.", "Work half a day before taking leave.", "Swap shifts without taking a rest day."]'::jsonb,
    '["Terus bekerja jika anda berasa cergas.", "Ambil satu hari rehat selepas enam hari bekerja.", "Bekerja separuh hari sebelum mengambil cuti.", "Tukar syif tanpa mengambil hari rehat."]'::jsonb,
    1,
    'Take the required rest day after six consecutive working days.',
    'Ambil hari rehat yang ditetapkan selepas bekerja enam hari berturut-turut.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'dacf40de-f017-4b69-a802-ef2e6453f4c7',
    NULL,
    'You find that the first aid kit is incomplete.',
    'Anda mendapati kit pertolongan cemas tidak lengkap.',
    '["Continue if no emergency is expected.", "Replenish the first aid kit before operating.", "Rely on site facilities if needed.", "Inform later after completing the trip."]'::jsonb,
    '["Teruskan perjalanan jika tiada kecemasan dijangka berlaku.", "Lengkapkan kit pertolongan cemas sebelum mengendalikan kenderaan.", "Bergantung kepada kemudahan di lokasi jika perlu.", "Maklumkan kemudian selepas menamatkan perjalanan."]'::jsonb,
    1,
    'Maintain a complete and ready first aid kit at all times.',
    'Pastikan kit pertolongan cemas sentiasa lengkap dan sedia digunakan pada setiap masa.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd397579b-cce2-4535-8d2c-6b49077f5a5e',
    NULL,
    'Before departure, you conduct a safety inspection.',
    'Semasa pemeriksaan pra-perjalanan rutin, apakah yang perlu anda periksa?',
    '["Focus only on tyres since they wear faster.", "Check brakes, tyres, steering, and vehicle lights.", "Inspect brakes only if carrying heavy cargo.", "Check lights after beginning the journey."]'::jsonb,
    '["Periksa tayar sahaja kerana ia lebih cepat haus.", "Periksa brek, tayar, stereng dan lampu kenderaan.", "Periksa brek hanya jika membawa muatan berat.", "Periksa lampu selepas memulakan perjalanan."]'::jsonb,
    1,
    'Inspect all critical control and lighting systems before driving.',
    'Periksa semua sistem kawalan dan lampu sebelum memandu.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5ea5f9a6-98f6-4e2c-bbcc-e750765ed536',
    NULL,
    'You approach a site entrance from a public road. The access lane is narrow and partially obstructed.',
    'Anda menghampiri pintu masuk tapak dari jalan awam. Laluan masuk sempit dan sebahagiannya terhalang.',
    '["Maintain speed to avoid blocking traffic behind", "Slow early and proceed when the path is clear", "Move closer to assess space before stopping", "Enter the access lane and adjust position inside"]'::jsonb,
    '["Kekalkan kelajuan untuk elakkan menghalang trafik di belakang", "Perlahankan awal dan masuk apabila laluan jelas", "Bergerak lebih dekat untuk menilai ruang sebelum berhenti", "Masuk ke laluan dan laraskan kedudukan di dalam"]'::jsonb,
    1,
    'Slow early and confirm the path is clear before entering a constrained access point.',
    'Perlahankan kenderaan lebih awal dan pastikan laluan jelas sebelum memasuki laluan sempit.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '28ae38a9-2a2a-481e-bfa6-f897442fb483',
    NULL,
    'You are involved in a road collision.',
    'Anda terlibat dalam pelanggaran jalan raya.',
    '["Record the third party\u2019s vehicle type and registration number.", "Record only the third party\u2019s phone number.", "Take photos of the damage without recording vehicle details.", "Ask someone help to record the information for you."]'::jsonb,
    '["Catat jenis kenderaan dan nombor pendaftaran pihak ketiga.", "Catat nombor telefon pihak ketiga sahaja.", "Ambil gambar kerosakan tanpa merekod butiran kenderaan.", "Minta pertolongan orang lain mencatat maklumat bagi pihak anda."]'::jsonb,
    0,
    'Record vehicle type and registration details.',
    'Catat jenis kenderaan dan nombor pendaftaran dengan tepat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ab3277ca-89fe-49b0-94aa-4605a1224801',
    NULL,
    'You follow a slow vehicle on a busy road. Traffic flows on the adjacent lane.',
    'Anda mengekori kenderaan yang perlahan di jalan sibuk. Trafik bergerak lancar di lorong sebelah.',
    '["Wait for a clearly safe gap before overtaking", "Overtake quickly to avoid staying behind", "Move closer to signal your intent", "Begin overtaking and adjust as traffic responds"]'::jsonb,
    '["Tunggu ruang yang benar-benar selamat sebelum memotong", "Memotong dengan cepat supaya tidak terus terperangkap", "Bergerak lebih dekat untuk memberi isyarat niat", "Mulakan memotong dan sesuaikan kedudukan mengikut trafik"]'::jsonb,
    0,
    'Manage frustration and wait for a clearly safe gap before overtaking.',
    'Kawal rasa marah dan tunggu ruang yang benar-benar selamat sebelum memotong.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e8d51419-18dd-4b56-88e5-59597580e42d',
    NULL,
    'Before starting duty, you are choosing your footwear.',
    'Sebelum memulakan tugas, anda memilih kasut untuk dipakai.',
    '["Wear covered shoes for duty.", "Wear slippers for short-distance trips.", "Wear sandals if driving locally.", "Change into shoes only when entering a site."]'::jsonb,
    '["Pakai kasut bertutup semasa bertugas.", "Pakai selipar untuk perjalanan jarak dekat.", "Pakai sandal jika memandu di kawasan setempat.", "Tukar kepada kasut hanya apabila memasuki tapak."]'::jsonb,
    0,
    'Wear proper shoes while on duty.',
    'Pakai kasut yang sesuai semasa bertugas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a11b63be-be9c-43a7-9170-386bd1e46d07',
    NULL,
    'You approach an industrial access road. Surfaces are uneven, obstructions present, and visibility is reduced.',
    'Anda menghampiri laluan masuk kawasan industri. Permukaan jalan tidak rata, terdapat halangan, dan pandangan terhad.',
    '["Reduce speed early and adjust your path for hazards", "Maintain a cautious pace and react if conditions worsen", "Proceed steadily while focusing on the access route", "Follow the vehicle ahead navigating the area"]'::jsonb,
    '["Kurangkan kelajuan lebih awal dan sesuaikan laluan untuk elakkan bahaya", "Kekalkan kelajuan berhati-hati dan bertindak jika keadaan bertambah buruk", "Terus bergerak secara stabil sambil fokus pada laluan utama", "Ikut kenderaan di hadapan yang melalui kawasan itu"]'::jsonb,
    0,
    'Adjust early to surface and visibility risks to maintain control.',
    'Sesuaikan pemanduan lebih awal terhadap risiko permukaan dan pandangan untuk kekalkan kawalan kenderaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a665addd-424f-41b0-8351-5e839fd480b5',
    NULL,
    'At a junction, you prepare to turn while another vehicle approaches from the side and appears unsure of your intention.',
    'Di simpang jalan, anda bersedia untuk membelok apabila sebuah kenderaan dari sisi kelihatan tidak pasti tentang niat anda.',
    '["Signal early and complete the turn when it is safe", "Roll forward slightly to indicate you intend to go", "Wait longer to see how the other driver reacts", "Turn once there is space to avoid delaying traffic behind"]'::jsonb,
    '["Beri isyarat awal dan belok apabila selamat", "Gerak sedikit ke hadapan untuk menunjukkan niat", "Tunggu lebih lama untuk melihat reaksi pemandu lain", "Belok apabila ada ruang untuk mengelakkan kelewatan di belakang"]'::jsonb,
    0,
    'Clear signalling at junctions helps other drivers understand your intention and reduces uncertainty.',
    'Isyarat yang jelas di simpang membantu pemandu lain memahami niat anda dan mengurangkan ketidakpastian.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '411fcd97-5e0b-424a-88d8-2949070a9af8',
    NULL,
    'Before starting your shift, you notice dark tint film and stickers on part of the windscreen.',
    'Sebelum memulakan syif, anda mendapati terdapat filem gelap dan pelekat pada sebahagian cermin hadapan.',
    '["Leave them since they were already installed.", "Remove or report them because they may obstruct visibility.", "Start driving and adjust your seating position instead.", "Ignore them as long as the road ahead is visible."]'::jsonb,
    '["Biarkan kerana ia telah dipasang sebelum ini.", "Tanggalkan atau laporkan kerana ia boleh menghalang penglihatan.", "Mulakan pemanduan dan laraskan kedudukan tempat duduk.", "Abaikan selagi jalan di hadapan masih kelihatan."]'::jsonb,
    1,
    'Address unauthorised modifications to protect visibility and vehicle safety.',
    'Tangani pengubahsuaian tanpa kelulusan untuk menjaga penglihatan dan keselamatan kenderaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '096f6f8a-bc3e-4cb3-8863-161abd3cb7f3',
    NULL,
    'You are selected for a random blood and urine test during duty.',
    'Anda dipilih untuk menjalani ujian darah dan air kencing secara rawak semasa bertugas.',
    '["Cooperate and undergo the test as required.", "Request to postpone the test to another day.", "Refuse the test because it is unlawful.", "Agree only if other drivers are tested first."]'::jsonb,
    '["Berikan kerjasama dan jalani ujian tersebut seperti yang dikehendaki.", "Minta supaya ujian ditangguhkan ke hari lain.", "Tolak ujian tersebut kerana ia tidak sah di sisi undang-undang.", "Bersetuju hanya jika pemandu lain diuji terlebih dahulu."]'::jsonb,
    0,
    'Comply with random substance testing as required.',
    'Patuhi ujian saringan bahan terlarang secara rawak seperti yang ditetapkan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '405b7aff-fc6c-456f-8c62-4c29ee707b9f',
    NULL,
    'A roadside altercation with a member of the public escalates and feels unsafe.',
    'Berlaku pertelingkahan di tepi jalan dengan orang awam dan keadaan menjadi tidak selamat.',
    '["Handle the matter personally.", "Go to the nearest police station and report.", "Ignore it and continue driving.", "Confront the individual to settle it."]'::jsonb,
    '["Uruskan sendiri situasi tersebut.", "Pergi ke balai polis terdekat dan buat laporan.", "Abaikan dan teruskan pemanduan.", "Bersemuka untuk menyelesaikan isu."]'::jsonb,
    1,
    'Seek police assistance when safety is threatened.',
    'Dapatkan bantuan polis apabila keselamatan terancam.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'db9bb77d-3d1b-4067-9d26-6682f07b8af1',
    NULL,
    'While parked in a public area, a bystander hints that a small payment could allow special access.',
    'Semasa parkir di kawasan awam, seorang individu menyatakan bahawa bayaran kecil boleh membolehkan akses khas.',
    '["Decline politely and continue following normal procedures", "Consider the request since it may avoid inconvenience to others", "Delay responding and see if the situation resolves itself", "Suggest discussing the matter later to keep things moving"]'::jsonb,
    '["Tolak dengan sopan dan ikut prosedur biasa", "Pertimbangkan permintaan itu kerana mungkin elakkan kesulitan", "Tangguhkan respons dan lihat perkembangan keadaan", "Cadangkan bincang perkara itu kemudian supaya urusan dapat diteruskan"]'::jsonb,
    0,
    'Refusing improper offers protects integrity and maintains public trust.',
    'Menolak tawaran yang tidak sesuai membantu kekalkan integriti dan kepercayaan orang awam.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4269fa60-bb99-4635-9466-0854064fbe3b',
    NULL,
    'Your goods vehicle is experiencing failure on a highway and you have stopped on the left shoulder.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda telah berhenti di bahu jalan sebelah kiri.',
    '["Remain inside and assess the situation first.", "Switch on the hazard lights immediately.", "Call your supervisor before taking further action.", "Step out briefly to check approaching traffic."]'::jsonb,
    '["Kekal di dalam kenderaan dan nilai keadaan terlebih dahulu.", "Hidupkan lampu kecemasan dengan segera.", "Hubungi penyelia sebelum mengambil tindakan lanjut.", "Keluar sebentar untuk memeriksa trafik yang menghampiri."]'::jsonb,
    1,
    'Activate hazard lights promptly to alert approaching traffic.',
    'Hidupkan lampu kecemasan segera untuk memberi amaran kepada pengguna jalan lain.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f9d608f7-b360-4f47-94d1-d3e78b84907c',
    NULL,
    'Inside a site yard, you merge into an internal lane while equipment operates nearby.',
    'Di dalam kawasan tapak, anda perlu masuk ke lorong dalaman sementara jentera beroperasi berhampiran.',
    '["Wait for a clear gap with safe equipment clearance", "Merge when a small gap appears to maintain flow", "Move forward gradually to secure space", "Follow the vehicle ahead into the lane"]'::jsonb,
    '["Tunggu ruang jelas dengan jarak selamat daripada jentera", "Masuk apabila terdapat ruang kecil untuk kekalkan aliran trafik", "Bergerak ke hadapan secara beransur untuk mendapatkan ruang", "Ikut kenderaan di hadapan masuk ke lorong"]'::jsonb,
    0,
    'Choose a clear gap and keep safe distance from operating equipment.',
    'Tunggu ruang yang jelas dan kekalkan jarak selamat dari jentera beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '49bfb780-cdcb-4c0e-91da-2a96269771e7',
    NULL,
    'While reversing to park, your phone receives a message.',
    'Semasa mengundur untuk parkir, telefon anda menerima mesej.',
    '["Ignore the message and complete the manoeuvre", "Pause and check the message before continuing", "Continue reversing while glancing at the phone", "Stop midway and respond to the message"]'::jsonb,
    '["Abaikan mesej dan selesaikan manuver", "Berhenti seketika dan periksa mesej sebelum meneruskan", "Terus mengundur sambil melihat telefon", "Berhenti separuh jalan dan balas mesej"]'::jsonb,
    0,
    'Avoid device use during manoeuvres.',
    'Elakkan penggunaan telefon semasa manuver.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bdb965ee-d96b-4f79-8fa6-21a55bcc8770',
    NULL,
    'At the end of your shift, the vehicle cabin is cluttered with items.',
    'Pada akhir syif, kabin kenderaan berselerak dengan barang.',
    '["Tidy the cabin and leave it ready for the next driver", "Leave the cabin since the shift has ended", "Remove personal items and clean it the next shift", "Clean only if the next driver is known"]'::jsonb,
    '["Kemas kabin dan sediakan untuk pemandu seterusnya", "Biarkan kabin kerana syif telah tamat", "Ambil barang peribadi dan kemakan kabin keesokan hari", "Bersihkan hanya jika pemandu seterusnya dikenali"]'::jsonb,
    0,
    'Leave the cabin orderly for the next user.',
    'Tinggalkan kabin dalam keadaan kemas untuk pengguna seterusnya.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e70f1b9a-0cba-461f-b029-c53efd162a0a',
    NULL,
    'During a delivery, a cultural misunderstanding causes tension between you and the customer.',
    'Semasa penghantaran, berlaku salah faham berkaitan budaya yang menyebabkan ketegangan antara anda dan pelanggan.',
    '["Acknowledge the concern respectfully and respond calmly", "Explain your intentions in detail to clear the misunderstanding", "Step back from the discussion to prevent further discomfort", "Defend your position to avoid being seen as disrespectful"]'::jsonb,
    '["Ambil maklum dengan hormat dan beri respons dengan tenang", "Terangkan niat anda dengan terperinci untuk jelaskan salah faham", "Undur diri daripada perbincangan untuk elak keadaan menjadi lebih tidak selesa", "Pertahankan pendirian supaya tidak dianggap tidak hormat"]'::jsonb,
    0,
    'Respectful acknowledgement and calm response help ease tension caused by misunderstandings.',
    'Pengakuan yang hormat dan respons yang tenang membantu redakan ketegangan akibat salah faham.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '48cdbf9c-691d-4c77-b9a7-a2d3f5362e51',
    NULL,
    'After an accident, operations asks about injuries.',
    'Selepas kemalangan, bahagian operasi bertanya tentang kecederaan.',
    '["Confirm injuries to yourself and others involved.", "Say everyone seems fine without checking.", "Wait for medical staff to assess first.", "Report injuries after confirmed by hospital."]'::jsonb,
    '["Sahkan kecederaan kepada diri sendiri dan pihak yang terlibat.", "Maklumkan semua kelihatan baik tanpa membuat pemeriksaan.", "Tunggu petugas perubatan membuat penilaian terlebih dahulu.", "Laporkan kecederaan selepas disahkan oleh pihak hospital."]'::jsonb,
    0,
    'Provide accurate injury status information promptly.',
    'Berikan maklumat status kecederaan dengan tepat dan segera.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '70441b58-25f2-45b5-8827-1650397528ba',
    NULL,
    'You drive at night in heavy rain. Spray from vehicles ahead reduces visibility.',
    'Anda memandu pada waktu malam dalam keadaan hujan lebat. Percikan air dari kenderaan di hadapan mengurangkan pandangan.',
    '["Increase following distance for more reaction time", "Maintain distance since traffic speed is steady", "Close the gap to keep sight of the vehicle ahead", "Keep the same distance and react if traffic slows"]'::jsonb,
    '["Tambah jarak kenderaan untuk lebih masa bertindak", "Kekalkan jarak kerana kelajuan trafik stabil", "Rapatkan jarak untuk mengekalkan pandangan kenderaan di hadapan", "Kekalkan jarak dan bertindak jika trafik perlahan"]'::jsonb,
    0,
    'Increase spacing in poor visibility to manage sudden slowing safely.',
    'Tingkatkan jarak antara kenderaan Ketika penglihatan terhad bagi menangani tindakan brek mengejut dengan selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd9b2859c-7cd0-49b5-a793-78b4575db692',
    NULL,
    'A customer asks you to change the delivery details on the paperwork.',
    'Pelanggan meminta anda mengubah maklumat penghantaran pada dokumen.',
    '["Complete the paperwork accurately and explain the situation.", "Adjust the delivery details as requested by the customer.", "Consider changing the paperwork to avoid delaying the delivery.", "Agree to the customer''s request before checking whether the paperwork should be changed."]'::jsonb,
    '["Lengkapkan dokumen dengan maklumat yang tepat dan jelaskan keadaan sebenar.", "Ubah maklumat penghantaran seperti yang diminta oleh pelanggan.", "Pertimbangkan untuk mengubah dokumen bagi mengelakkan kelewatan penghantaran.", "Bersetuju dengan permintaan pelanggan sebelum memastikan sama ada dokumen perlu diubah."]'::jsonb,
    0,
    'Accurate documentation ensures transparency and protects everyone involved.',
    'Dokumen yang tepat memastikan ketelusan dan melindungi semua pihak yang terlibat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a00640a4-9c37-4680-8de6-4c2bdeef3aed',
    NULL,
    'You arrive at a delivery location and realise the only exit requires reversing a fully loaded vehicle.',
    'Anda tiba di lokasi penghantaran dan mendapati satu-satunya laluan keluar memerlukan anda mengundur kenderaan yang masih penuh dengan muatan.',
    '["Reassess the approach before proceeding further.", "Continue and reverse out carefully after the delivery.", "Ask someone nearby to guide the reversing manoeuvre.", "Complete the delivery first to avoid delaying the schedule."]'::jsonb,
    '["Nilai semula laluan sebelum meneruskan perjalanan.", "Teruskan dan undur keluar dengan berhati-hati selepas selesai penghantaran.", "Minta seseorang berhampiran membantu mengarah semasa mengundur.", "Selesaikan penghantaran dahulu bagi mengelakkan kelewatan jadual."]'::jsonb,
    0,
    'Avoid situations that require unnecessary reversing by planning vehicle positioning before entering.',
    'Elakkan situasi yang memerlukan pengunduran yang tidak perlu dengan merancang kedudukan kenderaan sebelum memasuki sesuatu kawasan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '106f20d1-fc16-465b-a3ab-e7a3c5d194a6',
    NULL,
    'You arrive at a factory 30 minutes before your scheduled unloading appointment. All loading bays are occupied.',
    'Anda tiba di sebuah kilang 30 minit lebih awal daripada waktu temujanji unloading. Semua loading bay sedang digunakan.',
    '["Park at the designated waiting area and wait for your assigned slot", "Queue at the factory entrance until a bay becomes available", "Sound your horn to let the gate know you have arrived", "Stop on the roadside near the entrance while waiting"]'::jsonb,
    '["Parkir di kawasan menunggu yang ditetapkan dan tunggu giliran anda", "Beratur di pintu masuk kilang sehingga loading bay tersedia", "Bunyikan hon untuk memaklumkan pengawal bahawa anda telah tiba", "Berhenti di tepi jalan berhampiran pintu masuk sementara menunggu"]'::jsonb,
    0,
    'Follow the site''s appointment and waiting procedures. Early arrival does not guarantee earlier unloading.',
    'Ikuti prosedur temujanji dan kawasan menunggu di premis. Datang awal tidak bermaksud unloading akan dibuat lebih awal.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '247b774b-43d5-4616-a038-1eee112baceb',
    NULL,
    'You arrive at a customer''s premises for delivery.',
    'Anda tiba di premis pelanggan untuk membuat penghantaran.',
    '["Register at the guardhouse, wear the visitor pass and proceed as instructed", "Walk directly to the receiving office to save time", "Follow another visitor without registering", "Enter the warehouse once the gate is open"]'::jsonb,
    '["Daftar di pondok pengawal, pakai pas pelawat dan ikut arahan", "Terus ke pejabat penerimaan untuk menjimatkan masa", "Ikut pelawat lain masuk tanpa mendaftar", "Masuk ke gudang sebaik sahaja pintu pagar dibuka"]'::jsonb,
    0,
    'Follow site access procedures and maintain professional conduct at all times.',
    'Patuhi prosedur kemasukan premis dan sentiasa bersikap profesional.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e8f0b6ab-421c-469f-9bbd-ab9cff8b5f8e',
    NULL,
    'Your company or customer requires photographic evidence during a delivery. What should you do?',
    'Syarikat atau pelanggan memerlukan bukti bergambar semasa penghantaran. Apakah yang perlu anda lakukan?',
    '["Take the required photographs before completing the delivery", "Take photographs only if damage is found", "Take photographs only if the customer requests them on site", "Skip the photographs if the delivery is completed successfully"]'::jsonb,
    '["Ambil gambar yang diperlukan sebelum melengkapkan penghantaran", "Ambil gambar hanya jika terdapat kerosakan", "Ambil gambar hanya jika diminta oleh pelanggan di premis", "Tidak perlu mengambil gambar jika penghantaran berjaya diselesaikan"]'::jsonb,
    0,
    'When photographic evidence is required by the company or customer, it must be taken as part of the delivery process.',
    'Ambil gambar apabila dikehendaki oleh syarikat atau pelanggan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3869e60c-3fcf-4c58-b772-0104d2580900',
    NULL,
    'Before departure, you review the prime mover and trailer documents. One document has expired.',
    'Sebelum memulakan perjalanan, anda menyemak dokumen kepala lori dan treler. Salah satu dokumen telah tamat tempoh.',
    '["Proceed if the other documents are still valid.", "Inform operations and do not operate until resolved.", "Continue the trip and update after delivery.", "Drive and renew the document at the next service."]'::jsonb,
    '["Teruskan perjalanan jika dokumen lain masih sah.", "Maklumkan bahagian operasi dan jangan beroperasi sehingga diselesaikan.", "Teruskan perjalanan dan kemas kini selepas penghantaran selesai.", "Memandu dahulu dan perbaharui dokumen pada servis seterusnya."]'::jsonb,
    1,
    'Do not operate if required vehicle documents have expired and inform operations immediately.',
    'Jangan beroperasi jika dokumen kenderaan yang diperlukan telah tamat tempoh dan maklumkan kepada bahagian operasi segera.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4ac6c669-1759-48bd-9ef1-3d552f4ebb5b',
    NULL,
    'Before leaving the port, you check the container seal.',
    'Sebelum meninggalkan pelabuhan, anda memeriksa seal kontena.',
    '["Proceed if the seal appears attached.", "Ensure the seal is properly locked before departure.", "Leave immediately if the container door is closed.", "Rely on port staff to confirm the seal."]'::jsonb,
    '["Teruskan perjalanan jika seal kelihatan terpasang.", "Pastikan seal dikunci dengan betul sebelum bertolak.", "Bertolak segera jika pintu kontena telah ditutup.", "Bergantung kepada kakitangan pelabuhan untuk mengesahkan seal."]'::jsonb,
    1,
    'Ensure the container seal is securely locked before departure.',
    'Pastikan seal kontena dikunci dengan selamat sebelum bertolak.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '309197cf-388f-49a5-aeab-745a065dbc30',
    NULL,
    'You notice a crack, repair mark, and slight bulging on an import container panel.',
    'Anda mendapati terdapat rekahan, kesan pembaikan dan sedikit bonjolan pada panel sebuah kontena import.',
    '["Record the condition in the gate pass.", "Proceed if the door locks properly.", "Report only if damage worsens.", "Assume it was previously declared."]'::jsonb,
    '["Rekodkan keadaan tersebut pada gate pass.", "Teruskan perjalanan jika pintu boleh dikunci dengan baik.", "Laporkan hanya jika kerosakan menjadi lebih teruk.", "Anggap keadaan tersebut telah diisytiharkan sebelum ini."]'::jsonb,
    0,
    'Record abnormal container conditions in the gate pass.',
    'Rekodkan sebarang keadaan kontena yang tidak normal pada gate pass sebelum bertolak/meneruskan perjalanan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2cde87b7-bdb5-4029-962e-63ce5c497f63',
    NULL,
    'Before exiting the port, you compare the container number in the EIR/gate pass with the customs form and delivery note.',
    'Sebelum keluar dari pelabuhan, anda membandingkan nombor kontena dalam EIR atau gate pass dengan borang kastam dan nota penghantaran.',
    '["Proceed if the container type looks correct.", "Ensure all documents show the same container number.", "Check the number only at delivery point.", "Rely on port staff verification."]'::jsonb,
    '["Teruskan perjalanan jika jenis kontena kelihatan betul.", "Pastikan semua dokumen menunjukkan nombor kontena yang sama.", "Semak nombor hanya di lokasi penghantaran.", "Bergantung kepada pengesahan kakitangan pelabuhan."]'::jsonb,
    1,
    'Confirm container numbers match across all documents before exit.',
    'Pastikan nombor kontena sepadan dalam semua dokumen sebelum keluar dari pelabuhan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd9d7f2d1-4ea1-43d7-be3c-d6c0059c2624',
    NULL,
    'Before pulling a loaded export container, you inspect the seal.',
    'Sebelum menarik kontena eksport yang telah dimuatkan, anda memeriksa seal.',
    '["Ensure the container is sealed before departure.", "Proceed if the container door is locked.", "Seal it later at the port.", "Rely on warehouse staff confirmation."]'::jsonb,
    '["Pastikan kontena telah dipasang seal sebelum bertolak.", "Teruskan perjalanan jika pintu kontena telah dikunci.", "Pasang seal kemudian apabila tiba di pelabuhan.", "Bergantung kepada pengesahan kakitangan gudang."]'::jsonb,
    0,
    'Ensure export containers are properly sealed before movement.',
    'Pastikan kontena eksport dipasang seal dengan betul sebelum pergerakan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fe65e322-8cea-4c10-bcfe-af918dd9abc0',
    NULL,
    'While stopped due to a fire on the trailer, flames are visible near the rear section.',
    'Semasa berhenti akibat kebakaran pada treler, api kelihatan di bahagian belakang.',
    '["Separate the prime mover from the trailer if safe.", "Keep the unit connected to maintain stability.", "Move the vehicle slightly before taking action.", "Wait to confirm the exact fire source."]'::jsonb,
    '["Pisahkan kepala lori daripada treler jika keadaan selamat.", "Kekalkan sambungan untuk mengekalkan kestabilan.", "Gerakkan kenderaan sedikit sebelum mengambil tindakan.", "Tunggu untuk mengesahkan punca kebakaran."]'::jsonb,
    0,
    'Separate units when safe to reduce fire spread.',
    'Pisahkan unit jika keadaan selamat untuk mengurangkan risiko api merebak.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '513cd1f0-902d-4289-beb1-e3a58b9a8bfc',
    NULL,
    'You arrive at a terminal gate where security officers are checking vehicle documents before allowing entry.',
    'Anda tiba di pintu masuk terminal. Pegawai keselamatan sedang memeriksa dokumen kenderaan sebelum membenarkan kenderaan masuk.',
    '["Wait in your lane and present the required documents when requested.", "Move to another lane with fewer vehicles.", "Hand over only the documents requested by the customer.", "Enter the terminal once the barrier opens for the vehicle ahead."]'::jsonb,
    '["Tunggu di lorong anda dan tunjukkan dokumen yang diperlukan apabila diminta. \u2705", "Tukar ke lorong yang kurang sesak.", "Serahkan hanya dokumen yang diminta oleh pelanggan.", "Masuk apabila palang dibuka untuk kenderaan di hadapan."]'::jsonb,
    0,
    'Follow the gate process and present required documents when instructed to support safe and orderly entry.',
    'Ikuti proses di pintu masuk dan tunjukkan dokumen yang diperlukan apabila diminta bagi memastikan kemasukan teratur.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4277a400-282f-4c12-abc8-567184cccede',
    NULL,
    'You prepare to change lanes in steady traffic. Motorcycles filter between lanes and traffic slows near an exit.',
    'Anda bersedia untuk menukar lorong dalam trafik lancar. Motosikal bergerak di antara lorong dan trafik perlahan berhampiran susur keluar.',
    '["Signal early and complete full mirror checks before moving", "Signal as you move and rely on others to adjust", "Check mirrors quickly and move when the lane looks clear", "Wait for traffic to stabilise before signalling"]'::jsonb,
    '["Beri isyarat awal dan periksa cermin sepenuhnya sebelum bergerak", "Beri isyarat semasa bergerak dan harap pemandu lain menyesuaikan diri", "Periksa cermin dengan cepat dan bergerak apabila lorong kelihatan jelas", "Tunggu trafik stabil sebelum memberi isyarat"]'::jsonb,
    0,
    'Signal early and complete full checks before changing lanes.',
    'Beri isyarat awal dan lakukan pemeriksaan penuh sebelum menukar lorong.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6a643624-2296-419a-b949-120e24ec8860',
    NULL,
    'After a delivery, you find a required document was not completed according to company procedure.',
    'Selepas selesai penghantaran, anda mendapati dokumen yang diperlukan tidak dilengkapkan mengikut prosedur syarikat.',
    '["Complete and correct the document before closing the job", "Leave it since the delivery is already done", "Make a brief note and update it later if needed", "Proceed to the next task and rely on existing records"]'::jsonb,
    '["Lengkapkan dan betulkan dokumen sebelum menyelesaikan tugasan", "Biarkan sahaja kerana penghantaran sudah selesai", "Buat catatan ringkas dan kemas kini kemudian jika perlu", "Teruskan ke tugasan seterusnya dan bergantung pada rekod sedia ada"]'::jsonb,
    0,
    'Complete documents correctly to maintain procedural compliance.',
    'Lengkapkan dokumen dengan betul untuk memastikan pematuhan terhadap prosedur.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '66625f80-11df-49ed-bd8d-8144bf1a92e6',
    NULL,
    'You are preparing to start your trip and will return later the same day.',
    'Anda sedang bersedia untuk memulakan perjalanan dan akan kembali pada hari yang sama.',
    '["Conduct inspection only before starting the trip.", "Conduct inspection only after completing the trip.", "Conduct inspections both before and after the trip.", "Conduct inspection only if a defect is suspected."]'::jsonb,
    '["Lakukan pemeriksaan sebelum memulakan perjalanan sahaja.", "Lakukan pemeriksaan selepas menamatkan perjalanan sahaja.", "Lakukan pemeriksaan sebelum dan selepas perjalanan.", "Lakukan pemeriksaan hanya jika terdapat tanda kerosakan."]'::jsonb,
    2,
    'Perform required inspections before and after every trip.',
    'Lakukan pemeriksaan yang ditetapkan sebelum dan selepas setiap perjalanan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '08462931-d6c0-4bba-a8c0-c8e0f791550c',
    NULL,
    'You notice only three safety cones are available in the vehicle.',
    'Anda mendapati hanya tiga kon keselamatan tersedia di dalam kenderaan.',
    '["Proceed since cones are rarely used.", "Ensure five compliant safety cones are available.", "Carry additional cones only for highway trips.", "Proceed since 3 cones is enough"]'::jsonb,
    '["Teruskan perjalanan kerana kon jarang digunakan.", "Pastikan lima kon keselamatan yang mematuhi spesifikasi tersedia.", "Bawa kon tambahan hanya untuk perjalanan di lebuh raya.", "Teruskan kerana 3 kon sudah mencukupi."]'::jsonb,
    1,
    'Ensure the required number of compliant safety cones is carried.',
    'Pastikan bilangan kon keselamatan yang mematuhi spesifikasi dibawa seperti yang ditetapkan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2c736083-3905-4bc4-a84e-3a78df3c8ce8',
    NULL,
    'You are on foot near your vehicle in an active loading area. Forklifts operate and stacked goods restrict visibility.',
    'Anda berjalan berhampiran kenderaan di kawasan pemunggahan aktif. Forklift beroperasi dan susunan barangan menghadkan pandangan.',
    '["Keep clear of loading paths and wait until movement settles", "Move closer to observe equipment movement", "Walk through quickly to minimise time in the area", "Stand where operators can see you and keep moving"]'::jsonb,
    '["Kekal jauh dari laluan pemunggahan dan tunggu sehingga pergerakan reda", "Bergerak lebih dekat untuk memerhati pergerakan jentera", "Berjalan cepat untuk kurangkan masa di kawasan itu", "Berdiri di tempat pengendali boleh nampak dan terus bergerak"]'::jsonb,
    0,
    'Keep clear of loading activity to avoid sudden equipment movement and blind spots.',
    'Kekalkan jarak dari aktiviti pemunggahan untuk elakkan pergerakan jentera mengejut dan kawasan titik buta.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a578e8d3-f23e-4d3d-b50b-c19cab9d249d',
    NULL,
    'While making a delivery, members of the public are nearby and watching your interaction with the customer.',
    'Semasa membuat penghantaran, orang awam berada berdekatan dan memerhati interaksi anda dengan pelanggan.',
    '["Focus only on the customer and ignore the surroundings", "Maintain calm, respectful behaviour mindful of the public presence", "Keep the exchange short to avoid attention", "Let the customer lead the interaction tone"]'::jsonb,
    '["Fokus pada pelanggan sahaja dan abaikan keadaan sekeliling", "Kekalkan tingkah laku tenang dan hormat dengan mengambil kira kehadiran orang awam", "Pendekkan perbualan untuk elak perhatian", "Biarkan pelanggan tentukan nada interaksi"]'::jsonb,
    1,
    'Professional behaviour matters not only to the customer, but also to the public observing the interaction.',
    'Tingkah laku profesional penting bukan sahaja kepada pelanggan tetapi juga kepada orang awam yang memerhati.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'da7c41bb-77fa-43e7-830a-ed00acb6ad8a',
    NULL,
    'Your goods vehicle is experiencing failure on a highway and you are placing a warning triangle.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda sedang meletakkan segi tiga amaran.',
    '["Place it a few metres behind the vehicle for quick visibility.", "Place it about 50 metres to the rear of the vehicle.", "Place it beside the vehicle near the shoulder.", "Hold it while standing near traffic to alert drivers."]'::jsonb,
    '["Letakkan beberapa meter di belakang kenderaan supaya mudah dilihat dengan cepat.", "Letakkan kira-kira 50 meter di belakang kenderaan.", "Letakkan di sisi kenderaan berhampiran bahu jalan.", "Pegang sambil berdiri berhampiran trafik untuk memberi amaran."]'::jsonb,
    1,
    'Position warning devices at a safe rear distance to alert approaching traffic early.',
    'Letakkan alat amaran pada jarak selamat di belakang kenderaan untuk memberi amaran awal kepada trafik yang menghampiri.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '421fae27-2f85-4558-ac25-58984226aac4',
    NULL,
    'You arrive at a customer site. Access lanes are narrow and forklifts operate near the loading area.',
    'Anda tiba di tapak pelanggan. Laluan masuk sempit dan forklift beroperasi berhampiran kawasan pemuatan.',
    '["Hold back until access is clearly available", "Move forward slowly to secure a position near loading", "Approach while keeping visible to site staff", "Continue advancing to avoid delaying loading"]'::jsonb,
    '["Tunggu di luar sehingga laluan benar-benar jelas", "Bergerak perlahan untuk mendapatkan kedudukan berhampiran kawasan pemuatan", "Hampiri kawasan tersebut dengan memastikan anda kelihatan oleh pekerja tapak", "Terus bergerak untuk elakkan kelewatan proses pemuatan."]'::jsonb,
    0,
    'Keep distance from constrained access and active loading areas.',
    'Kekalkan jarak dari laluan sempit dan kawasan loading aktif.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '959c441f-30bc-450c-aafc-4f11447bb5e4',
    NULL,
    'At a security checkpoint, the vehicle ahead is being cleared and the guard signals you to move closer.',
    'Di pusat pemeriksaan keselamatan, kenderaan di hadapan sedang diperiksa dan pengawal memberi isyarat supaya anda bergerak lebih dekat.',
    '["Close the gap to speed up clearance", "Keep a safe following distance", "Stop directly behind the vehicle", "Move slowly and rely on the guard to manage spacing"]'::jsonb,
    '["Rapatkan jarak untuk mempercepatkan pemeriksaan", "Kekalkan jarak selamat dengan kenderaan di hadapan", "Berhenti tepat di belakang kenderaan", "Bergerak perlahan dan bergantung pada pengawal untuk mengawal jarak"]'::jsonb,
    1,
    'Checkpoint instructions do not replace safe spacing.',
    'Arahan pusat pemeriksaan tidak menggantikan disiplin jarak selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9940d55f-a27c-4d7d-a270-e9e68e744307',
    NULL,
    'While manoeuvring at low speed with a load, you feel the load shift and notice the vehicle is closer than expected to an obstacle.',
    'Semasa membuat manuver pada kelajuan rendah dengan muatan, anda merasakan muatan bergerak dan menyedari kenderaan lebih dekat daripada jangkaan kepada halangan.',
    '["Stop and assess if it is safe to proceed", "Proceed slowly and adjust steering to maintain clearance", "Complete the manoeuvre and check the load afterward", "Continue moving and secure the load once clear"]'::jsonb,
    '["Berhenti dan pastikan selamat sebelum meneruskan", "Terus bergerak perlahan dan laraskan stereng untuk kekalkan jarak", "Selesaikan manuver dan periksa muatan selepas itu", "Terus bergerak dan periksa di tempat perhentian"]'::jsonb,
    0,
    'Stop and reassess when load shift or clearance risk appears.',
    'Berhenti dan nilai semula apabila muatan bergerak atau jarak menjadi sempit.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ab7ba1c6-7fa0-4a7d-8a34-2a5b5a2729d2',
    NULL,
    'A disagreement arises on site, and the discussion starts to become tense.',
    'Berlaku perbezaan pendapat di tapak dan perbincangan mula menjadi tegang.',
    '["Speak calmly, acknowledge concerns, and clarify next steps", "Restate your position firmly to end the discussion", "Reduce interaction and wait for the situation to pass", "Continue the task without engaging further"]'::jsonb,
    '["Bercakap dengan tenang dan jelaskan langkah seterusnya", "Tegaskan pendirian anda untuk tamatkan perbincangan", "Kurangkan interaksi dan tunggu keadaan reda", "Teruskan tugas tanpa melibatkan diri"]'::jsonb,
    0,
    'Calm acknowledgement and clear steps help prevent disagreements from escalating.',
    'Pendekatan yang tenang dan langkah yang jelas membantu elakkan keadaan menjadi lebih tegang.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6af41455-48be-441c-b0b4-6daa5ff6ba53',
    NULL,
    'You are asked to modify the vehicle’s GPS tracking or speedometer settings.',
    'Anda diminta untuk mengubah suai tetapan sistem GPS atau meter kelajuan kenderaan.',
    '["Make the adjustment if it improves convenience.", "Refuse any modification that violates safety or company protocol.", "Adjust the settings temporarily and restore them later.", "Modify only if other drivers have done so."]'::jsonb,
    '["Buat pelarasan jika ia memudahkan urusan.", "Tolak sebarang pengubahsuaian yang melanggar peraturan keselamatan atau prosedur syarikat.", "Ubah tetapan sementara dan pulihkan kemudian.", "Buat Pengubahsuaian hanya jika pemandu lain pernah melakukannya."]'::jsonb,
    1,
    'Do not alter vehicle systems against safety rules or company protocol.',
    'Jangan mengubah suai sistem kenderaan yang bertentangan dengan peraturan keselamatan atau prosedur syarikat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1a9b6224-0dcc-4f4b-ad0d-5a3b2daa74a6',
    NULL,
    'You arrive at a site and the nearest space is marked as a prohibited parking area.',
    'Anda tiba di tapak dan ruang terdekat ditanda sebagai kawasan larangan parkir.',
    '["Park there briefly if unloading is quick.", "Find a permitted parking space.", "Park there if other vehicles are doing the same.", "Stop there with hazard lights switched on."]'::jsonb,
    '["Parkir seketika jika proses menurunkan muatan adalah cepat.", "Cari ruang parkir yang dibenarkan.", "Parkir di situ jika kenderaan lain melakukan perkara yang sama.", "Berhenti di situ dengan lampu kecemasan dihidupkan."]'::jsonb,
    1,
    'Do not park in prohibited areas.',
    'Parkir hanya di kawasan yang dibenarkan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9e1ea363-a699-4171-8ee3-ce65a22bc5e8',
    NULL,
    'While reversing slowly in a tight site area, you lose clear sight of one rear corner.',
    'Semasa mengundur perlahan di kawasan tapak yang sempit, anda hilang pandangan jelas pada satu sudut belakang.',
    '["Continue reversing slowly using mirrors", "Stop the vehicle and reassess the situation", "Turn the steering slightly and keep moving", "Rely on previous experience and continue"]'::jsonb,
    '["Terus mengundur perlahan menggunakan cermin", "Berhenti dan nilai semula keadaan", "Pusing stereng sedikit dan terus bergerak", "Bergantung pada pengalaman lalu dan teruskan"]'::jsonb,
    1,
    'Stop when visibility is uncertain to prevent damage and protect people and property.',
    'Berhenti apabila pandangan tidak jelas untuk mengelakkan kerosakan dan melindungi orang serta harta benda.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd43abca6-6ef0-4ce6-8d78-168758618feb',
    NULL,
    'You slow to turn near pedestrians, and nearby road users appear unsure of your intention.',
    'Anda memperlahankan kenderaan untuk membelok berhampiran pejalan kaki, dan pengguna jalan lain kelihatan tidak pasti tentang niat anda.',
    '["Signal early and make the turn carefully", "Slow further to see how others react", "Turn once there is space without signalling", "Edge forward slightly to show what you intend to do"]'::jsonb,
    '["Beri isyarat awal dan belok secara cermat", "Perlahankan lagi untuk melihat reaksi orang lain", "Belok apabila ada ruang tanpa memberi isyarat", "Gerak sedikit ke hadapan untuk menunjukkan niat"]'::jsonb,
    0,
    'Early signalling helps pedestrians and other road users understand your intention and stay safe.',
    'Isyarat awal membantu pejalan kaki dan pengguna jalan lain memahami niat anda dan kekal selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0a953716-6867-49d0-a813-5a3a85b45693',
    NULL,
    'You enter a narrow roadworks zone with barriers while members of the public are standing nearby',
    'Anda memasuki kawasan pembaikan jalan yang sempit dengan penghadang, sementara orang awam berada berhampiran.',
    '["Reduce speed early and proceed cautiously", "Maintain speed to clear the zone quickly", "Follow the vehicle ahead closely to avoid delay", "Focus on steering accuracy and ignore people nearby"]'::jsonb,
    '["Kurangkan kelajuan lebih awal dan lalui kawasan dengan berhati-hati", "Kekalkan kelajuan untuk melepasi kawasan dengan cepat", "Ikut rapat kenderaan di hadapan supaya tidak lewat", "Fokus pada kawalan stereng dan abaikan orang di sekitar"]'::jsonb,
    0,
    'Reducing speed early in high-risk areas helps protect the public and reduces potential harm.',
    'Mengurangkan kelajuan lebih awal di kawasan berisiko membantu melindungi orang awam dan mengurangkan potensi bahaya.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8015e964-fedd-406d-99ae-ba76a04a5c39',
    NULL,
    'A small fire starts near the engine compartment while parked.',
    'Semasa parkir, kebakaran kecil bermula berhampiran ruang enjin.',
    '["Use the ABC fire extinguisher if safe.", "Wait for others to assist before acting.", "Pour available water to reduce flames.", "Observe briefly before deciding."]'::jsonb,
    '["Gunakan alat pemadam api jenis ABC jika keadaan selamat.", "Tunggu bantuan sebelum mengambil tindakan.", "Tuang air yang ada untuk mengurangkan api.", "Perhatikan keadaan seketika sebelum membuat keputusan."]'::jsonb,
    0,
    'Use the appropriate extinguisher if the fire is manageable.',
    'Gunakan alat pemadam api yang sesuai jika kebakaran masih boleh dikawal dan keadaan selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e1e711a7-46bc-464f-9534-7a3d9c37d832',
    NULL,
    'After ensuring safety at the accident scene, what should you do next?',
    'Selepas memastikan keselamatan di lokasi kemalangan, apakah tindakan seterusnya?',
    '["Report immediately to office.", "Complete delivery first and report later.", "Wait until returning to depot.", "Inform only if damage is serious."]'::jsonb,
    '["Laporkan segera kepada pejabat.", "Selesaikan penghantaran dahulu dan laporkan kemudian.", "Tunggu sehingga kembali ke depot.", "Maklumkan hanya jika kerosakan adalah serius."]'::jsonb,
    0,
    'Report the incident immediately and await instruction.',
    'Laporkan kejadian segera dan tunggu arahan lanjut.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '255b7477-6bb9-4589-9a18-8bbedbdc1b84',
    NULL,
    'While driving inside a site, you encounter uneven surfaces and hazards along the route. You are within the speed limit.',
    'Semasa memandu di dalam tapak, anda menghadapi permukaan tidak rata dan bahaya di laluan. Anda masih dalam had laju dibenarkan.',
    '["Reduce speed to suit the hazards", "Maintain speed since it is within the limit", "Adjust speed only near visible obstacles", "Continue at normal speed and rely on steering"]'::jsonb,
    '["Kurangkan kelajuan mengikut keadaan", "Kekalkan kelajuan kerana masih dalam had laju", "Sesuaikan kelajuan hanya berhampiran halangan yang jelas", "Teruskan pada kelajuan biasa dan bergantung pada kawalan stereng"]'::jsonb,
    0,
    'Adjust speed to suit conditions even within the limit.',
    'Sesuaikan kelajuan mengikut keadaan walaupun masih dalam had laju.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c5b4f8f4-3e3d-4773-9e83-312c5caef830',
    NULL,
    'During unloading, a site worker suggests a small personal favour to speed up the process.',
    'Semasa proses memunggah, seorang pekerja tapak mencadangkan bantuan peribadi kecil untuk mempercepatkan proses.',
    '["Decline politely and continue unloading as required", "Agree briefly since it may help everyone finish faster", "Avoid responding directly and keep working to reduce attention", "Suggest handling the request later to keep things moving"]'::jsonb,
    '["Tolak dengan sopan dan teruskan proses memunggah seperti dikehendaki", "Setuju seketika kerana ia mungkin mempercepatkan kerja", "Elakkan memberi respons secara langsung dan teruskan kerja", "Cadangkan urus perkara itu kemudian supaya kerja berjalan"]'::jsonb,
    0,
    'Declining improper requests helps maintain integrity and fair working practices.',
    'Menolak permintaan yang tidak sesuai membantu kekalkan integriti dan amalan kerja yang adil.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f67af891-3245-4e8a-bb14-937c32db071c',
    NULL,
    'During a delivery, a culturally sensitive interaction is happening while people nearby are watching or recording.',
    'Semasa penghantaran, berlaku interaksi sensitif berkaitan budaya dan orang sekeliling sedang melihat dan merakam.',
    '["Maintain respectful behaviour and continue professionally", "Explain your actions carefully so others do not misinterpret them", "Limit the interaction to avoid drawing further attention", "Adjust your response to match how others expect you to behave"]'::jsonb,
    '["Kekalkan tingkah laku yang hormat dan teruskan secara profesional", "Terangkan tindakan anda dengan teliti supaya tidak disalah tafsir", "Hadkan interaksi untuk elak menarik lebih perhatian", "Ubah respons anda mengikut jangkaan orang sekeliling"]'::jsonb,
    0,
    'Maintaining respectful, professional behaviour protects your image during visible interactions.',
    'Sikap hormat dan profesional membantu melindungi imej anda apabila situasi diperhatikan orang lain.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '63a5d142-9b88-4a81-94ef-32f90f33bf4d',
    NULL,
    'You prepare to merge into a moving lane when another driver accelerates and blocks the available gap.',
    'Anda bersedia untuk masuk ke lorong yang sedang bergerak apabila seorang pemandu lain memecut dan menutup ruang yang ada.',
    '["Hold back and wait for a clearer gap", "Force the merge to assert your position", "Move closer to pressure the other driver to yield", "Gesture briefly to signal dissatisfaction"]'::jsonb,
    '["Tahan dan tunggu ruang yang lebih jelas serta selamat", "Paksa masuk untuk mempertahankan kedudukan anda", "Rapatkan kenderaan untuk memberi tekanan supaya pemandu lain mengalah", "Buat isyarat ringkas tanda tidak puas hati"]'::jsonb,
    0,
    'Waiting for a safe gap and avoiding confrontation reduces risk and prevents unnecessary conflict.',
    'Menunggu ruang yang selamat dan mengelakkan konfrontasi membantu mengurangkan risiko serta ketegangan di jalan raya.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '892135a4-feea-40c3-9e77-383c3f20a5d1',
    NULL,
    'Before entering a narrow access road, you cannot confirm whether it has a suitable exit.',
    'Sebelum memasuki jalan masuk yang sempit, anda tidak dapat memastikan sama ada terdapat laluan keluar yang sesuai.',
    '["Verify the route before driving in.", "Enter slowly and stop if you cannot continue.", "Follow the route if other vehicles have used it.", "Depend on navigation to identify an exit after entering."]'::jsonb,
    '["Sahkan laluan tersebut sebelum memasukinya.", "Masuk dengan perlahan dan berhenti jika tidak dapat meneruskan perjalanan.", "Ikut laluan tersebut jika kenderaan lain pernah melaluinya.", "Bergantung pada sistem navigasi untuk mencari laluan keluar selepas memasuki kawasan tersebut."]'::jsonb,
    0,
    'Verify access and exit routes before entering confined areas to reduce operational risk.',
    'Sahkan laluan masuk dan keluar sebelum memasuki kawasan yang sempit bagi mengurangkan risiko operasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd7c878f5-328e-45fb-8113-ff54cdcc2e1c',
    NULL,
    'During hot weather, you are concerned the cab will become warm while making a delivery.',
    'Semasa cuaca panas, anda bimbang kabin akan menjadi panas ketika membuat penghantaran.',
    '["Secure the vehicle before leaving it.", "Leave one window slightly open to improve ventilation.", "Return to the vehicle more frequently to check it.", "Park in the shade and leave the window slightly open."]'::jsonb,
    '["Pastikan kenderaan dikunci dan selamat sebelum meninggalkannya.", "Biarkan satu tingkap terbuka sedikit untuk pengudaraan.", "Kembali ke kenderaan dengan lebih kerap untuk memeriksanya.", "Letakkan kenderaan di tempat teduh dan biarkan tingkap terbuka sedikit."]'::jsonb,
    0,
    'Protecting the vehicle from theft takes priority over personal convenience.',
    'Melindungi kenderaan daripada risiko kecurian adalah lebih penting daripada keselesaan diri.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f833aaaa-2dc0-4c05-8f77-d1f8970c54a3',
    NULL,
    'During a delivery, your vehicle accidentally damages a customer''s property. There is no company requirement to take photographs for this situation.',
    'Semasa penghantaran, kenderaan anda secara tidak sengaja merosakkan harta pelanggan. Tiada keperluan syarikat untuk mengambil gambar bagi situasi ini.',
    '["Take clear photographs of all damages", "Report the incident without taking photographs", "Wait until someone asks for photographic evidence", "Leave the site once the incident has been reported"]'::jsonb,
    '["Ambil gambar yang jelas bagi semua kerosakan", "Laporkan kejadian tanpa mengambil gambar", "Tunggu sehingga seseorang meminta bukti bergambar", "Tinggalkan premis selepas kejadian dilaporkan"]'::jsonb,
    0,
    'Whenever goods, vehicles, customer property or third-party assets are damaged, take clear photographs immediately to preserve accurate evidence, even if it is not specifically required by the SOP.',
    'Ambil gambar dengan segera apabila berlaku sebarang kerosakan, walaupun tidak diwajibkan oleh SOP syarikat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'cf26374a-ffc2-405d-a5f9-ae099fb9ac18',
    NULL,
    'You queue to mount a container onto your trailer. The vehicle ahead is still aligning and the area is congested.',
    'Anda beratur untuk loading/offloading kontena ke atas treler. Kenderaan di hadapan masih melaras kedudukan dan kawasan sesak.',
    '["Maintain spacing and wait until the mounting area is clear", "Move closer to prepare while the vehicle ahead is finishing", "Close the gap slowly to reduce waiting time", "Follow ground staff signals to approach closely"]'::jsonb,
    '["Kekalkan jarak dan tunggu sehingga kawasan loading/offloading kosong", "Bergerak lebih dekat untuk bersedia semasa kenderaan di hadapan hampir selesai", "Rapatkan jarak perlahan untuk kurangkan masa menunggu", "Ikut isyarat pekerja tapak untuk menghampiri sedekat mungkin"]'::jsonb,
    0,
    'Maintain spacing during container mounting operations.',
    'Kekalkan jarak semasa operasi loading/offloading kontena.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1c9d4b17-e1ea-4aef-91bc-dfb0f61ab7c3',
    NULL,
    'Before exiting the port, you compare the seal number with the gate pass.',
    'Sebelum keluar dari pelabuhan, anda membandingkan nombor seal dengan maklumat pada gate pass.',
    '["Proceed if the seal is intact.", "Confirm the seal number matches the document.", "Check the number only at delivery point.", "Ignore minor number differences."]'::jsonb,
    '["Teruskan perjalanan jika seal kelihatan baik.", "Pastikan nombor seal sepadan dengan dokumen.", "Semak nombor hanya apabila tiba di lokasi penghantaran.", "Abaikan perbezaan kecil pada nombor."]'::jsonb,
    1,
    'Verify that the seal number matches the documented record.',
    'Pastikan nombor seal sepadan dengan rekod dalam dokumen sebelum berlepas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '31708c20-e69e-45b4-99cd-e38df92ea746',
    NULL,
    'While inspecting a reefer import container, you notice the power cable appears damaged.',
    'Semasa memeriksa kontena import berpendingin (reefer container), anda mendapati kabel kuasa kelihatan rosak.',
    '["Record the issue in the gate pass before exiting.", "Continue if temperature display is normal.", "Inform operations after delivery.", "Secure it temporarily and proceed."]'::jsonb,
    '["Catat isu tersebut pada gate pass sebelum keluar.", "Teruskan perjalanan jika paparan suhu normal.", "Maklumkan kepada bahagian operasi selepas penghantaran.", "Ikat sementara dan teruskan perjalanan."]'::jsonb,
    0,
    'Record any reefer equipment damage in the gate pass before departure.',
    'Catat sebarang kerosakan peralatan kontena import berpendingin pada gate pass sebelum berlepas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '39a53fd2-f489-4e0d-b5d6-b737d1c3314f',
    NULL,
    'Before exiting the port, you notice the container number differs in one document.',
    'Sebelum keluar dari pelabuhan, anda mendapati nombor kontena berbeza pada satu dokumen.',
    '["Exit and clarify after leaving the port.", "Stop, report to operations, and wait for instruction.", "Amend the document yourself.", "Proceed if the seal number matches."]'::jsonb,
    '["Keluar dahulu dan jelaskan selepas meninggalkan pelabuhan.", "Berhenti, laporkan kepada bahagian operasi dan tunggu arahan lanjut.", "Pinda dokumen sendiri.", "Teruskan jika nombor seal sepadan."]'::jsonb,
    1,
    'Do not exit the port when container numbers mismatch.',
    'Jangan keluar dari pelabuhan apabila nombor kontena tidak sepadan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7113f7f9-2372-4611-9501-db8c709c0535',
    NULL,
    'Before departure, you find that the export container has no seal.',
    'Sebelum bertolak, anda mendapati kontena eksport tersebut tidak mempunyai seal.',
    '["Install any available seal and proceed.", "Inform operations and wait for instruction.", "Proceed since cargo is already loaded.", "Seal it yourself without reporting."]'::jsonb,
    '["Pasang sebarang seal yang ada dan teruskan perjalanan.", "Maklumkan kepada bahagian operasi dan tunggu arahan lanjut.", "Teruskan perjalanan kerana muatan telah dimuatkan.", "Pasang seal sendiri tanpa membuat sebarang laporan."]'::jsonb,
    1,
    'Report missing seals before moving an export container.',
    'Laporkan ketiadaan seal sebelum menggerakkan atau membawa kontena.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f1e5092a-220b-4ca6-b4d0-bed9c51bb9a6',
    NULL,
    'Inside a site yard, a marshal instructs you to hold while vehicles reposition nearby.',
    'Di kawasan tapak, seorang marshal mengarahkan anda supaya berhenti sementara kenderaan berhampiran sedang mengubah kedudukan.',
    '["Hold position and continue checking mirrors and blind spots", "Signal and edge forward slightly to prepare to move", "Adjust position gradually while watching the marshal", "Follow nearby vehicles once they begin moving"]'::jsonb,
    '["Kekal berhenti dan terus periksa cermin serta titik buta", "Beri isyarat dan bergerak sedikit ke hadapan sebagai persediaan bergerak", "Sesuaikan kedudukan secara beransur sambil memerhati marshal", "Ikut pergerakan kenderaan berhampiran apabila ia mula bergerak"]'::jsonb,
    0,
    'Follow marshal instructions while maintaining situational awareness.',
    'Patuhi arahan marshal sambil kekalkan kesedaran persekitaran.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd99f839b-c963-4e01-8261-bd2bbc68e2ef',
    NULL,
    'You approach an area where containers are being lifted and repositioned. Equipment movement is ongoing.',
    'Anda menghampiri kawasan di mana kontena sedang  dialihkan. Jentera masih beroperasi.',
    '["Stop outside the lifting zone until operations are complete", "Proceed slowly while monitoring the lifting activity", "Continue moving and adjust if equipment comes closer", "Follow another vehicle that enters the zone"]'::jsonb,
    '["Berhenti di luar zon pengangkatan sehingga operasi selesai", "Terus bergerak perlahan sambil memantau aktiviti pengangkatan", "Terus bergerak dan sesuaikan kedudukan jika jentera menghampiri", "Ikut kenderaan lain yang memasuki zon tersebut"]'::jsonb,
    0,
    'Keep clear of active lifting zones.',
    'Jauhi zon pengangkatan yang sedang aktif.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5547b768-edbe-4e20-8bc6-6e6dddf92a4e',
    NULL,
    'At a site gate, you notice a wheel chock and tool left unsecured on the vehicle before entry.',
    'Di pintu masuk tapak, anda perasan pengadang tayar dan peralatan tidak diikat kemas pada kenderaan sebelum masuk.',
    '["Enter the site and secure them at the first parking point", "Secure the items before entering the site", "Proceed inside since the items are not in use", "Ask security to allow entry first"]'::jsonb,
    '["Masuk tapak dan kemaskan di tempat parkir pertama", "Kemaskan dahulu sebelum masuk tapak", "Terus masuk kerana alat itu tidak digunakan", "Minta kebenaran masuk daripada pengawal dahulu"]'::jsonb,
    1,
    'Securing loose equipment before entry prevents avoidable risks inside controlled areas.',
    'Kemaskan peralatan sebelum masuk tapak untuk elakkan risiko.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7eebce44-8247-4a0f-8c9e-bcbc089158b0',
    NULL,
    'Your goods vehicle is experiencing failure on a highway and there is no nearby exit.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan tiada susur keluar berhampiran.',
    '["Stop in the current lane and switch on hazard lights.", "Move the vehicle to the far left shoulder before stopping.", "Stop immediately and place warning devices behind the vehicle.", "Slow down and remain in the lane until assistance arrives."]'::jsonb,
    '["Berhenti di lorong semasa dan hidupkan lampu kecemasan.", "Gerakkan kenderaan ke bahu kiri paling luar sebelum berhenti.", "Berhenti serta-merta dan letakkan alat amaran di belakang kenderaan.", "Perlahankan kenderaan dan kekal di lorong sehingga bantuan tiba."]'::jsonb,
    1,
    'Move to a safer shoulder area to reduce exposure to traffic.',
    'Gerakkan kenderaan ke bahu jalan yang lebih selamat untuk mengurangkan risiko terdedah kepada trafik.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ff4347ff-420f-4d76-9762-d6276ff22ba5',
    NULL,
    'At a site with active loading operations, you step out of your vehicle in the loading area without a safety helmet.',
    'Di tapak dengan operasi pemuatan aktif, anda keluar dari kenderaan di kawasan pemuatan tanpa topi keselamatan.',
    '["Put on the required PPE and keep clear of loading", "Remain where you are and rely on loading personnel", "Move quickly through the area to reduce time", "Wait for instructions before addressing PPE"]'::jsonb,
    '["Pakai PPE yang diperlukan dan kekal jauh dari operasi pemuatan", "Kekal di tempat dan bergantung pada perkerja loading", "Bergerak cepat melalui kawasan itu untuk kurangkan masa", "Tunggu arahan dan kemudian pakai  PPE"]'::jsonb,
    0,
    'Wear required PPE and keep clear of loading zones.',
    'Pakai PPE yang diperlukan dan kekalkan jarak dari kawasan pemuatan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5d395f71-c2d9-44b5-9980-54693b168568',
    NULL,
    'During a delivery, a customer follows cultural practices unfamiliar to you.',
    'Semasa membuat penghantaran, seorang pelanggan mengikut amalan budaya yang tidak biasa bagi anda.',
    '["Acknowledge the practice and respond respectfully", "Continue the task without engaging further", "Question the practice to clarify expectations", "Follow your usual approach and proceed"]'::jsonb,
    '["Hormati amalan tersebut dan beri respons dengan sesuai", "Teruskan tugas tanpa melibatkan diri", "Persoalkan amalan itu untuk jelaskan jangkaan", "Ikut cara biasa anda dan teruskan"]'::jsonb,
    0,
    'Respecting cultural differences helps maintain positive and professional interactions.',
    'Menghormati perbezaan budaya membantu kekalkan interaksi yang profesional dan baik.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '09867b9d-a3e4-4e2d-8f06-04e0bd3425aa',
    NULL,
    'After unloading in a public street, a nearby shop owner asks you to record a shorter stop time to avoid complaints.',
    'Selepas memunggah muatan di tepi jalan awam, seorang pemilik kedai meminta anda merekod masa berhenti yang lebih singkat untuk elakkan aduan.',
    '["Record the actual stop time and submit the document as required", "Shorten the recorded time since unloading is already completed", "Leave the timing unclear so it does not attract attention", "Explain the situation verbally and minimise what is written"]'::jsonb,
    '["Catat masa berhenti sebenar dan serahkan dokumen seperti dikehendaki", "Pendekkan masa yang direkod kerana proses memunggah sudah selesai", "Biarkan catatan masa tidak jelas supaya tidak menarik perhatian", "Jelaskan secara lisan dan kurangkan maklumat bertulis"]'::jsonb,
    0,
    'Accurate records uphold accountability, even when there is public pressure.',
    'Catatan yang tepat membantu kekalkan tanggungjawab walaupun ada tekanan dari luar.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f91d5fee-e177-4340-993c-6e83abee2b00',
    NULL,
    'Before loading cargo, what should you verify?',
    'Sebelum kargo dimuatkan, apakah yang perlu anda sahkan?',
    '["Confirm the permitted load limit before loading.", "Load first and check weight later.", "Estimate weight based on experience.", "Accept the customer\u2019s estimate without verification."]'::jsonb,
    '["Sahkan had muatan yang dibenarkan sebelum memuatkan kargo.", "Muatkan terlebih dahulu dan periksa berat kemudian.", "Anggarkan berat berdasarkan pengalaman.", "Terima anggaran pelanggan tanpa pengesahan."]'::jsonb,
    0,
    'Confirm the permitted load limit before carrying cargo.',
    'Sahkan had muatan yang dibenarkan bagi kenderaan sebelum kargo dimuatkan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9f32d06c-f3cf-4c70-9369-873cce95bd50',
    NULL,
    'After a delivery, you are stopped for inspection and asked to present your documents. One document was completed late but is accurate.',
    'Selepas penghantaran, anda ditahan untuk pemeriksaan dan diminta menunjukkan dokumen. Satu dokumen dilengkapkan lewat tetapi maklumatnya tepat.',
    '["Present the documents and clarify the late entry", "Hand over the documents without mentioning the late entry", "Say the document was completed earlier", "Offer to update the document later"]'::jsonb,
    '["Tunjukkan dokumen dan jelaskan tentang pengisian lewat", "Serahkan dokumen tanpa memaklumkan tentang kelewatan pengisian", "Nyatakan bahawa dokumen telah dilengkapkan lebih awal", "Tawarkan untuk mengemas kini dokumen kemudian"]'::jsonb,
    0,
    'Present accurate documents and clarify issues during inspections.',
    'Tunjukkan dokumen yang tepat dan jelaskan perkara berkaitan semasa pemeriksaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '267b9070-2f21-4c3c-ba6d-6bfddc873125',
    NULL,
    'After a pre-trip inspection, the vehicle behaves differently once you begin moving.',
    'Selepas pemeriksaan sebelum perjalanan, kenderaan menunjukkan keadaan tidak biasa apabila anda mula bergerak.',
    '["Continue driving to see if it settles", "Stop safely and reassess the vehicle", "Adjust driving style to compensate", "Complete the trip and report later"]'::jsonb,
    '["Terus memandu untuk melihat sama ada keadaan kembali normal", "Berhenti dengan selamat dan periksa semula kenderaan", "Laraskan cara pemanduan untuk menyesuaikan keadaan", "Selesaikan perjalanan dan laporkan kemudian"]'::jsonb,
    1,
    'Vehicle behaviour should match inspection results.',
    'Jika kenderaan menunjukkan keadaan tidak biasa, berhenti dan periksa semula sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ffa0cc40-ddb4-42cc-8f1c-97fb83d45ea2',
    NULL,
    'You slow early after spotting a hazard ahead. The driver behind reacts angrily and closes in.',
    'Anda memperlahankan kenderaan lebih awal selepas melihat bahaya di hadapan. Pemandu di belakang bertindak marah dan merapat.',
    '["Keep your speed steady and avoid engaging", "Speed up slightly to reduce pressure from behind", "Brake again to show there is a hazard ahead", "Gesture briefly to discourage the tailgating"]'::jsonb,
    '["Kekalkan kelajuan yang stabil dan elakkan memberi respons", "Tambah sedikit kelajuan untuk mengurangkan tekanan dari belakang", "Tekan brek sekali lagi untuk menunjukkan terdapat bahaya di hadapan", "Buat isyarat ringkas untuk menghalang tingkah laku tersebut"]'::jsonb,
    0,
    'Maintaining steady driving and avoiding engagement helps manage hazards without escalating conflict.',
    'Mengekalkan pemanduan yang stabil dan tidak bertindak balas membantu mengurus risiko tanpa menambahkan ketegangan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '65e78805-e81c-4fc7-8644-b46af7d20731',
    NULL,
    'While driving at the posted speed, you see motorcycles filtering between lanes and uneven braking ahead.',
    'Anda memandu pada kelajuan dibenarkan. Motosikal bergerak di antara lorong dan brek tidak sekata berlaku di hadapan.',
    '["Maintain speed and brake if traffic slows suddenly", "Reduce speed early and increase following distance", "Change lanes to avoid slower traffic ahead", "Maintain speed and focus on the vehicle ahead"]'::jsonb,
    '["Kekalkan kelajuan dan brek jika trafik perlahan secara tiba-tiba", "Kurangkan kelajuan lebih awal dan tambah jarak kenderaan", "Tukar lorong untuk mengelakkan trafik perlahan", "Kekalkan kelajuan dan fokus pada kenderaan di hadapan"]'::jsonb,
    1,
    'Reduce speed early to create time and space for sudden road changes.',
    'Kurangkan kelajuan lebih awal untuk memberi masa dan ruang apabila keadaan jalan berubah.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ca6525aa-8394-460c-b839-e799447f70c5',
    NULL,
    'At a controlled checkpoint, valid credentials are required and one credential has expired.',
    'Di pusat pemeriksaan kawalan, kelayakan yang sah diperlukan dan satu kelayakan telah tamat tempoh.',
    '["Stop at the checkpoint and report the issue", "Proceed slowly and resolve it afterward", "Wait to see if access is granted without it", "Continue forward since monitoring appears light"]'::jsonb,
    '["Berhenti di pusat pemeriksaan dan laporkan masalah tersebut", "Terus bergerak perlahan dan selesaikan kemudian", "Tunggu untuk melihat sama ada akses dibenarkan tanpa kelayakan", "Terus bergerak kerana pemantauan kelihatan kurang ketat"]'::jsonb,
    0,
    'Stop and meet credential requirements before proceeding.',
    'Berhenti dan pastikan kelayakan dipenuhi sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'cb38b08b-b1e7-405d-873a-4382777d620e',
    NULL,
    'After loading at a site, procedure requires using a designated exit route.',
    'Selepas selesai memunggah keluar di tapak, prosedur memerlukan anda menggunakan laluan keluar yang ditetapkan.',
    '["Follow the designated exit route and site rules", "Take a shorter route since no traffic is visible", "Exit on the path that saves the most time", "Exit based on familiarity"]'::jsonb,
    '["Ikut laluan keluar dan peraturan pergerakan tapak", "Ambil laluan lebih pendek kerana tiada trafik kelihatan", "Ambil laluan keluar yang menjimatkan masa", "Keluar berdasarkan kebiasaan"]'::jsonb,
    0,
    'Follow site exit routes and movement rules.',
    'Ikut laluan keluar dan peraturan pergerakan tapak.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6138ee81-f423-433f-9e37-672a828ced16',
    NULL,
    'During unloading, site staff suggest recording different details on the delivery documents to save time.',
    'Semasa proses memunggah, kakitangan tapak mencadangkan supaya butiran pada dokumen penghantaran direkod berbeza untuk jimat masa.',
    '["Record the actual details accurately", "Adjust the details slightly so unloading can finish smoothly", "Note the change later to keep the paperwork acceptable", "Leave the documents for someone else to complete"]'::jsonb,
    '["Catat butiran yang sebenarnya dengan tepat", "Ubah sedikit butiran supaya proses memunggah selesai dengan lancar", "Catat perubahan kemudian supaya dokumen masih kelihatan boleh diterima", "Biarkan dokumen untuk disiapkan oleh orang lain"]'::jsonb,
    0,
    'Recording accurate details supports accountability and prevents issues later.',
    'Merekod butiran dengan tepat membantu pastikan tanggungjawab jelas dan elakkan masalah pada masa akan datang.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7f7e4dde-d930-4451-a621-6a736d9a8773',
    NULL,
    'During inspection, you realise the vehicle has no working torchlight.',
    'Semasa pemeriksaan, anda mendapati tiada lampu suluh yang berfungsi di dalam kenderaan.',
    '["Proceed if driving is during daytime only.", "Replace the torchlight before operating the vehicle.", "Use your phone light if needed.", "Continue since other safety items are present."]'::jsonb,
    '["Teruskan perjalanan jika pemanduan hanya pada waktu siang.", "Gantikan lampu suluh tersebut sebelum mengendalikan kenderaan.", "Gunakan lampu telefon bimbit jika perlu.", "Teruskan kerana peralatan keselamatan lain masih ada."]'::jsonb,
    1,
    'Ensure required safety equipment is present and functional.',
    'Pastikan peralatan keselamatan yang diperlukan tersedia dan berfungsi dengan baik.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd590c955-04a8-4e79-a9b6-384f4714db61',
    NULL,
    'As a driver, you must remain aware of the expiry and renewal dates of vehicle and operating documents.',
    'Sebagai seorang pemandu, anda perlu peka terhadap tarikh tamat tempoh dan pembaharuan dokumen kenderaan serta operasi.',
    '["Monitor the dates and arrange renewal before expiry.", "Wait for reminders from the office.", "Check the dates only during inspections.", "Rely on company personnel to identify expiry."]'::jsonb,
    '["Pantau tarikh tersebut dan uruskan pembaharuan sebelum tamat tempoh.", "Tunggu peringatan daripada pejabat.", "Semak tarikh hanya semasa pemeriksaan.", "Bergantung kepada pegawai syarikat untuk mengenal pasti tarikh tamat tempoh."]'::jsonb,
    0,
    'Be aware of expiry dates and renew documents before they lapse.',
    'Sentiasa peka terhadap tarikh tamat tempoh dan perbaharui dokumen sebelum tempoh sahnya berakhir.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '66fcf3e1-778f-4bc3-aaff-89fc59d767f0',
    NULL,
    'During pre-trip inspection, you discover a brake defect before departure.',
    'Semasa pemeriksaan pra-perjalanan, anda menemui masalah pada brek sebelum berlepas.',
    '["Proceed carefully and monitor the defect during the journey", "Delay reporting until after completing the delivery", "Report the defect immediately and follow required procedures", "Ignore the defect to avoid operational delays"]'::jsonb,
    '["Teruskan dengan berhati-hati dan pantau masalah sepanjang perjalanan", "Tangguhkan laporan sehingga penghantaran selesai", "Laporkan masalah segera dan ikut prosedur yang ditetapkan", "Abaikan masalah untuk elakkan kelewatan operasi"]'::jsonb,
    2,
    'Defects must be reported before departure to ensure safety and integrity.',
    'Masalah mesti dilaporkan sebelum berlepas untuk memastikan keselamatan dan integriti.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '75b3d8cf-bc57-4fa2-aa32-dd1d3050d9e8',
    NULL,
    'During a site discussion, you realise the conversation may be overheard or recorded.',
    'Semasa perbincangan di tapak, anda sedar perbualan mungkin didengar atau dirakam.',
    '["Speak carefully and keep the discussion professional", "Lower your voice and limit further discussion", "End the conversation and return to work", "Continue speaking as you normally would"]'::jsonb,
    '["Bercakap dengan berhati-hati dan kekalkan profesionalisme", "Rendahkan suara dan hadkan perbincangan", "Tamatkan perbualan dan kembali bekerja", "Terus bercakap seperti biasa"]'::jsonb,
    0,
    'Choosing words carefully helps protect your professional image in visible situations.',
    'Pilih kata dengan cermat untuk lindungi imej profesional di tempat umum.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8e01a55b-e8d1-44ae-8e95-8229d3788455',
    NULL,
    'You are loading cargo and the total weight is close to the vehicle’s permitted limit.',
    'Anda sedang memuatkan kargo dan jumlah beratnya hampir mencapai had yang dibenarkan untuk kenderaan.',
    '["Load slightly above the limit if the distance is short.", "Ensure the load remains within the permitted weight limit.", "Proceed since the excess weight is minimal.", "Accept the customer\u2019s weight figure without verification."]'::jsonb,
    '["Muatkan sedikit melebihi had jika jarak adalah dekat.", "Pastikan muatan kekal dalam had berat yang dibenarkan.", "Teruskan perjalanan kerana lebihan berat adalah kecil.", "Terima angka berat pelanggan tanpa pengesahan."]'::jsonb,
    1,
    'Always operate within the approved weight limit.',
    'Sentiasa pastikan kenderaan beroperasi dalam had berat yang diluluskan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3afd3866-0c1c-4e3a-b0fd-8a430791f36f',
    NULL,
    'Before starting your trip, you review the vehicle’s licensing documents.',
    'Sebelum memulakan perjalanan, anda menyemak dokumen lesen kenderaan.',
    '["Proceed if the documents were checked last month.", "Verify that all required vehicle licences are valid.", "Continue driving and check only if stopped.", "Rely on the office to monitor document validity."]'::jsonb,
    '["Teruskan perjalanan jika dokumen telah diperiksa bulan lepas.", "Pastikan semua lesen kenderaan yang diperlukan masih sah.", "Terus memandu dan semak hanya jika ditahan.", "Bergantung kepada pejabat untuk memantau tempoh sah dokumen."]'::jsonb,
    1,
    'Ensure vehicle licensing documents are valid before operating.',
    'Pastikan semua dokumen lesen kenderaan masih sah sebelum mengendalikan kenderaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e41e4e8e-f7e6-478a-a6b0-49861694318c',
    NULL,
    'You are scheduled to begin duty at 5:00 AM.',
    'Anda dijadualkan untuk memulakan tugas pada pukul 5:00 pagi.',
    '["Arrive early to prepare before starting duty.", "Arrive exactly at 5:00 AM and prepare afterward.", "Arrive a few minutes late if traffic is light.", "Inform colleagues to cover while you arrive."]'::jsonb,
    '["Tiba lebih awal untuk membuat persediaan sebelum bertugas.", "Tiba tepat pukul 5:00 pagi dan buat persediaan selepas itu.", "Tiba lewat beberapa minit jika trafik lancar.", "Maklumkan rakan sekerja untuk mengambil alih tugas sementara anda tiba."]'::jsonb,
    0,
    'Arrive early to prepare and start duty on time.',
    'Tiba lebih awal untuk membuat persediaan dan memulakan tugas tepat pada masanya.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '93dac8bf-f2a9-42f3-b980-a3d2a402aff3',
    NULL,
    'You need to reverse into a marked bay inside a site. Space is tight, visibility is limited, and vehicles move nearby.',
    'Anda perlu mengundur ke petak bertanda di dalam tapak. Ruang sempit, pandangan terhad, dan kenderaan bergerak berhampiran.',
    '["Stop and reverse only when visibility and clearance are confirmed", "Reverse slowly while checking mirrors and adjusting position", "Continue reversing to avoid delaying vehicles behind", "Reverse carefully and rely on others to keep clear"]'::jsonb,
    '["Berhenti dan undur hanya apabila pandangan dan ruang selamat dipastikan", "Undur perlahan sambil periksa cermin dan sesuaikan kedudukan", "Terus undur untuk elakkan melambatkan kenderaan di belakang", "Undur dengan berhati-hati dan harap orang lain menjauh"]'::jsonb,
    0,
    'Confirm visibility and clearance before reversing in confined areas.',
    'Pastikan pandangan dan ruang selamat sebelum mengundur di kawasan sempit.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c8216388-0c88-4636-9943-fb994a95b32c',
    NULL,
    'During a rest stop, you notice rubbish and food containers inside the truck cabin.',
    'Semasa berhenti rehat, anda melihat sampah dan bekas makanan di dalam kabin lori.',
    '["Leave the cabin unchanged since cleanliness does not affect vehicle operation", "Clean the cabin later when the schedule is less demanding", "Clean and tidy the cabin immediately", "Remove only items that may interfere with driving controls"]'::jsonb,
    '["Biarkan kabin seperti itu kerana kebersihan tidak menjejaskan operasi kenderaan", "Bersihkan kabin kemudian apabila jadual kurang sibuk", "Bersihkan dan kemaskan kabin segera", "Buang hanya barang yang boleh mengganggu kawalan pemanduan"]'::jsonb,
    2,
    'Maintaining cabin cleanliness supports safe operation and professional standards.',
    'Menjaga kebersihan kabin menyokong operasi selamat dan mencerminkan profesionalisme.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7b0a29c4-f2d1-4c88-be7c-ad6e406359ef',
    NULL,
    'Inside a site, you approach a junction where parked equipment limits turning space.',
    'Di dalam tapak, anda menghampiri simpang dan jentera parkir mengehadkan ruang membelok.',
    '["Continue forward and adjust steering during the turn", "Stop early and reposition for a wider, safer turn", "Follow the shortest path to clear the junction", "Move closer before deciding how to turn"]'::jsonb,
    '["Teruskan ke hadapan dan laras stereng semasa membelok", "Berhenti awal dan ubah posisi untuk belokan yang lebih luas dan selamat", "Ikut laluan paling pendek untuk lepasi simpang", "Bergerak lebih dekat sebelum tentukan cara membelok"]'::jsonb,
    1,
    'Early positioning inside sites prevents tight turns, damage, and unnecessary corrections.',
    'Posisi awal yang betul di dalam tapak membantu elakkan belokan sempit, kerosakan dan pembetulan yang tidak perlu.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '041a027b-0cf2-4581-badf-19101655993c',
    NULL,
    'While driving, you notice the sun shade and stickers on the windscreen reduce your side visibility.',
    'Semasa memandu, anda mendapati pelindung matahari dan pelekat pada cermin hadapan mengurangkan penglihatan sisi.',
    '["Continue driving carefully despite reduced visibility.", "Stop at a safe location and remove or adjust the obstruction.", "Reduce speed and rely more on mirrors.", "Adjust your lane position to compensate for the blind area."]'::jsonb,
    '["Terus memandu dengan berhati-hati walaupun penglihatan terhad.", "Berhenti di lokasi yang selamat dan tanggalkan/laraskan halangan tersebut.", "Kurangkan kelajuan dan lebih bergantung pada cermin sisi.", "Laraskan kedudukan lorong untuk mengimbangi kawasan yang terhalang."]'::jsonb,
    1,
    'Ensure full visibility before continuing to drive safely.',
    'Pastikan penglihatan jelas sepenuhnya sebelum meneruskan pemanduan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '65bf4bc4-14e7-4e38-a38c-f36106a097c7',
    NULL,
    'Before leaving the loading point, you receive the delivery documents and the cargo has been loaded.',
    'Sebelum meninggalkan tempat loading, anda menerima dokumen penghantaran dan muatan telah siap dimuatkan.',
    '["Verify the DO number, PO number and quantity against the loaded cargo before departure", "Accept the documents as long as the warehouse confirms the loading is complete", "Check only the quantity because the document numbers are prepared by the warehouse", "Leave immediately to avoid delaying the delivery schedule"]'::jsonb,
    '["Semak nombor DO, nombor PO dan kuantiti dengan muatan sebelum bertolak", "Terima sahaja dokumen selagi pihak gudang mengesahkan loading telah selesai", "Semak kuantiti sahaja kerana nombor dokumen disediakan oleh pihak gudang", "Terus bertolak supaya jadual penghantaran tidak lewat"]'::jsonb,
    0,
    'Always verify the delivery documents against the loaded cargo before departure to prevent delivery errors.',
    'Sentiasa semak dokumen penghantaran dengan muatan sebelum bertolak bagi mengelakkan kesilapan penghantaran.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a2cbdae0-2b19-4d25-91ee-40793c6b4103',
    NULL,
    'After finishing a cigarette at the designated smoking area, what should you do?',
    'Selepas menghabiskan rokok di kawasan merokok yang dibenarkan, apakah yang perlu anda lakukan?',
    '["Dispose of the cigarette butt in the proper bin", "Drop it on the ground if it is fully extinguished", "Throw it into a nearby drain", "Leave it in the parking area"]'::jsonb,
    '["Buang puntung rokok ke dalam tong sampah", "Buang di atas tanah jika api telah padam sepenuhnya", "Buang ke dalam longkang berhampiran", "Tinggalkan di kawasan parkir"]'::jsonb,
    0,
    'Keep customer premises clean and professional.',
    'Pastikan premis pelanggan sentiasa bersih dan profesional.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6af0fe3b-3f4f-47d9-86e2-b139004c41d4',
    NULL,
    'While hauling an import container from the port, you notice a dent and scratches on the container wall.',
    'Semasa membawa kontena import dari pelabuhan, anda mendapati terdapat kesan kemek dan calar pada dinding kontena.',
    '["Record the damage in the gate pass before exiting the port.", "Inform operations after delivery.", "Record it only in the internal company form.", "Proceed since the seal is intact."]'::jsonb,
    '["Rekodkan kerosakan pada gate pass sebelum keluar dari pelabuhan.", "Maklumkan bahagian operasi selepas penghantaran.", "Rekodkan hanya dalam borang dalaman syarikat.", "Teruskan perjalanan kerana seal masih dalam keadaan baik."]'::jsonb,
    0,
    'Record visible container damage in the gate pass before leaving the port.',
    'Rekodkan sebarang kerosakan kontena yang kelihatan pada gate pass sebelum meninggalkan pelabuhan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '13e5fc9c-33db-4bd2-9ad0-698793c0f669',
    NULL,
    'You collect a reefer container and observe a worn power cable.',
    'Anda mengambil kontena berpendingin dari premis pelanggan dan mendapati terdapat kerosakan pada bahagian luar.',
    '["Record it internally and inform operations.", "Secure the cable and continue.", "Inform operations after delivery.", "Proceed if cooling is active."]'::jsonb,
    '["Catat dalam rekod dalaman dan maklumkan bahagian operasi.", "Amankan kabel dan teruskan perjalanan.", "Maklumkan kepada bahagian operasi selepas penghantaran selesai.", "Teruskan perjalanan jika sistem penyejukan masih berfungsi."]'::jsonb,
    0,
    'Document and report equipment defects before departure.',
    'Rekodkan dan laporkan kerosakan kontena sebelum meneruskan pergerakan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9d5fd91c-8b6f-424d-a155-dead7cfecc8f',
    NULL,
    'You notice damage on the container but are unsure whether the cargo inside is affected.',
    'Anda mendapati terdapat kerosakan pada kontena dan tidak pasti sama ada muatan di dalamnya terjejas.',
    '["Inform operations and wait for instruction.", "Proceed if the seal is intact.", "Deliver first and inspect at destination.", "Continue if external damage appears minor."]'::jsonb,
    '["Maklumkan bahagian operasi dan tunggu arahan lanjut.", "Teruskan perjalanan jika seal masih utuh.", "Hantar dahulu dan periksa di lokasi penghantaran.", "Teruskan perjalanan jika kerosakan luar kelihatan kecil."]'::jsonb,
    0,
    'Report uncertain damage before moving the container.',
    'Laporkan kerosakan yang tidak pasti sebelum menggerakkan kontena.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '72453420-d2b6-44fe-a117-209da9a100e2',
    NULL,
    'You arrive at the customer site to position the container.',
    'Anda tiba di tapak pelanggan untuk meletakkan kontena.',
    '["Position it at the nearest available space.", "Obtain customer approval before positioning.", "Follow previous delivery practice.", "Place it where it is easiest to exit."]'::jsonb,
    '["Letakkan di ruang terdekat yang tersedia.", "Dapatkan kelulusan pelanggan sebelum meletakkan kontena.", "Ikut amalan penghantaran sebelum ini.", "Letakkan di tempat yang paling mudah untuk keluar."]'::jsonb,
    1,
    'Obtain customer approval before positioning the container.',
    'Dapatkan kelulusan pelanggan sebelum meletakkan kontena.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3183a8f7-e626-4e0c-92ef-dda92fd38383',
    NULL,
    'You prepare to park and deploy trailer landing legs on uneven ground.',
    'Anda bersedia untuk parkir dan menurunkan kaki sokongan treler di permukaan tidak rata.',
    '["Stop and ensure the ground is stable before deploying", "Deploy slowly and monitor for sinking", "Proceed as usual since the area is commonly used", "Rely on visual checks and adjust if movement appears"]'::jsonb,
    '["Berhenti dan pastikan permukaan stabil sebelum menurunkan kaki sokongan treler", "Turunkan secara perlahan dan pantau jika berlaku mendapan", "Teruskan seperti biasa kerana kawasan tersebut biasa digunakan", "Bergantung pada pemeriksaan visual dan pelarasan jika pergerakan berlaku"]'::jsonb,
    0,
    'Assess ground stability before deploying landing legs.',
    'Periksa kestabilan permukaan sebelum menurunkan kaki sokongan treler.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2ea9bc70-ffaf-42dd-9e34-faa016aed001',
    NULL,
    'After a pre-trip inspection, you notice a twist lock is not fully secured though the container appears stable.',
    'Selepas pemeriksaan sebelum perjalanan, anda mendapati twist lock tidak dikunci sepenuhnya walaupun kontena kelihatan stabil.',
    '["Secure the twist lock before departing", "Start the trip but drive carefully", "Proceed since the container appears stable", "Monitor the load and act if it shifts"]'::jsonb,
    '["Pastikan twist lock dikunci dengan betul sebelum bergerak", "Mulakan perjalanan tetapi memandu dengan berhati-hati", "Teruskan kerana kontena kelihatan stabil", "Pantau muatan semasa perjalanan dan bertindak jika ia bergerak"]'::jsonb,
    0,
    'Correct load security issues before moving.',
    'Pastikan keselamatan muatan disahkan sebelum bergerak.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '88ff526f-1dd6-438d-a5d9-cfb92860c695',
    NULL,
    'You review the container number, type, and size against the gate pass and delivery note.',
    'Anda menyemak nombor kontena, jenis dan saiz dengan membandingkannya kepada gate pass dan nota penghantaran.',
    '["Proceed if the container looks correct.", "Confirm all container details match the documents.", "Check only the container number.", "Deliver first and update discrepancies later."]'::jsonb,
    '["Teruskan jika kontena kelihatan betul.", "Pastikan semua butiran kontena sepadan dengan dokumen.", "Periksa nombor kontena sahaja.", "Hantar dahulu dan kemas kini perbezaan kemudian."]'::jsonb,
    1,
    'Ensure all container details match the official documents.',
    'Pastikan semua butiran kontena sepadan dengan dokumen rasmi sebelum berlepas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f1d2a70b-db08-4200-9f63-eea87e8d2ce7',
    NULL,
    'Before leaving the port, you find the container door slightly misaligned.',
    'Sebelum meninggalkan pelabuhan, anda mendapati pintu kontena sedikit tidak sejajar.',
    '["Record the door condition in the gate pass.", "Proceed since it can still be locked.", "Deliver first and update later.", "Ignore if seal is intact."]'::jsonb,
    '["Rekodkan keadaan pintu pada gate pass.", "Teruskan perjalanan kerana pintu masih boleh dikunci.", "Hantar dahulu dan kemas kini kemudian.", "Abaikan keadaan jika seal masih baik."]'::jsonb,
    0,
    'Record any container door defect in the gate pass before exit.',
    'Rekodkan sebarang kecacatan pintu kontena pada gate pass sebelum keluar.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd5ce98d3-1b59-4f3e-9fcb-e60eb73eff38',
    NULL,
    'A colleague asks to ride in your cabin as a second driver for convenience.',
    'Seorang rakan sekerja meminta untuk menaiki kabin anda sebagai pemandu kedua atas alasan kemudahan.',
    '["Allow the ride if the journey is short.", "Decline unless company authorisation is given.", "Allow the ride if the colleague is an employee.", "Permit the ride if no customers are affected."]'::jsonb,
    '["Benarkan jika perjalanan adalah singkat.", "Tolak kecuali terdapat kebenaran daripada syarikat.", "Benarkan jika rakan tersebut ialah pekerja syarikat.", "Benarkan jika tiada pelanggan yang terjejas."]'::jsonb,
    1,
    'Do not carry passengers without proper company authorisation.',
    'Jangan membawa penumpang tanpa kebenaran rasmi daripada syarikat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'da42055b-ebb1-4e25-b906-ce4a8f1919d3',
    NULL,
    'After a road collision, what should you record first?',
    'Selepas berlaku pelanggaran jalan raya, apakah yang perlu anda catat terlebih dahulu?',
    '["The exact accident location.", "The damages", "The estimated repair cost.", "The traffic condition."]'::jsonb,
    '["Lokasi kemalangan yang tepat.", "Kerosakan yang berlaku.", "Anggaran kos pembaikan.", "Keadaan trafik."]'::jsonb,
    0,
    'Record the accident location accurately.',
    'Catat lokasi kemalangan dengan tepat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '678dc2c2-d8dd-4de2-a133-c5d79130edd9',
    NULL,
    'You approach a junction inside an industrial site. Internal lanes intersect and site rules require vehicles to yield.',
    'Anda menghampiri persimpangan di dalam kawasan industri. Laluan dalaman bersilang dan peraturan tapak memerlukan kenderaan memberi laluan.',
    '["Slow down and follow the site junction rule", "Roll forward and proceed when the path looks clear", "Edge into the junction to signal intention", "Enter if nearby vehicles move through safely"]'::jsonb,
    '["Perlahankan kenderaan dan ikut peraturan persimpangan tapak", "Bergerak perlahan dan masuk apabila laluan kelihatan jelas", "Masuk sedikit ke persimpangan untuk memberi isyarat niat", "Masuk jika kenderaan berhampiran kelihatan melalui dengan selamat"]'::jsonb,
    0,
    'Apply site junction rules to prevent conflicts at internal intersections.',
    'Perlahankan kenderaan dan patuhi peraturan persimpangan tapak untuk mengelakkan konflik di persimpangan dalaman.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '08e11583-e778-4f40-b81f-0bd7a108bc89',
    NULL,
    'While preparing for delivery, you notice the cargo is not fully secured and the customer is waiting.',
    'Semasa bersedia untuk penghantaran, anda mendapati muatan tidak dikunci dengan sempurna dan pelanggan sedang menunggu.',
    '["Pause and secure the cargo before proceeding", "Continue carefully and address it afterward", "Proceed to avoid delay and handle carefully", "Proceed while explaining the situation to the customer"]'::jsonb,
    '["Berhenti seketika dan pastikan muatan dikunci dengan betul sebelum meneruskan", "Teruskan dengan berhati-hati dan selesaikan isu kemudian", "Teruskan untuk mengelakkan kelewatan dan kendalikan dengan berhati-hati", "Teruskan sambil menerangkan keadaan kepada pelanggan"]'::jsonb,
    0,
    'Secure cargo before delivery despite time pressure.',
    'Pastikan muatan selamat sebelum meneruskan penghantaran walaupun terdapat tekanan masa.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b4c6439b-3275-416e-a93d-10dbe5f5f281',
    NULL,
    'While reversing slowly inside a site, you notice steering response feels abnormal.',
    'Semasa mengundur perlahan di dalam tapak, anda merasakan tindak balas stereng tidak normal.',
    '["Continue reversing carefully to clear the area", "Stop the manoeuvre and assess the defect", "Complete the reverse and report afterward", "Reduce speed further and keep moving"]'::jsonb,
    '["Terus mengundur dengan berhati-hati untuk lepasi kawasan itu", "Hentikan manuver dan periksa keadaan", "Selesaikan undur dan laporkan selepas itu", "Kurangkan lagi kelajuan dan teruskan bergerak"]'::jsonb,
    1,
    'Stopping immediately when a defect is felt during manoeuvres prevents damage and injury.',
    'Hentikan kenderaan apabila terasa tanda tidak normal semasa manuver untuk elakkan kerosakan dan kecederaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '832006f2-7dd5-4fbe-9575-31464c688d6d',
    NULL,
    'You have completed a delivery at a customer site.',
    'Anda telah menyelesaikan penghantaran di tapak pelanggan.',
    '["Obtain the receiver\u2019s signature only.", "Obtain signature, company stamp, time received, and receiver\u2019s name.", "Take a photo of the unloaded goods as proof.", "Record the delivery details after returning to the office."]'::jsonb,
    '["Dapatkan tandatangan penerima sahaja.", "Dapatkan tandatangan, cap syarikat, masa terima dan nama penerima.", "Ambil gambar barang yang telah diturunkan sebagai bukti.", "Rekodkan butiran penghantaran selepas kembali ke pejabat."]'::jsonb,
    1,
    'Ensure full and proper customer confirmation for every delivery.',
    'Pastikan pengesahan penerimaan lengkap bagi setiap penghantaran.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '66c5cd31-a845-46b2-bf5b-cd93ec3bf8fa',
    NULL,
    'During initial reporting, what should you do if additional relevant details arise?',
    'Semasa laporan awal dibuat, apakah yang perlu anda lakukan jika terdapat maklumat tambahan yang berkaitan?',
    '["Share any information that supports the initial report.", "Limit information to basic facts only.", "Provide extra details only if requested later.", "Wait until writing a formal report."]'::jsonb,
    '["Kongsikan maklumat yang menyokong laporan awal.", "Hadkan maklumat kepada fakta asas sahaja.", "Berikan butiran tambahan hanya jika diminta kemudian.", "Tunggu sehingga menyediakan laporan rasmi."]'::jsonb,
    0,
    'Provide all relevant information for the initial response.',
    'Berikan semua maklumat yang berkaitan untuk tindakan awal yang tepat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '68b6fd6e-d355-4765-ac07-7885e33eecaf',
    NULL,
    'You approach a narrow access point inside a facility. Visibility is limited and vehicles may enter from the opposite direction.',
    'Anda menghampiri laluan masuk sempit di dalam fasiliti. Pandangan terhad dan kenderaan mungkin masuk dari arah bertentangan.',
    '["Slow early and wait until the access path is clear", "Continue forward cautiously and adjust if a vehicle appears", "Enter the access point to hold position", "Follow the vehicle ahead through the access"]'::jsonb,
    '["Perlahankan kenderaan lebih awal dan tunggu sehingga laluan benar-benar jelas", "Terus bergerak dengan berhati-hati dan sesuaikan jika kenderaan muncul", "Masuk ke laluan untuk menunggu", "Ikut kenderaan di hadapan melalui laluan"]'::jsonb,
    0,
    'Slow early and confirm the path is clear before entering.',
    'Perlahankan kenderaan lebih awal dan pastikan laluan jelas sebelum masuk.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0a75252e-9b29-4030-b2cc-197c3b8e3f55',
    NULL,
    'At a checkpoint, you are asked to present documents and notice the delivery time was recorded inaccurately.',
    'Di tempat pemeriksaan, anda diminta menunjukkan dokumen dan menyedari masa penghantaran direkod tidak tepat.',
    '["Present the document and clarify the timing if asked", "Hand over the document without mentioning the timing", "Explain verbally that the details are correct", "Ask for time to update the document before presenting it"]'::jsonb,
    '["Serahkan dokumen dan jelaskan masa jika ditanya", "Serahkan dokumen tanpa menyebut tentang masa", "Jelaskan secara lisan bahawa butiran adalah betul", "Minta masa untuk mengemas kini dokumen sebelum menyerahkannya"]'::jsonb,
    3,
    'Accurate documents and cooperation support smooth inspections.',
    'Dokumen yang tepat dan kerjasama membantu pemeriksaan berjalan lancar.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9526206f-65f8-41f1-a14a-5885515a3ffa',
    NULL,
    'While manoeuvring at low speed in a confined space, you notice resistance and a faint scraping sound.',
    'Semasa membuat manuver pada kelajuan rendah di ruang sempit, anda merasakan rintangan dan bunyi geseran ringan.',
    '["Stop and reassess clearance before continuing", "Proceed slowly and rely on steering to clear the space", "Apply more throttle to finish quickly", "Continue and inspect the vehicle after the manoeuvre"]'::jsonb,
    '["Berhenti dan semak semula ruang sebelum meneruskan", "Terus bergerak perlahan dan bergantung pada stereng", "Tekan minyak lebih untuk menyelesaikan manuver dengan cepat", "Teruskan dan periksa kenderaan selepas manuver selesai"]'::jsonb,
    0,
    'Stop when unusual resistance or sounds occur.',
    'Berhenti apabila terdapat rintangan atau bunyi tidak biasa.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fcaf1c7c-1d44-433f-8f51-7e1cea355db6',
    NULL,
    'Before departure, you identify a cargo safety concern while another party pressures you to move immediately.',
    'Sebelum berlepas, anda mengenal pasti isu keselamatan muatan sementara pihak lain mendesak anda bergerak segera.',
    '["Proceed carefully to avoid further discussion", "Address the safety concern and explain the delay calmly", "Agree to move briefly to reduce tension", "Remain silent and delay action"]'::jsonb,
    '["Teruskan dengan berhati-hati untuk elakkan perbincangan lanjut", "Tangani isu keselamatan muatan dan jelaskan kelewatan dengan tenang", "Setuju bergerak seketika untuk mengurangkan ketegangan", "Berdiam diri dan tangguhkan tindakan"]'::jsonb,
    1,
    'Address safety concerns first while responding calmly to others.',
    'Utamakan keselamatan sambil bertindak balas dengan tenang kepada pihak lain.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd1b88df3-b098-475a-8943-8fc7d064dd0c',
    NULL,
    'While moving on a wet, uneven surface, you notice abnormal vibration and reduced vehicle response.',
    'Semasa bergerak di permukaan basah dan tidak rata, anda merasakan getaran tidak normal dan tindak balas kenderaan berkurang.',
    '["Maintain steady movement to avoid wheel slip", "Stop and assess before continuing", "Adjust speed slightly and continue through the area", "Complete the movement and report the issue later"]'::jsonb,
    '["Kekalkan pergerakan stabil untuk elakkan gelinciran tayar", "Berhenti dan periksa sebelum meneruskan", "Laraskan kelajuan sedikit dan teruskan melalui kawasan itu", "Selesaikan pergerakan dan laporkan masalah kemudian"]'::jsonb,
    1,
    'Pause to assess mechanical signals under challenging surface conditions.',
    'Berhenti dan periksa isu mekanikal dalam keadaan permukaan yang mencabar.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '725f25dc-a269-4605-8f0d-967f22813016',
    NULL,
    'A colleague suggests you keep quiet about a major issue to avoid attention from management.',
    'Seorang rakan sekerja mencadangkan  supaya anda berdiam diri tentang satu isu besar untuk elakkan perhatian pihak pengurusan.',
    '["Explain clearly why the issue should be reported", "Agree to stay quiet to keep things smooth", "Avoid responding and let the matter pass", "Say little and continue with your work"]'::jsonb,
    '["Jelaskan dengan terang mengapa isu itu perlu dilaporkan", "Setuju untuk berdiam diri supaya keadaan kekal tenang", "Elakkan memberi respons dan biarkan perkara itu berlalu", "Kurangkan bercakap dan teruskan kerja anda"]'::jsonb,
    0,
    'Clear communication and honesty help prevent larger problems later.',
    'Komunikasi yang jelas dan jujur membantu elakkan masalah menjadi lebih besar.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a8325a6e-5a1d-49dd-b93f-34202f845d91',
    NULL,
    'After a road accident, the Emergency Response Team contacts you.',
    'Selepas kemalangan jalan raya, Pasukan Tindak Balas Kecemasan menghubungi anda.',
    '["Provide clear details of what happened, time, location, and vehicles involved.", "Inform them only that an accident occurred.", "Ask them to obtain details from witnesses.", "Provide information after returning to depot."]'::jsonb,
    '["Berikan maklumat jelas tentang apa yang berlaku, masa, lokasi dan kenderaan yang terlibat.", "Maklumkan bahawa kemalangan telah berlaku sahaja.", "Minta mereka mendapatkan maklumat daripada saksi.", "Berikan maklumat selepas kembali ke depot."]'::jsonb,
    0,
    'Provide clear and accurate accident details immediately.',
    'Berikan maklumat kemalangan yang jelas dan tepat dengan segera.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9e665e95-e7dd-41bb-9c0a-0c523507157e',
    NULL,
    'You are reversing toward a loading bay when the loading supervisor signals you to stop because workers are still nearby.',
    'Anda sedang mengundur ke petak loading apabila penyelia loading memberi isyarat supaya berhenti kerana masih ada pekerja berhampiran.',
    '["Stop immediately and wait for the supervisor''s signal before continuing.", "Continue reversing slowly because the workers can move aside.", "Ask the workers to clear the area while continuing to reverse.", "Ignore the supervisor''s signal because your mirrors show the path is clear."]'::jsonb,
    '["Berhenti serta-merta dan tunggu isyarat penyelia sebelum meneruskan.", "Terus mengundur perlahan kerana pekerja boleh beredar.", "Minta pekerja beredar sambil terus mengundur.", "Abaikan isyarat penyelia kerana laluan kelihatan jelas melalui cermin."]'::jsonb,
    0,
    'Stop manoeuvring when instructed and continue only after receiving a clear signal that it is safe.',
    'Berhenti apabila diarahkan dan teruskan hanya selepas penyelia memberi isyarat bahawa keadaan selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b0521451-c3c5-469b-ac82-85110aef6696',
    NULL,
    'While driving through a community area, people nearby gesture for you to slow down as you pass.',
    'Semasa melalui kawasan komuniti, orang di sekitar memberi isyarat supaya anda memperlahankan kenderaan.',
    '["Reduce speed and continue driving considerately", "Maintain your speed since you are within the limit", "Slow briefly, then resume your previous speed", "Focus ahead and avoid reacting to the gestures"]'::jsonb,
    '["Kurangkan kelajuan dan teruskan pemanduan dengan penuh pertimbangan", "Kekalkan kelajuan kerana masih dalam had yang dibenarkan", "Perlahankan seketika, kemudian sambung semula kelajuan asal", "Fokus ke hadapan dan abaikan isyarat tersebut"]'::jsonb,
    0,
    'Adjusting speed in response to community signals shows courtesy and respect for local conditions.',
    'Melaras kelajuan mengikut keadaan setempat menunjukkan sikap hormat dan prihatin terhadap komuniti.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f4ff187d-3441-4197-842e-b7e7f837b390',
    NULL,
    'Your goods vehicle is experiencing failure on a highway and assistance has arrived.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan bantuan telah tiba.',
    '["Leave the vehicle where it stopped since help is present.", "Move the vehicle to a safer location when possible.", "Wait until traffic reduces before relocating.", "Relocate only if other drivers signal it is safe."]'::jsonb,
    '["Biarkan kenderaan di tempat ia berhenti kerana bantuan telah tiba.", "Alihkan kenderaan ke lokasi yang lebih selamat jika keadaan mengizinkan.", "Tunggu sehingga trafik berkurangan sebelum mengalihkan kenderaan.", "Alihkan hanya jika pemandu lain memberi isyarat selamat."]'::jsonb,
    1,
    'Relocate the vehicle to minimise continued traffic exposure.',
    'Alihkan kenderaan ke lokasi lebih selamat untuk mengurangkan pendedahan berterusan kepada trafik.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '07b60d39-1cb2-41d4-b0ec-dddeef207554',
    NULL,
    'While driving inside a site with pedestrians and equipment moving nearby, your phone receives a message.',
    'Semasa memandu di dalam tapak dengan pekerja dan jentera bergerak berhampiran, telefon anda menerima mesej.',
    '["Ignore the message and maintain full attention", "Check the message briefly since speed is low", "Slow down and glance when the area looks clear", "Respond quickly."]'::jsonb,
    '["Abaikan mesej dan kekalkan tumpuan penuh", "Periksa mesej seketika kerana kelajuan rendah", "Perlahankan dan lihat mesej apabila kawasan kelihatan selamat", "Balas mesej dengan cepat."]'::jsonb,
    0,
    'Avoid distractions in mixed-movement areas.',
    'Elakkan gangguan di kawasan pergerakan bercampur.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7149e6fb-f6f8-41dc-b217-feaf6b87fdc2',
    NULL,
    'You drive at cruising speed. Vehicles ahead brake intermittently and motorcycles filter between lanes.',
    'Anda memandu pada kelajuan tetap. Kenderaan di hadapan membrek dan motosikal bergerak di antara lorong.',
    '["Increase following distance for sudden slowing", "Maintain distance and brake if traffic slows", "Move closer to match the pace ahead", "Change lanes to avoid unpredictable movement"]'::jsonb,
    '["Tambah jarak kenderaan untuk lebih bersedia", "Kekalkan jarak dan brek jika trafik perlahan", "Bergerak lebih dekat untuk ikut kelajuan di hadapan", "Tukar lorong untuk elakkan pergerakan tidak menentu"]'::jsonb,
    0,
    'Extra space gives more time to respond to hazards ahead.',
    'Ruang tambahan memberi lebih masa untuk bertindak terhadap bahaya di hadapan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd94a8913-1a85-4082-97c1-974186f0a0f0',
    NULL,
    'While driving, your phone receives a message and you are slightly above the speed limit.',
    'Semasa memandu, telefon anda menerima mesej dan anda memandu sedikit melebihi had laju.',
    '["Slow to the legal speed and ignore the message", "Maintain speed and quickly check the message", "Reduce speed slightly and read when traffic allows", "Keep speed steady and reply briefly"]'::jsonb,
    '["Kurangkan kelajuan ke had yang dibenarkan dan abaikan mesej tersebut", "Kekalkan kelajuan dan periksa mesej dengan cepat", "Kurangkan sedikit kelajuan dan baca apabila keadaan sesuai", "Kekalkan kelajuan dan balas mesej secara ringkas"]'::jsonb,
    0,
    'Follow speed limits and avoid device use while driving.',
    'Patuhi had laju dan elakkan penggunaan telefon semasa memandu.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '269108da-db6b-4460-901b-4efe63258af8',
    NULL,
    'After a trip, you identify a minor defect before completing the handover documentation.',
    'Selepas tamat perjalanan, anda mengesan kerosakan kecil sebelum melengkapkan dokumentasi serahan kenderaan.',
    '["Record the defect accurately and submit the documentation", "Submit the documentation first and update the defect record later", "Delay recording the defect until the next scheduled inspection", "Note the defect informally and proceed with documentation"]'::jsonb,
    '["Rekodkan kerosakan dengan tepat dan serahkan dokumentasi", "Serahkan dokumentasi dahulu dan kemas kini rekod kerosakan kemudian", "Tangguhkan merekod kerosakan sehingga pemeriksaan seterusnya", "Catat kerosakan secara tidak rasmi dan teruskan dokumentasi"]'::jsonb,
    0,
    'Defects must be formally recorded to ensure proper documentation and accountability.',
    'kerosakan mesti direkod secara rasmi untuk memastikan dokumentasi dan akauntabiliti yang betul.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd31bb983-cdc9-4424-836e-ee5f1d8f4bcc',
    NULL,
    'The reflective string delineators are damaged and no longer reflective.',
    'Tali delineator reflektif rosak dan tidak lagi memantulkan cahaya.',
    '["Continue if cones are available.", "Replace them with compliant reflective delineators.", "Use hazard lights instead.", "Keep them until the next inspection cycle."]'::jsonb,
    '["Teruskan perjalanan jika kon keselamatan tersedia.", "Gantikan dengan delineator reflektif yang mematuhi spesifikasi.", "Gunakan lampu kecemasan sebagai ganti.", "Kekalkan penggunaannya sehingga pemeriksaan seterusnya."]'::jsonb,
    1,
    'Maintain compliant reflective equipment for roadside safety.',
    'Pastikan peralatan reflektif yang mematuhi spesifikasi sentiasa tersedia untuk keselamatan di tepi jalan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '28d219a0-101c-4e68-b57d-0cecb9eb5a6f',
    NULL,
    'While parked at a public roadside stop, your engine is running near pedestrians and nearby premises.',
    'Semasa parkir di tepi jalan awam, enjin kenderaan masih hidup berhampiran pejalan kaki dan premis berdekatan.',
    '["Keep the engine running to maintain cabin comfort", "Shut down the engine while parked", "Keep the engine running and remain inside the vehicle", "Leave the engine running briefly before moving off"]'::jsonb,
    '["Biarkan enjin hidup untuk keselesaan kabin", "Matikan enjin semasa parkir", "Biarkan enjin hidup dan kekal di dalam kenderaan", "Biarkan enjin hidup seketika sebelum bergerak"]'::jsonb,
    1,
    'Shutting down the engine when parked protects company assets and shows respect for the public.',
    'Mematikan enjin semasa parkir melindungi aset syarikat dan menunjukkan hormat kepada orang awam.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fe961e09-0491-4fdc-bb31-e0c41c4e1163',
    NULL,
    'Before leaving the vehicle, you notice a company mobile phone has been left in plain view.',
    'Sebelum meninggalkan kenderaan, anda mendapati telefon bimbit syarikat diletakkan di tempat yang mudah dilihat.',
    '["Store the phone out of sight before leaving the vehicle.", "Leave it where it is if the stop will be brief.", "Cover it with delivery documents before locking the vehicle.", "Take the phone only if the delivery location appears busy."]'::jsonb,
    '["Simpan telefon di tempat yang tidak kelihatan sebelum meninggalkan kenderaan.", "Biarkan telefon di situ jika berhenti hanya seketika.", "Tutup telefon dengan dokumen penghantaran sebelum mengunci kenderaan.", "Bawa telefon hanya jika lokasi penghantaran kelihatan sibuk."]'::jsonb,
    0,
    'Keep valuable items out of sight to reduce the risk of opportunistic theft.',
    'Simpan barang berharga di tempat yang tidak mudah dilihat bagi mengurangkan risiko kecurian secara oportunis.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '70275579-db27-4d4b-be5c-477abe33d86c',
    NULL,
    'You need to smoke while waiting for loading instructions.',
    'Anda perlu merokok sementara menunggu arahan loading.',
    '["Smoke at the designated smoking area", "Smoke beside the lorry if loading has not started", "Smoke near the dock and discard the butt afterwards", "Leave the premises briefly and throw the cigarette butt near the entrance"]'::jsonb,
    '["Merokok di kawasan merokok yang dibenarkan", "Merokok di sebelah lori jika loading belum bermula", "Merokok berhampiran dock dan buang puntung rokok selepas itu", "Keluar sebentar dari premis dan buang puntung rokok berhampiran pintu masuk"]'::jsonb,
    0,
    'Follow site rules and maintain professional conduct on customer premises.',
    'Patuhi peraturan premis dan sentiasa bersikap profesional.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a0d5cfb7-d0b1-4789-a619-999212dc31fa',
    NULL,
    'Before moving the container, you inspect the seal.',
    'Sebelum menggerakkan kontena, anda memeriksa seal.',
    '["Ensure the seal is intact and secured.", "Proceed if the container door is locked.", "Check the seal only at delivery point.", "Rely on previous documentation."]'::jsonb,
    '["Pastikan seal dalam keadaan baik dan dikunci dengan betul.", "Teruskan perjalanan jika pintu kontena telah dikunci.", "Periksa seal hanya di lokasi penghantaran.", "Bergantung kepada dokumentasi terdahulu."]'::jsonb,
    0,
    'Ensure the container seal is intact before movement.',
    'Pastikan seal dalam keadaan baik sebelum menggerakkan kontena.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd6c3fc2f-d0ef-407f-a42b-9bb3a9b1a176',
    NULL,
    'The customer indicates a location that appears tight and near property.',
    'Pelanggan menunjukkan lokasi yang kelihatan sempit dan berhampiran harta benda.',
    '["Position quickly to minimise delay.", "Prioritise safety to prevent property damage or injury.", "Follow the instruction eventhough you have doubts.", "Ask workers to stand nearby to guide closely."]'::jsonb,
    '["Letakkan kontena dengan cepat untuk mengurangkan kelewatan.", "Utamakan keselamatan bagi mengelakkan kerosakan atau kecederaan.", "Teruskan walaupun anda mempunyai keraguan tentang ruang tersebut.", "Minta pekerja berdiri berhampiran untuk memberi panduan dari jarak dekat."]'::jsonb,
    1,
    'Prioritise safety when positioning containers on site.',
    'Utamakan keselamatan semasa meletakkan kontena di tapak.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a28b4f05-4902-4a25-bfe8-b37fe3653d9a',
    NULL,
    'After confirming the seal on a loaded export container, what should you do next?',
    'Selepas mengesahkan seal pada kontena eksport yang telah dimuatkan, apakah tindakan seterusnya?',
    '["Inform operations of the seal number.", "Proceed directly to the port.", "Record it only in your trip log.", "Provide the seal number at delivery."]'::jsonb,
    '["Maklumkan nombor seal kepada bahagian operasi.", "Terus bergerak ke pelabuhan.", "Rekodkan nombor seal hanya dalam log perjalanan sahaja.", "Berikan nombor seal semasa penghantaran."]'::jsonb,
    0,
    'Inform operations of the seal number for system update.',
    'Maklumkan nombor seal kepada bahagian operasi untuk kemas kini sistem.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd735d76f-874a-463d-9906-383d555f9842',
    NULL,
    'You are inside a terminal yard. A marshal signals you to hold while equipment moves in your path.',
    'Anda berada di dalam kawasan terminal. Seorang marshal memberi isyarat supaya berhenti sementara jentera bergerak di laluan anda.',
    '["Remain stationary until the marshal signals to proceed", "Ease forward slightly to improve visibility", "Hold briefly, then advance once equipment clears", "Follow the vehicle ahead if it begins moving"]'::jsonb,
    '["Kekal berhenti sehingga marshal memberi isyarat untuk bergerak", "Bergerak sedikit ke hadapan untuk meningkatkan jarak penglihatan", "Berhenti seketika kemudian bergerak apabila jentera beredar", "Ikut kenderaan di hadapan jika ia mula bergerak"]'::jsonb,
    0,
    'Follow marshal instructions and keep distance from operating equipment.',
    'Patuhi arahan marshal dan kekalkan jarak daripada jentera yang sedang beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0545304c-73a5-4e71-8dc3-a71dde834edb',
    NULL,
    'You are inside a container terminal where RTGs operate across marked lanes with clear zones.',
    'Anda berada di dalam terminal kontena di mana RTG beroperasi merentasi lorong bertanda dengan zon larangan.',
    '["Remain outside the clear zone until access is given", "Move along the lane edge while staying alert", "Advance slowly when the RTG appears to reposition", "Follow the vehicle ahead past the RTG"]'::jsonb,
    '["Kekal di luar zon larangan sehingga laluan dibenarkan", "Bergerak di tepi lorong sambil kekal peka", "Bergerak perlahan apabila RTG kelihatan beralih", "Ikut kenderaan di hadapan melepasi RTG"]'::jsonb,
    0,
    'Respect clear zones and wait for safe access near lifting equipment.',
    'Hormati zon larangan dan tunggu laluan selamat berhampiran jentera angkat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8b401f69-305b-4dfc-a524-0bedd501cd11',
    NULL,
    'You drive inside a container terminal. RTGs and reach stackers operate nearby and containers restrict visibility.',
    'Anda memandu di dalam terminal kontena. RTG dan reach stacker beroperasi berhampiran dan kontena menghadkan pandangan.',
    '["Reduce speed early and proceed cautiously", "Maintain normal speed and rely on operators to yield", "Accelerate briefly to clear the area", "Match the speed of nearby terminal vehicles"]'::jsonb,
    '["Kurangkan kelajuan lebih awal dan teruskan dengan berhati-hati", "Kekalkan kelajuan biasa dan bergantung pada pengendali untuk memberi laluan", "Tambah kelajuan seketika untuk melepasi kawasan itu", "Ikut kelajuan kenderaan terminal berhampiran"]'::jsonb,
    0,
    'Reduce speed near operating terminal equipment.',
    'Kurangkan kelajuan berhampiran jentera terminal yang beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '240ec39e-b256-45e8-9598-087d41995abe',
    NULL,
    'You approach a terminal gate where entry requires credential verification. One credential is no longer valid.',
    'Anda menghampiri pintu masuk terminal yang memerlukan pengesahan pas akses. Satu akses tidak lagi sah.',
    '["Stop the entry process and report the issue", "Proceed with entry and resolve the issue inside", "Wait to see if the gate allows access", "Continue toward the gate since the trip is scheduled"]'::jsonb,
    '["Hentikan proses masuk dan laporkan masalah tersebut", "Teruskan masuk dan selesaikan isu di dalam terminal", "Tunggu untuk melihat sama ada pintu membenarkan masuk", "Terus menuju ke pintu masuk kerana perjalanan telah dijadualkan"]'::jsonb,
    0,
    'Valid credentials are required before terminal entry.',
    'Dokumen akses yang sah diperlukan sebelum memasuki terminal.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    6,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '89f28645-44ec-4132-99df-c8e6e02f004f',
    NULL,
    'You are preparing for duty.',
    'Anda sedang membuat persediaan untuk bertugas.',
    '["Wear a collared shirt before reporting for duty.", "Wear any casual T-shirt as long as it is clean.", "Wear a sleeveless shirt in hot weather.", "Change only if instructed by a supervisor."]'::jsonb,
    '["Pakai baju berkolar sebelum melapor diri untuk bertugas.", "Pakai mana-mana baju T kasual asalkan bersih.", "Pakai baju tanpa lengan ketika cuaca panas.", "Tukar pakaian hanya jika diarahkan oleh penyelia."]'::jsonb,
    0,
    'Wear proper collared attire as required for duty.',
    'Pakai pakaian berkolar yang sesuai seperti yang ditetapkan semasa bertugas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2333766c-f780-4613-88ba-45a543b9dbe3',
    NULL,
    'After completing your assignment, you are returning the vehicle.',
    'Selepas menamatkan tugasan, anda hendak memulangkan kenderaan.',
    '["Park the truck at any available space nearby.", "Park the truck at the company\u2019s designated area.", "Leave the truck where it is most convenient.", "Park outside temporarily and inform later."]'::jsonb,
    '["Parkir lori di mana-mana ruang yang tersedia berhampiran.", "Parkir lori di kawasan yang ditetapkan oleh syarikat.", "Tinggalkan lori di tempat yang paling mudah.", "Parkir di luar buat sementara dan maklumkan kemudian."]'::jsonb,
    1,
    'Park company vehicles only at approved locations.',
    'Parkir kenderaan syarikat hanya di lokasi yang diluluskan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '776d1741-a3a5-46ca-8b4e-e825db1c68bf',
    NULL,
    'You are driving through a residential area where pedestrians are present and traffic is light.',
    'Anda memandu melalui kawasan perumahan dengan kehadiran pejalan kaki dan trafik yang ringan.',
    '["Maintain an appropriate speed and remain mindful of people nearby", "Drive slightly faster to clear the area quickly", "Match the flow of traffic and continue as usual", "Focus on the road ahead and avoid reacting to bystanders"]'::jsonb,
    '["Kekalkan kelajuan yang sesuai dan peka terhadap orang di sekeliling", "Pandu sedikit lebih laju untuk keluar dari kawasan itu dengan cepat", "Ikut aliran trafik dan teruskan seperti biasa", "Fokus ke hadapan dan abaikan pergerakan orang di tepi jalan"]'::jsonb,
    0,
    'Reducing speed in residential areas shows consideration for pedestrian safety.',
    'Mengurangkan kelajuan di kawasan perumahan menunjukkan keprihatinan terhadap keselamatan pejalan kaki.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '155b3985-9acd-4087-aa58-282fa3561ad3',
    NULL,
    'You merge from a slip road onto a busy highway. Vehicles ahead brake unevenly and motorcycles pass between lanes.',
    'Anda memasuki lebuh raya dari laluan masuk. Kenderaan di hadapan membrek tidak sekata dan motosikal bergerak di antara lorong.',
    '["Wait for a clearly safe gap before merging", "Merge and adjust speed once on the highway", "Use the gap quickly before traffic closes", "Move forward to signal intent and merge when traffic slows"]'::jsonb,
    '["Tunggu jarak/ruang yang benar-benar selamat sebelum masuk", "Masuk dahulu dan ubah kelajuan di lebuh raya", "Gunakan ruang  dengan cepat sebelum trafik menjadi padat/sesak", "Bergerak ke hadapan untuk beri isyarat niat dan masuk apabila trafik perlahan"]'::jsonb,
    0,
    'Choose a safe gap to avoid sudden braking and conflict during merging.',
    'Pilih jarak yang selamat untuk mengelakkan brek mengejut dan konflik semasa masuk ke lebuh raya.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2e0afa3f-ab7f-4917-884d-e38f467003bc',
    NULL,
    'At a site entrance, valid driving credentials are required. One required credential has expired.',
    'Di pintu masuk tapak, kelayakan memandu yang sah diperlukan. Satu kelayakan telah tamat tempoh.',
    '["Stop the entry process and report the issue", "Complete the safety induction and resolve it later", "Proceed since rules will be explained during induction", "Wait to see if access is granted"]'::jsonb,
    '["Hentikan proses masuk dan laporkan masalah tersebut", "Selesaikan taklimat keselamatan dan uruskan kemudian", "Teruskan masuk kerana peraturan akan diterangkan semasa taklimat", "Tunggu untuk melihat sama ada akses dibenarkan"]'::jsonb,
    0,
    'Valid credentials are required before site entry.',
    'Kelayakan yang sah diperlukan sebelum memasuki tapak.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'cbe03bf3-d710-4edc-a86d-c9bafdad7e31',
    NULL,
    'While waiting inside a confined site area, the vehicle is idling near structures and pedestrians.',
    'Semasa menunggu di kawasan tapak yang sempit, enjin masih hidup berhampiran struktur dan pejalan kaki.',
    '["Keep the engine idling so you can move off quickly", "Switch off the engine while waiting", "Keep idling until instructed to move", "Remain stationary with the engine running"]'::jsonb,
    '["Biarkan enjin hidup supaya boleh bergerak segera", "Matikan enjin semasa menunggu", "Terus biarkan enjin hidup sehingga diarahkan bergerak", "Kekal berhenti dengan enjin masih hidup"]'::jsonb,
    1,
    'Switching off the engine when stationary reduces risk and unnecessary exposure in confined areas.',
    'Matikan enjin semasa berhenti untuk kurangkan risiko dan pendedahan',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5595d75c-aed6-47ad-b68c-752798ac00b5',
    NULL,
    'During a delivery discussion, someone becomes upset after you refuse an improper request.',
    'Semasa perbincangan penghantaran, seseorang menjadi tidak puas hati selepas anda menolak permintaan yang tidak sesuai.',
    '["Restate your position calmly and keep the discussion respectful", "Explain in detail why the request is wrong and unacceptable", "End the discussion abruptly to avoid further disagreement", "Respond firmly to make it clear the matter is closed"]'::jsonb,
    '["Nyatakan semula pendirian anda dengan tenang dan kekalkan perbincangan secara hormat", "Terangkan dengan terperinci mengapa permintaan itu salah dan tidak boleh diterima", "Tamatkan perbincangan secara mendadak untuk elak pertelingkahan lanjut", "Beri respons dengan tegas supaya jelas perkara itu telah selesai"]'::jsonb,
    0,
    'Holding your position calmly helps resolve issues without escalating conflict.',
    'Kekalkan pendirian dengan tenang untuk selesaikan isu tanpa meningkatkan ketegangan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '92f6d8de-0e10-4d58-8af8-5ef2ad63328b',
    NULL,
    'A driver behind you flashes headlights repeatedly and gestures, appearing impatient with your speed.',
    'Seorang pemandu di belakang anda berulang kali memberi lampu tinggi dan membuat isyarat, kelihatan tidak sabar dengan kelajuan anda.',
    '["Keep your speed steady and avoid responding to the behaviour", "Speed up slightly so the situation does not turn into an argument", "Change lanes when possible to prevent further confrontation", "React briefly to signal you have noticed the other driver"]'::jsonb,
    '["Kekalkan kelajuan secara konsisten dan elakkan memberi respons", "Tambah sedikit kelajuan supaya keadaan tidak menjadi tegang", "Tukar lorong apabila selamat untuk mengelakkan konfrontasi", "Beri respons ringkas untuk menunjukkan anda sedar akan kehadirannya"]'::jsonb,
    0,
    'Maintaining steady driving and not reacting helps prevent conflicts from escalating.',
    'Pemanduan yang stabil dan tidak bertindak balas membantu mengelakkan situasi daripada menjadi tegang.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '07d105c7-2015-4507-aca2-bad2490adb7b',
    NULL,
    'Your vehicle is due for scheduled maintenance according to the company/manufacturer’s manual.',
    'Kenderaan anda telah tiba masa menjalani penyelenggaraan berjadual mengikut manual syarikat atau pengeluar.',
    '["Continue operating since the vehicle is running smoothly.", "Follow the scheduled maintenance requirement.", "Postpone the service until the next trip cycle.", "Wait for further confirmation before arranging service."]'::jsonb,
    '["Terus beroperasi kerana kenderaan masih berfungsi dengan baik.", "Patuhi keperluan penyelenggaraan berjadual.", "Tangguhkan servis sehingga kitaran perjalanan seterusnya.", "Tunggu pengesahan lanjut sebelum mengaturkan servis."]'::jsonb,
    1,
    'Follow the company/manufacturer’s maintenance schedule as required.',
    'Patuhi jadual penyelenggaraan yang ditetapkan oleh syarikat atau pengeluar.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5375eab8-a913-4c93-805e-4fcec24a67d3',
    NULL,
    'During inspection, you notice the fire extinguisher has passed its expiry date.',
    'Semasa pemeriksaan, anda mendapati alat pemadam api telah melepasi tarikh luput.',
    '["Keep using it since it has not been discharged.", "Replace it with a compliant 9kg extinguisher within validity.", "Replace it with a compliant 6kg extinguisher within validity.", "Replace it with a compliant 5.5kg extinguisher within validity."]'::jsonb,
    '["Terus gunakan kerana ia belum pernah digunakan.", "Gantikan dengan alat pemadam api 9kg yang mematuhi spesifikasi dan masih dalam tempoh sah.", "Gantikan dengan alat pemadam api 6kg yang mematuhi spesifikasi dan masih dalam tempoh  sah.", "Gantikan dengan alat pemadam api 5.5kg yang mematuhi spesifikasi dan masih dalam tempoh  sah."]'::jsonb,
    1,
    'Ensure the required fire extinguisher meets the approved specification and validity.',
    'Pastikan alat pemadam api yang diperlukan mematuhi spesifikasi dan tempoh sah yang ditetapkan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fa5a1a36-a46e-4ee0-b7bb-0d9f5df593ce',
    NULL,
    'You arrive at a delivery location and notice the address differs from the delivery note.',
    'Anda tiba di lokasi penghantaran dan mendapati alamat berbeza daripada yang tertera pada nota penghantaran.',
    '["Deliver to the new address if the customer confirms verbally.", "Contact operations for confirmation before proceeding.", "Deliver if the location is nearby.", "Leave the goods with the person present at the site."]'::jsonb,
    '["Hantar ke alamat baharu jika pelanggan mengesahkan secara lisan.", "Hubungi bahagian operasi untuk pengesahan sebelum meneruskan penghantaran.", "Hantar jika lokasi berhampiran.", "Tinggalkan barang kepada individu yang berada di tapak."]'::jsonb,
    1,
    'Verify address changes with operations before delivery.',
    'Sahkan sebarang perubahan alamat dengan bahagian operasi sebelum membuat penghantaran.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a5a0fb6c-0eaf-4835-a6d8-1f11ee82f59d',
    NULL,
    'You approach a busy junction. Traffic slows and visibility is partly blocked by surrounding vehicles.',
    'Anda menghampiri persimpangan yang sibuk. Trafik perlahan dan sebahagian pandangan terhalang oleh kenderaan sekeliling.',
    '["Reduce speed early and prepare to stop", "Maintain speed and brake only if needed", "Slow slightly and move when the vehicle ahead moves", "Keep moving to clear the junction quickly"]'::jsonb,
    '["Kurangkan kelajuan lebih awal dan bersedia untuk berhenti", "Kekalkan kelajuan dan brek hanya jika perlu", "Perlahankan sedikit dan bergerak apabila kenderaan di hadapan bergerak", "Terus bergerak untuk melepasi persimpangan dengan cepat"]'::jsonb,
    0,
    'Reduce speed before junctions to respond safely to unexpected movement.',
    'Kurangkan kelajuan sebelum persimpangan untuk bertindak balas dengan selamat terhadap pergerakan mengejut.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a2f6e2f5-a42c-4ac5-adb6-2e2a6b89f455',
    NULL,
    'After a delivery, you park in a designated area where idling is prohibited.',
    'Selepas penghantaran, anda parkir di kawasan yang ditetapkan di mana enjin tidak dibenarkan hidup.',
    '["Switch off the engine and follow the parking procedure", "Leave the engine running briefly to save time", "Complete the procedure and address the engine later", "Wait in the vehicle with the engine on"]'::jsonb,
    '["Matikan enjin dan ikut prosedur parkir", "Biarkan enjin hidup seketika untuk menjimatkan masa", "Lengkapkan prosedur dahulu dan matikan enjin kemudian", "Tunggu di dalam kenderaan dengan enjin masih hidup"]'::jsonb,
    0,
    'Follow procedures and switch off the engine where idling is prohibited.',
    'Ikut prosedur dan matikan enjin di kawasan yang melarang melahu enjin.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '289e26c0-62b9-4fe5-88d4-81ea57cce345',
    NULL,
    'While waiting in an active loading zone, you notice cargo movement that may affect load stability.',
    'Semasa menunggu di zon pemuatan aktif, anda melihat pergerakan muatan yang boleh menjejaskan kestabilan muatan.',
    '["Remain in position and allow loading to continue", "Stop the process and alert site staff to address the cargo risk", "Move the vehicle slightly to reduce exposure", "Monitor the situation and proceed once loading appears stable"]'::jsonb,
    '["Kekal di tempat dan biarkan proses pemuatan diteruskan", "Hentikan proses dan maklumkan kakitangan tapak tentang risiko muatan", "Gerakkan kenderaan sedikit untuk mengurangkan pendedahan", "Pantau keadaan dan teruskan apabila pemuatan kelihatan stabil"]'::jsonb,
    1,
    'Address cargo instability promptly to prevent incidents in loading areas.',
    'Tangani ketidakstabilan muatan dengan segera untuk mengelakkan insiden di kawasan pemuatan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4fd51fcd-abb2-48a7-b318-e740ea6546db',
    NULL,
    'A staff member at the delivery premise hints that a small personal favour could speed up your delivery process.',
    'Seorang pekerja ditempat pelanggan mencadangkan bantuan peribadi kecil boleh mempercepatkan proses penghantaran.',
    '["Decline politely and follow standard procedures", "Accept the request to maintain good customer relations", "Delay the decision and see how the situation develops", "Refer the matter to another driver on site"]'::jsonb,
    '["Tolak dengan sopan dan ikut prosedur biasa", "Terima permintaan itu untuk jaga hubungan pelanggan", "Tangguhkan keputusan dan lihat perkembangan keadaan", "Rujuk perkara itu kepada pemandu lain di tapak"]'::jsonb,
    0,
    'Following standard procedures protects fairness and avoids improper influence.',
    'Mengikut prosedur yang sah membantu kekalkan keadilan dan elakkan pengaruh yang tidak wajar.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2c9b9d9c-4e30-40b9-bba9-9ebebabcf2fa',
    NULL,
    'Feeling unusually tired due to insufficient rest, you are about to enter a site with narrow internal lanes.',
    'Anda berasa amat letih kerana kurang rehat dan akan memasuki tapak dengan laluan dalaman sempit.',
    '["Delay site entry to take a short rest", "Enter carefully and rely on slow speed", "Proceed since the site is familiar", "Enter and take breaks after the manoeuvre"]'::jsonb,
    '["Tangguhkan kemasukan ke tapak untuk berehat seketika", "Masuk dengan berhati-hati dan bergantung pada kelajuan rendah", "Teruskan kerana tapak tersebut sudah biasa", "Masuk dan berehat selepas selesai manuver"]'::jsonb,
    0,
    'Address fatigue before entering confined areas.',
    'Atasi keletihan sebelum memasuki kawasan sempit.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'da96e698-94ce-4b55-90d7-2fa658edc127',
    NULL,
    'After a collision, the third party offers to settle repair costs privately.',
    'Selepas pelanggaran, pihak ketiga menawarkan untuk menyelesaikan kos pembaikan secara persendirian.',
    '["Accept the offer to avoid paperwork.", "Inform operations and wait for instruction.", "Negotiate and settle on the spot.", "Accept payment and continue duty."]'::jsonb,
    '["Terima tawaran untuk mengelakkan urusan dokumentasi.", "Maklumkan bahagian operasi dan tunggu arahan selanjutnya.", "Berunding dan selesaikan di tempat kejadian.", "Terima bayaran dan teruskan tugas."]'::jsonb,
    1,
    'Do not agree to private settlements without company instruction.',
    'Jangan bersetuju dengan penyelesaian persendirian tanpa arahan syarikat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b301a261-6bdb-4bb3-9e27-73efdc1c16ff',
    NULL,
    'You are holding your lane in slow traffic when another driver begins tailgating and sounding the horn.',
    'Anda mengekalkan lorong dalam trafik perlahan apabila pemandu di belakang mula mengekori rapat dan membunyikan hon.',
    '["Maintain your lane position and avoid reacting to the behaviour", "Shift position slightly to signal cooperation and reduce tension", "Change lanes quickly to get away from the situation", "Gesture briefly to show you have noticed the other driver"]'::jsonb,
    '["Kekalkan kedudukan lorong dan elakkan memberi respons", "Ubah sedikit kedudukan untuk menunjukkan kerjasama dan mengurangkan ketegangan", "Tukar lorong dengan cepat untuk menjauhkan diri daripada situasi", "Buat isyarat ringkas untuk menunjukkan anda sedar akan kehadirannya"]'::jsonb,
    0,
    'Holding lane discipline and not reacting helps prevent aggressive situations from escalating.',
    'Mengekalkan disiplin lorong dan tidak bertindak balas membantu mengelakkan situasi agresif daripada menjadi lebih tegang.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5fe2370e-c06f-449b-a532-d82034f9287b',
    NULL,
    'In a local area, another driver gestures courteously for you to merge while traffic slows.',
    'Di kawasan tempatan, seorang pemandu memberi isyarat sopan untuk membenarkan anda masuk ketika trafik semakin perlahan.',
    '["Signal clearly and merge when safe", "Merge promptly to return the courtesy", "Hesitate briefly to avoid appearing disrespectful", "Acknowledge the gesture and continue moving"]'::jsonb,
    '["Beri isyarat dengan jelas dan masuk apabila selamat", "Masuk segera untuk membalas kesopanan tersebut", "Tangguh seketika supaya tidak kelihatan tidak menghormati", "Balas isyarat tersebut dan teruskan bergerak"]'::jsonb,
    0,
    'Clear signalling should guide merging decisions, even when courtesy is shown by others.',
    'Isyarat yang jelas dan pertimbangan keselamatan perlu menjadi panduan walaupun diberi laluan oleh pemandu lain.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '66070080-0f94-4b0f-9f19-de00b6f45618',
    NULL,
    'A fire on your vehicle becomes large and difficult to control.',
    'Kebakaran pada kenderaan anda menjadi besar dan sukar dikawal.',
    '["Contact the fire brigade immediately.", "Continue using the extinguisher repeatedly.", "Wait for operations to arrive first.", "Move the vehicle slightly before deciding."]'::jsonb,
    '["Hubungi pasukan bomba dengan segera.", "Terus gunakan alat pemadam api berulang kali.", "Tunggu bahagian operasi tiba dahulu.", "Gerakkan kendaraan sedikit sebelum membuat keputusan."]'::jsonb,
    0,
    'Contact fire brigade when the fire escalates.',
    'Hubungi bomba apabila kebakaran menjadi besar dan tidak terkawal.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'beebe80f-9d81-4b07-9f92-77d7e58b906f',
    NULL,
    'While waiting inside a site, an emergency alarm sounds and vehicles are directed to clear the area.',
    'Semasa menunggu di dalam tapak, penggera kecemasan berbunyi dan kenderaan diarahkan mengosongkan kawasan.',
    '["Follow evacuation instructions.", "Keep the engine running and leave quickly", "Wait for clarification before acting", "Continue idling until site personnel approach"]'::jsonb,
    '["Ikut arahan pemindahan", "Kekalkan enjin hidup dan keluar dengan cepat", "Tunggu penjelasan lanjut sebelum bertindak", "Terus hidupkan enjin sehingga kakitangan tapak datang"]'::jsonb,
    0,
    'Follow evacuation instructions and manage the vehicle safely.',
    'Ikut arahan pemindahan dan kendalikan kenderaan dengan selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4e269ea4-bb5e-4916-be5b-5b2fc7935e65',
    NULL,
    'While driving, you notice unusual vibration and a new mechanical noise from the vehicle.',
    'Semasa memandu, anda merasakan getaran tidak normal dan bunyi mekanikal baharu daripada kenderaan.',
    '["Continue driving and observe if the noise disappears", "Stop safely and report the issue clearly to the supervisor", "Reduce speed and complete the trip as planned", "Mention the issue during the next scheduled check"]'::jsonb,
    '["Teruskan memandu dan lihat sama ada bunyi itu hilang", "Berhenti di tempat selamat dan laporkan masalah kepada penyelia", "Kurangkan kelajuan dan teruskan perjalanan seperti dirancang", "Nyatakan masalah semasa pemeriksaan seterusnya"]'::jsonb,
    1,
    'Early detection and clear reporting help prevent minor issues from becoming safety risks.',
    'Pengesanan awal dan laporan yang jelas membantu mengelakkan masalah kecil menjadi risiko keselamatan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '326d90af-439f-4dce-9001-b777946b5acd',
    NULL,
    'At a site checkpoint, you notice a vehicle defect just before being cleared to proceed.',
    'Di checkpoint tapak, anda perasan ada kerosakan pada kenderaan sejurus sebelum dibenarkan bergerak.',
    '["Proceed through the checkpoint and report the defect afterwards", "Stop at the checkpoint and report the defect immediately", "Move past the checkpoint and assess the defect", "Request guidance while remaining in the queue"]'::jsonb,
    '["Terus melepasi checkpoint dan laporkan kerosakan kemudian", "Berhenti di checkpoint dan laporkan kerosakan segera", "Lepasi checkpoint dan periksa kerosakan", "Minta panduan sambil kekal dalam barisan"]'::jsonb,
    1,
    'Reporting defects at checkpoints prevents unsafe entry into controlled zones.',
    'Laporkan kerosakan sebelum bergerak untuk elakkan risiko semasa masuk atau keluar kawasan terkawal.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '866d3465-b477-4e41-868e-6c93d25ce792',
    NULL,
    'Before leaving the vehicle overnight, you realise the locking fuel cap has been left unlocked.',
    'Sebelum meninggalkan kenderaan semalaman, anda sedar bahawa penutup tangki minyak yang berkunci tidak dikunci.',
    '["Lock the fuel cap before leaving the vehicle.", "Leave it unlocked if the fuel tank is almost empty.", "Lock it only when parking in unfamiliar areas.", "Check the fuel cap the following morning before departure."]'::jsonb,
    '["Kunci penutup tangki minyak sebelum meninggalkan kenderaan.", "Biarkan tidak berkunci jika tangki minyak hampir kosong.", "Kunci hanya apabila parking di kawasan yang tidak dikenali.", "Periksa penutup tangki minyak pada pagi esok sebelum bertolak."]'::jsonb,
    0,
    'Lock the fuel cap before leaving the vehicle to reduce the risk of fuel theft.',
    'Kunci penutup tangki minyak sebelum meninggalkan kenderaan bagi mengurangkan risiko curi minyak.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '205301ff-78da-4316-b13c-2264602894fb',
    NULL,
    'Heavy traffic means you expect to arrive more than 15 minutes after your scheduled unloading appointment.',
    'Kesesakan lalu lintas menyebabkan anda dijangka tiba lebih 15 minit lewat daripada waktu temujanji unloading.',
    '["Inform the site controller of the expected delay and follow further instructions", "Continue to the factory without notifying anyone", "Wait nearby until another unloading slot becomes available before contacting the site", "Request immediate unloading upon arrival regardless of the appointment schedule"]'::jsonb,
    '["Maklumkan kepada penyelaras tapak tentang kelewatan dan ikut arahan seterusnya", "Terus ke kilang tanpa memaklumkan sesiapa", "Tunggu berhampiran sehingga ada slot unloading sebelum menghubungi pihak tapak", "Minta unloading dilakukan serta-merta sebaik tiba tanpa mengira jadual temujanji"]'::jsonb,
    0,
    'Communicating delays promptly helps the site manage unloading appointments safely and efficiently.',
    'Maklumkan kelewatan secepat mungkin supaya pihak tapak dapat mengurus jadual unloading dengan selamat dan lancar.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9b6b77c4-69ad-4d5c-bb38-ce97ba6a2725',
    NULL,
    'Before entering an industrial site, you have not completed the required pre-trip inspection.',
    'Sebelum memasuki tapak industri, anda belum melengkapkan pemeriksaan pra-perjalanan kenderaan.',
    '["Enter the site carefully and complete checks later", "Complete the inspection and follow site entry rules", "Rely on previous checks and proceed as directed", "Ask site staff to guide you inside immediately"]'::jsonb,
    '["Masuk ke tapak dengan berhati-hati dan lakukan pemeriksaan kemudian", "Lengkapkan pemeriksaan dan patuhi peraturan kemasukan tapak", "Bergantung pada pemeriksaan sebelumnya dan teruskan seperti diarahkan", "Minta kakitangan tapak membimbing anda masuk segera"]'::jsonb,
    1,
    'Complete inspections before site entry to ensure readiness and compliance.',
    'Lengkapkan pemeriksaan sebelum memasuki tapak untuk memastikan kesiapsiagaan dan pematuhan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7fb24d45-c90f-4dee-a491-e1ab4f44eb58',
    NULL,
    'After weighing the loaded vehicle, the weighbridge ticket shows the legal vehicle weight has been exceeded.',
    'Selepas menimbang kenderaan bermuatan, slip timbang menunjukkan had berat kenderaan yang dibenarkan telah dilebihi.',
    '["Reduce the load to comply legal weight limit", "Continue if the excess weight is only slightly above the limit", "Drive more slowly to reduce the risk", "Proceed if the shipper accepts responsibility"]'::jsonb,
    '["Kurangkan muatan supaya mematuhi had berat yang dibenarkan", "Teruskan perjalanan jika lebihan berat hanya sedikit", "Pandu lebih perlahan untuk mengurangkan risiko", "Teruskan perjalanan jika pengirim bersetuju bertanggungjawab"]'::jsonb,
    0,
    'Do not begin the journey until the vehicle complies with all permitted gross and axle weight limits.',
    'Jangan bertolak sehingga had berat yang dibenarkan dipatuhi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '87568870-7b71-422a-a711-24d02daa83ca',
    NULL,
    'Before a forklift enters your parked vehicle for loading or unloading, what should you do?',
    'Sebelum forklift memasuki kenderaan anda untuk loading atau unloading, apakah yang perlu anda lakukan?',
    '["Place the wheel chocks before loading or unloading begins", "Apply only the handbrake before loading starts", "Position the wheel chocks only if the vehicle is heavily loaded", "Wait until the forklift enters before placing the wheel chocks"]'::jsonb,
    '["Pasang wheel chock sebelum loading atau unloading bermula", "Gunakan brek tangan sahaja sebelum loading bermula", "Pasang wheel chock hanya jika kenderaan membawa muatan berat", "Tunggu sehingga forklift masuk sebelum memasang wheel chock"]'::jsonb,
    0,
    'Place the wheel chocks before loading or unloading to help prevent unintended vehicle movement.',
    'Pasang wheel chock sebelum loading atau unloading bermula.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e5600046-8831-415c-9487-c096081dac08',
    NULL,
    'Why should wheel chocks be used during loading or unloading?',
    'Mengapa wheel chock perlu digunakan semasa loading atau unloading?',
    '["A parked vehicle may still move even with the handbrake applied", "Wheel chocks are only required when parking overnight", "Wheel chocks are only needed on sloping ground", "The forklift can prevent the vehicle from moving"]'::jsonb,
    '["Kenderaan yang diparkir masih boleh bergerak walaupun brek tangan digunakan", "Wheel chock hanya diperlukan semasa parkir semalaman", "Wheel chock hanya diperlukan di kawasan yang bercerun", "Forklift boleh menghalang kenderaan daripada bergerak"]'::jsonb,
    0,
    'Do not rely solely on the handbrake. Use wheel chocks to help keep the vehicle stable during loading or unloading.',
    'Jangan bergantung pada brek tangan sahaja. Gunakan wheel chock semasa loading atau unloading.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ea1ea8ca-0e4c-4f95-9921-9fb562950141',
    NULL,
    'After completing delivery, you notice some goods belonging to the customer remains inside your cargo area before leaving the premises.',
    'Selepas selesai membuat penghantaran, anda mendapati masih terdapat barang milik pelanggan di dalam ruang kargo sebelum meninggalkan premis.',
    '["Inform the customer or security immediately before leaving", "Leave with the goods and return it on your next trip", "Place the goods outside the customer''s premises and leave", "Wait until security discovers it during the exit inspection"]'::jsonb,
    '["Maklumkan kepada pelanggan atau pengawal keselamatan sebelum bertolak", "Bawa barang tersebut dan pulangkan pada perjalanan seterusnya", "Letakkan barang di luar premis pelanggan dan terus bertolak", "Tunggu sehingga pengawal menemuinya semasa pemeriksaan keluar"]'::jsonb,
    0,
    'Customer property must never be removed from the premises without authorisation. Report any remaining goods immediately before leaving.',
    'Jangan bawa keluar barang milik pelanggan tanpa kebenaran.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'aa573e33-2f4c-49f3-ad47-988b2132f359',
    NULL,
    'At the exit checkpoint, security asks whether your vehicle is completely empty after unloading.',
    'Di pintu keluar, pengawal keselamatan bertanya sama ada kenderaan anda benar-benar kosong selepas unloading.',
    '["Declare the vehicle is empty only after confirming no customer goods remain inside", "Say the vehicle is empty because unloading has been completed", "Tell security to inspect the vehicle without answering the question", "Leave the checkpoint if security appears busy"]'::jsonb,
    '["Periksa dahulu sebelum mengesahkan kenderaan kosong.", "Nyatakan kenderaan kosong kerana unloading telah selesai", "Minta pengawal memeriksa kenderaan tanpa menjawab soalan", "Tinggalkan pintu keluar jika pengawal kelihatan sibuk"]'::jsonb,
    0,
    'Always make truthful declarations during security checks. Verify the vehicle''s status before confirming it is empty.',
    'Pastikan kenderaan benar-benar kosong sebelum membuat pengisytiharan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9247a9a0-8ac8-4aaa-894a-0ab8337615ae',
    NULL,
    'While preparing to leave a customer''s premises, you discover a customer''s goods still inside your lorry as security signals you to proceed to the exit.',
    'Semasa bersedia meninggalkan premis pelanggan, anda mendapati masih terdapat barang pelanggan di dalam lori ketika pengawal memberi kebenaran untuk anda keluar.',
    '["Stop exit and report the goods to the customer.", "Keep the goods inside and explain only if security finds it", "Remove the goods outside the gate after passing the inspection", "Declare the vehicle is empty since unloading has already finished"]'::jsonb,
    '["Hentikan proses keluar dan laporkan barang tersebut kepada pelanggan", "Simpan barang tersebut dan jelaskan hanya jika pengawal menemuinya", "Keluarkan barang di luar pintu pagar selepas melepasi pemeriksaan", "Isytiharkan kenderaan kosong kerana unloading telah selesai"]'::jsonb,
    0,
    'Professional drivers demonstrate both ethical integrity and personal accountability by reporting any remaining customer property and making truthful declarations during exit inspections.',
    'Laporkan barang yang tertinggal dan buat pengisytiharan dengan jujur.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd3c878ab-f2ec-4606-a2f0-d9a0ca6ec848',
    NULL,
    'You are reversing towards a loading dock to begin unloading.',
    'Anda sedang mengundur ke loading dock untuk memulakan unloading.',
    '["Reverse slowly until the bumper contacts the rubber stop", "Reverse so the vehicle reaches the dock in one movement", "Stop about one metre from the dock and let staff reposition the vehicle", "Reverse before confirming the dock leveler is fully retracted"]'::jsonb,
    '["Undur perlahan sehingga bumper menyentuh rubber stop", "Undur supaya kenderaan sampai ke dock dalam satu pergerakan", "Berhenti kira-kira satu meter dari dock dan biarkan kakitangan melaraskan kedudukan kenderaan", "Undur tanpa memastikan dock leveler telah ditarik masuk sepenuhnya"]'::jsonb,
    0,
    'Reverse slowly and stop when the bumper contacts the rubber stop to achieve safe and accurate docking.',
    'Undur perlahan sehingga bumper menyentuh rubber stop.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5fecb463-64e1-4a70-9d8d-38050e68d4a5',
    NULL,
    'After docking at the loading bay, what should you do before unloading begins?',
    'Selepas berhenti di loading bay, apakah yang perlu anda lakukan sebelum unloading bermula?',
    '["Apply the handbrake, switch off the engine and place the wheel chocks", "Apply the handbrake and leave the engine running", "Switch off the engine and wait for warehouse staff to secure the vehicle", "Place the wheel chocks only if the loading bay slopes"]'::jsonb,
    '["Tarik brek tangan, matikan enjin dan pasang wheel chock", "Tarik brek tangan dan biarkan enjin hidup", "Matikan enjin dan tunggu kakitangan gudang mengamankan kenderaan", "Pasang wheel chock hanya jika loading bay bercerun"]'::jsonb,
    0,
    'Secure the vehicle before unloading using the handbrake, engine off and wheel chocks.',
    'Amankan kenderaan sebelum unloading dengan brek tangan, enjin dimatikan dan wheel chock.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c825d9ee-7c5f-4dff-8454-81c6e2c9732a',
    NULL,
    'While moving through a busy site, you feel abnormal resistance and hear a new mechanical sound.',
    'Semasa bergerak di tapak yang sibuk, anda merasakan rintangan tidak normal dan bunyi mekanikal baharu.',
    '["Continue moving slowly to clear the area", "Stop safely, assess the issue, and proceed only when clear", "Adjust steering and throttle to maintain site flow", "Complete the movement and report the issue afterward"]'::jsonb,
    '["Terus bergerak perlahan untuk keluar dari kawasan itu", "Berhenti di tempat selamat, periksa keadaan, dan teruskan hanya apabila jelas selamat", "Laraskan stereng dan pendikit untuk mengekalkan aliran pergerakan tapak", "Selesaikan pergerakan dan laporkan masalah selepas itu"]'::jsonb,
    1,
    'Respond promptly to mechanical cues and ensure the area is safe before proceeding.',
    'Bertindak segera terhadap tanda mekanikal dan pastikan kawasan selamat sebelum meneruskan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2f904db3-7af9-4570-b6ee-737fe9150f94',
    NULL,
    'After completing your task, you still have the lorry key.',
    'Selepas menamatkan tugasan, anda masih memegang kunci lori.',
    '["Take the key home for the next shift.", "Return the key to the company as required.", "Leave the key inside the vehicle.", "Keep the key until requested."]'::jsonb,
    '["Bawa pulang kunci untuk syif seterusnya.", "Pulangkan kunci kepada syarikat seperti yang ditetapkan.", "Tinggalkan kunci di dalam kenderaan.", "Simpan kunci sehingga diminta."]'::jsonb,
    1,
    'Return vehicle keys to the company after duty.',
    'Pulangkan kunci kenderaan kepada syarikat selepas bertugas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ce645e9f-b915-4a60-b69f-29bc2b2b5ca2',
    NULL,
    'You increase following distance in slow traffic. The driver behind closes in and flashes headlights repeatedly.',
    'Anda menambah jarak kenderaan dalam trafik perlahan. Pemandu di belakang merapat dan berulang kali memberi lampu tinggi.',
    '["Keep your distance and continue without responding", "Ease closer to avoid further confrontation behind you", "Acknowledge the other driver briefly so they know you noticed", "Adjust your driving to discourage the behaviour"]'::jsonb,
    '["Kekalkan jarak dan teruskan tanpa memberi respons", "Rapatkan sedikit jarak untuk mengelakkan ketegangan di belakang", "Beri isyarat ringkas supaya pemandu lain tahu anda sedar", "Sesuaikan cara pemanduan untuk menghalang tingkah laku tersebut"]'::jsonb,
    0,
    'Maintaining safe distance and not reacting helps prevent tension from escalating in traffic.',
    'Mengekalkan jarak selamat dan tidak bertindak balas membantu mengelakkan ketegangan di jalan raya.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'cdd92d9e-4fa9-4c2c-bec8-c2d180752671',
    NULL,
    'You notice there is no compliant safety vest in the vehicle.',
    'Anda mendapati tiada vest keselamatan yang mematuhi spesifikasi di dalam kenderaan.',
    '["Proceed if you remain inside the vehicle.", "Ensure a compliant safety vest is available before departure.", "Wear any bright-coloured clothing instead.", "Borrow one only when entering a site."]'::jsonb,
    '["Teruskan perjalanan jika anda kekal berada di dalam kenderaan.", "Pastikan vest keselamatan yang mematuhi spesifikasi tersedia sebelum memulakan perjalanan.", "Pakai sebarang pakaian berwarna terang sebagai ganti.", "Pinjam vest hanya apabila memasuki tapak."]'::jsonb,
    1,
    'Carry the required safety vest before operating.',
    'Pastikan vest keselamatan yang diperlukan dibawa sebelum beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '075c66aa-92a6-4819-b92d-3ce9dfb68d44',
    NULL,
    'While parked inside a site, an emergency alarm sounds and evacuation routes must be kept clear.',
    'Semasa parkir di dalam tapak, penggera kecemasan berbunyi dan laluan keluar mesti dikekalkan bebas halangan.',
    '["Remain in the cabin and wait for instructions", "Secure cabin items and clear the evacuation path immediately", "Leave the vehicle as it is and exit quickly", "Move the vehicle slightly to create more space"]'::jsonb,
    '["Kekal di dalam kabin dan tunggu arahan", "Pastikan barang dalam kabin tidak bergerak dan kosongkan laluan keluar segera", "Tinggalkan kenderaan seperti sedia ada dan keluar dengan cepat", "Gerakkan kenderaan sedikit untuk beri lebih ruang"]'::jsonb,
    1,
    'Secure loose items and clear evacuation routes immediately.',
    'Pastikan barang tidak bergerak dan kekalkan laluan keluar jelas dengan segera.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9bf4efa5-71cb-4b8e-9f0c-df7876db9a39',
    NULL,
    'After unloading, someone pressures you to change delivery records so the issue does not escalate.',
    'Selepas proses memunggah, seseorang menekan anda supaya mengubah rekod penghantaran agar isu tersebut tidak menjadi lebih besar.',
    '["Say the records must stay as they are and continue calmly", "Change the records slightly so the discussion can end", "Leave the records for now to avoid further disagreement", "Explain repeatedly why the records cannot be changed"]'::jsonb,
    '["Nyatakan rekod mesti kekal seperti sedia ada dan teruskan dengan tenang", "Ubah sedikit rekod supaya perbincangan boleh dihentikan", "Biarkan rekod dahulu untuk elak pertelingkahan lanjut", "Terangkan berulang kali mengapa rekod tidak boleh diubah"]'::jsonb,
    0,
    'Keeping records accurate while staying calm helps prevent conflict from escalating.',
    'Kekalkan rekod yang tepat sambil bersikap tenang untuk elakkan keadaan menjadi lebih tegang.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f34c92c6-d8e3-4cad-9e19-78872136312b',
    NULL,
    'You are reporting for duty after several weeks without a haircut.',
    'Anda melapor diri untuk bertugas selepas beberapa minggu tanpa memotong rambut.',
    '["Maintain short and neat hair as required.", "Keep long hair if tied properly.", "Trim only when reminded by HR.", "Maintain appearance only for inspections."]'::jsonb,
    '["Pastikan rambut sentiasa pendek dan kemas seperti yang ditetapkan.", "Simpan rambut panjang asalkan diikat dengan kemas.", "Potong rambut hanya apabila diingatkan oleh pihak sumber manusia (HR).", "Jaga penampilan hanya semasa pemeriksaan dijalankan."]'::jsonb,
    0,
    'Maintain neat and appropriate grooming for duty.',
    'Kekalkan penampilan yang kemas dan sesuai semasa bertugas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '71805f2a-eb47-4325-8dda-894572331bf1',
    NULL,
    'You approach a busy junction. Traffic slows unevenly and vehicles from the side edge forward.',
    'Anda menghampiri persimpangan sibuk. Trafik perlahan secara tidak sekata dan kenderaan dari sisi bergerak ke hadapan.',
    '["Hold your lane and approach at reduced speed", "Shift slightly within your lane to improve visibility", "Edge closer to discourage other vehicles", "Maintain speed and react only if a vehicle enters"]'::jsonb,
    '["Kekalkan lorong dan hampiri pada kelajuan rendah", "Bergerak sedikit dalam lorong untuk tingkatkan pandangan", "Bergerak lebih dekat untuk menghalang kenderaan lain", "Kekalkan kelajuan dan bertindak hanya jika kenderaan masuk"]'::jsonb,
    0,
    'Clear lane position and early speed control reduce conflict at junctions.',
    'Kedudukan lorong yang jelas dan kawalan kelajuan awal mengurangkan konflik di persimpangan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '92b13e8a-7aef-457e-a5e6-e35f8649e1bb',
    NULL,
    'Inside a site yard, equipment operates near your path when another vehicle cuts across.',
    'Di kawasan tapak, jentera beroperasi berhampiran laluan anda dan tiba-tiba sebuah kenderaan melintas di hadapan.',
    '["Slow down, keep distance from equipment, and continue calmly", "Adjust position to regain progress while watching equipment", "Proceed steadily to clear the area quickly", "Follow the vehicle ahead closely to avoid delay"]'::jsonb,
    '["Perlahankan, kekalkan jarak dari jentera, dan teruskan dengan tenang", "Laraskan kedudukan untuk meneruskan pergerakan sambil memerhati jentera", "Terus bergerak untuk melepasi kawasan itu dengan cepat", "Ikut kenderaan di hadapan dengan rapat untuk elakkan kelewatan"]'::jsonb,
    0,
    'Maintain composure and distance near operating equipment.',
    'Kekalkan ketenangan dan jarak selamat berhampiran jentera beroperasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b6d79ee2-29f8-41e4-9cac-1a958a097c4d',
    NULL,
    'Before starting duty, you have not completed the required rest and are still under medication.',
    'Sebelum memulakan tugas, anda belum mendapat rehat yang cukup dan masih di bawah kesan ubat.',
    '["Delay starting duty and report the issue", "Start the trip carefully since the route is familiar", "Begin driving and stop later if you feel affected", "Proceed and take rest after your shift"]'::jsonb,
    '["Tangguhkan tugas dan laporkan keadaan tersebut", "Mulakan perjalanan dengan berhati-hati kerana laluan sudah biasa", "Mula memandu dan berhenti kemudian jika terasa terjejas", "Teruskan dan ambil rehat selepas tamat syif"]'::jsonb,
    0,
    'Confirm fitness for duty before driving.',
    'Pastikan kecergasan untuk bertugas sebelum memandu.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd6627be0-f391-442b-8c99-414e832aeef3',
    NULL,
    'You arrive at a customer  premise and are told unloading will take longer than expected. The vehicle is parked safely.',
    'Anda tiba di tempat pelanggan dan dimaklumkan proses memunggah keluar akan mengambil masa lebih lama daripada jangkaan. Kenderaan telah diparkir dengan selamat.',
    '["Switch off the engine while waiting", "Keep the engine running to be ready to move", "Rev the engine occasionally", "Leave the engine idling and monitor the situation"]'::jsonb,
    '["Matikan enjin semasa menunggu", "Biarkan enjin hidup untuk bersedia bergerak", "Tekan minyak sekali-sekala", "Biarkan enjin melahu sambil memantau keadaan"]'::jsonb,
    0,
    'Switch off the engine during long waiting periods.',
    'Matikan enjin semasa menunggu lama untuk mengelakkan pembaziran bahan api.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f46c623d-d916-4979-a0a8-cdd1792ef5a2',
    NULL,
    'You approach a road section with temporary cones where pedestrians are crossing near your lane.',
    'Anda menghampiri laluan yang dipasang kon sementara dengan pejalan kaki melintas berhampiran lorong anda.',
    '["Maintain correct lane position and proceed cautiously past the area", "Move closer to the lane edge to pass through more quickly", "Adjust position to follow vehicles ahead without slowing", "Focus on traffic flow and avoid reacting to people nearby"]'::jsonb,
    '["Kekalkan kedudukan lorong yang betul dan pandu dengan berhati-hati melalui kawasan tersebut", "Rapat ke tepi lorong untuk melepasi kawasan dengan lebih cepat", "Laraskan kedudukan mengikut kenderaan di hadapan tanpa memperlahankan", "Fokus pada aliran trafik dan abaikan orang di sekitar"]'::jsonb,
    0,
    'Maintaining lane discipline and caution protects pedestrians and reflects responsible public conduct.',
    'Disiplin lorong dan pemanduan berhati-hati melindungi pejalan kaki serta mencerminkan sikap bertanggungjawab di tempat awam.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b8ddfb91-5d89-482b-93f6-ee495a568676',
    NULL,
    'You are involved in a minor incident during vehicle operation.',
    'Anda terlibat dalam satu insiden kecil semasa mengendalikan kenderaan.',
    '["Report the incident within 2 hours as required.", "Report it at the end of the workday.", "Report only if damage is visible.", "Wait until instructed before reporting."]'::jsonb,
    '["Laporkan insiden dalam tempoh 2 jam seperti yang ditetapkan.", "Laporkan pada akhir hari kerja.", "Laporkan hanya jika terdapat kerosakan yang dapat dilihat.", "Tunggu arahan sebelum membuat laporan."]'::jsonb,
    0,
    'Report accidents or incidents within the required reporting timeframe.',
    'Laporkan kemalangan atau insiden dalam tempoh masa pelaporan yang ditetapkan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'cbbb1b98-2cf0-4078-91b5-c0f99a6b988b',
    NULL,
    'You are completing a delivery trip.',
    'Anda menamatkan satu perjalanan penghantaran.',
    '["Record the meter reading only at the end of the trip.", "Record the meter reading before and after the trip.", "Record it only if fuel usage seems unusual.", "Estimate the reading based on distance travelled."]'::jsonb,
    '["Catat bacaan meter hanya pada akhir perjalanan.", "Catat bacaan meter sebelum dan selepas perjalanan.", "Catat hanya jika penggunaan bahan api kelihatan luar biasa.", "Anggarkan bacaan berdasarkan jarak perjalanan."]'::jsonb,
    1,
    'Record meter readings before and after each trip.',
    'Catat bacaan meter sebelum dan selepas setiap perjalanan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bac3019b-2289-4edf-b464-e49a22157725',
    NULL,
    'While driving inside a site, you see a posted speed limit.',
    'Semasa memandu di dalam tapak, anda melihat had laju yang dipaparkan.',
    '["Adjust speed to comply with the posted limit", "Maintain current speed since traffic is light", "Reduce speed slightly but continue comfortably", "Match the speed of other vehicles"]'::jsonb,
    '["Laraskan kelajuan untuk mematuhi had laju yang dipaparkan", "Kekalkan kelajuan kerana trafik ringan", "Kurangkan kelajuan sedikit tetapi teruskan dengan selesa", "Ikut kelajuan kenderaan lain"]'::jsonb,
    0,
    'Follow posted speed limits inside operational sites.',
    'Patuhi had laju yang ditetapkan di dalam kawasan operasi.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a7eb8a38-d9bc-4104-9bcf-8c03a846b207',
    NULL,
    'A customer calls you during the trip and urges you to arrive faster due to a delay.',
    'Seorang pelanggan menelefon semasa perjalanan dan mendesak anda tiba lebih cepat kerana berlaku kelewatan.',
    '["Maintain a safe speed and explain your expected arrival time", "Increase speed slightly to show effort and responsiveness", "Reassure the customer and focus on reaching sooner", "Shorten the conversation and continue driving as planned"]'::jsonb,
    '["Kekalkan kelajuan selamat dan maklumkan anggaran masa ketibaan", "Tambah sedikit kelajuan untuk tunjuk usaha dan responsif", "Yakinkan pelanggan dan cuba sampai lebih awal", "Pendekkan perbualan dan teruskan perjalanan seperti biasa"]'::jsonb,
    0,
    'Maintaining safe speed while giving a clear update supports both safety and customer trust.',
    'Kekalkan kelajuan selamat sambil beri maklumat jelas bagi menjaga keselamatan dan kepercayaan pelanggan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6b0c9237-9dcd-4f11-98eb-b17bd9386a18',
    NULL,
    'A vehicle cuts in sharply, making you angry. You need to change lanes while drivers around you are unsure of your intention',
    'Sebuah kenderaan memotong masuk secara mengejut sehingga anda berasa marah. Anda perlu menukar lorong ketika pemandu lain di sekitar tidak pasti tentang niat anda.',
    '["Regain composure and signal clearly before changing lanes", "Change lanes quickly to get away from the situation", "Sound the horn briefly to express frustration", "Hold your lane without signalling until traffic settles"]'::jsonb,
    '["Tenangkan diri dan beri isyarat dengan jelas sebelum menukar lorong", "Tukar lorong dengan cepat untuk menjauhkan diri daripada situasi", "Bunyi hon seketika untuk meluahkan rasa tidak puas hati", "Kekalkan lorong tanpa memberi isyarat sehingga trafik kembali stabil"]'::jsonb,
    0,
    'Clear signalling after regaining composure helps others understand your intentions and keeps traffic moving safely.',
    'Isyarat yang jelas selepas menenangkan diri membantu pemandu lain memahami niat anda dan memastikan aliran trafik kekal selamat.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4aa7a61c-df52-4389-ba30-1a050d2c9c66',
    NULL,
    'You are starting  your work shift for the day.',
    'Anda memulakan syif kerja pada hari tersebut.',
    '["Record your attendance at the end of the shift.", "Record your attendance  at the beginning and end of the shift.", "Inform your supervisor.", "Record attendance only when requested."]'::jsonb,
    '["Rekodkan kehadiran pada akhir syif.", "Rekodkan kehadiran pada awal dan akhir syif.", "Maklumkan kepada penyelia.", "Rekodkan kehadiran hanya apabila diminta."]'::jsonb,
    1,
    'Record attendance properly at the start and end of duty.',
    'Rekod kehadiran dengan betul pada awal dan akhir tugas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '28ee8d38-3640-4335-99c2-b42c5f8834a6',
    NULL,
    'After completing your trip, you notice a minor defect that developed during the drive.',
    'Selepas selesai perjalanan, anda mendapati kerosakan kecil berlaku semasa memandu.',
    '["Report the defect and ensure the vehicle is checked before reuse", "Note the defect later since the trip is completed", "Mention it informally to the next driver", "Leave the vehicle available since it still operates"]'::jsonb,
    '["Laporkan kerosakan dan pastikan kenderaan diperiksa sebelum digunakan semula", "Catat kerosakan kemudian kerana perjalanan telah selesai", "Beritahu secara tidak rasmi kepada pemandu seterusnya", "Biarkan kenderaan digunakan kerana masih boleh beroperasi"]'::jsonb,
    0,
    'Report defects promptly to prevent risk in the next operation.',
    'Laporkan kerosakan dengan segera untuk mengelakkan risiko dalam operasi seterusnya.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '490e23be-8892-4552-a16b-f48e8f9b995d',
    NULL,
    'Traffic slows unexpectedly, and a supervisor asks if you can make up time on the road.',
    'Trafik tiba-tiba menjadi perlahan dan penyelia bertanya sama ada anda boleh mengejar semula masa di jalan raya.',
    '["Keep to a safe speed and give a clear, realistic update", "Say you will try to make up time where possible", "Reassure them and focus on pushing ahead", "Keep the call short and continue driving"]'::jsonb,
    '["Kekalkan kelajuan selamat dan beri maklumat yang jelas serta realistik", "Beritahu bahawa anda akan cuba mengejar masa jika boleh", "Yakinkan penyelia dan fokus untuk bergerak lebih laju", "Pendekkan panggilan dan teruskan perjalanan"]'::jsonb,
    0,
    'Clear updates and safe driving help manage expectations without increasing risk.',
    'Maklumat yang jelas dan pemanduan selamat membantu urus jangkaan tanpa menambah risiko.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9997a90d-2b1b-4cd7-b44d-08abb73252d9',
    NULL,
    'Traffic ahead is moving, but you keep extra distance. A customer messages asking why progress feels slow.',
    'Trafik di hadapan bergerak, namun anda mengekalkan jarak yang lebih selamat. Pelanggan menghantar mesej bertanya mengapa pergerakan agak lambat.',
    '["Maintain safe following distance and explain the situation calmly", "Close the gap slightly so movement appears faster", "Reassure the customer and focus on keeping pace", "Ignore the message and continue driving"]'::jsonb,
    '["Kekalkan jarak selamat dan jelaskan keadaan dengan tenang", "Rapatkan sedikit jarak supaya pergerakan nampak lebih cepat", "Yakinkan pelanggan dan cuba kekalkan kelajuan trafik", "Abaikan mesej dan teruskan pemanduan"]'::jsonb,
    0,
    'Keeping a safe following distance while explaining the reason supports safety and customer confidence.',
    'Mengekalkan jarak selamat sambil memberi penjelasan membantu menjaga keselamatan dan keyakinan pelanggan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd360eba5-655e-4a54-bbfd-1adaa8c9bac5',
    NULL,
    'Another driver cuts in suddenly, forcing you to brake, then begins gesturing angrily at you.',
    'Seorang pemandu memotong masuk secara tiba-tiba sehingga anda terpaksa membrek, kemudian menunjukkan isyarat marah kepada anda.',
    '["Regain composure and continue driving without reacting", "Respond briefly to show you were affected by the move", "Accelerate to move away from the situation", "Slow further to signal your frustration"]'::jsonb,
    '["Tenangkan diri dan teruskan pemanduan tanpa memberi respons", "Beri respons ringkas untuk menunjukkan anda terkesan", "Tambah kelajuan untuk menjauhkan diri daripada situasi", "Perlahankan lagi kenderaan sebagai tanda tidak puas hati"]'::jsonb,
    0,
    'Maintaining composure and not reacting helps prevent aggressive situations from escalating.',
    'Mengekalkan ketenangan dan tidak bertindak balas membantu mengelakkan situasi agresif daripada menjadi lebih tegang.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ed77cd9c-23d7-4118-9948-a3b8774491e6',
    NULL,
    'Before driving into a customer premises, you are unsure whether your vehicle can safely clear an overhead structure.',
    'Sebelum memasuki premis pelanggan, anda tidak pasti sama ada kenderaan anda mempunyai ruang kelegaan yang mencukupi untuk melepasi struktur di bahagian atas.',
    '["Verify the available clearance before entering.", "Continue carefully while watching the roof clearance.", "Ask a colleague to observe the vehicle as you drive through.", "Reverse out only if the vehicle makes contact with the structure."]'::jsonb,
    '["Sahkan ruang kelegaan yang tersedia sebelum memasuki kawasan tersebut.", "Teruskan dengan berhati-hati sambil memerhatikan ruang kelegaan di bahagian atas.", "Minta rakan memerhati kenderaan semasa anda melaluinya.", "Undur keluar hanya jika kenderaan terkena struktur tersebut."]'::jsonb,
    0,
    'When clearance is uncertain, verify it before proceeding to avoid collisions with overhead structures.',
    'Jika ruang kelegaan tidak pasti, sahkannya terlebih dahulu sebelum meneruskan perjalanan bagi mengelakkan pelanggaran dengan struktur di bahagian atas.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'da5f5e37-7513-4e42-9f95-b3e1a331e804',
    NULL,
    'Before entering a narrow lane to make a delivery, you realise your vehicle may not have enough side clearance.',
    'Sebelum memasuki lorong yang sempit untuk membuat penghantaran, anda mendapati kenderaan anda mungkin tidak mempunyai ruang sisi yang mencukupi.',
    '["Fold the side mirrors before entering if it is safe to do so.", "Continue slowly while watching both mirrors closely.", "Ask pedestrians to guide the vehicle through the lane.", "Enter only after sounding the horn to warn others."]'::jsonb,
    '["Lipat cermin sisi sebelum memasuki lorong jika selamat berbuat demikian.", "Teruskan perlahan sambil memerhati kedua-dua cermin sisi.", "Minta pejalan kaki membantu mengarah kenderaan melalui lorong tersebut.", "Masuk hanya selepas membunyikan hon untuk memberi amaran kepada orang lain."]'::jsonb,
    0,
    'Adapt the vehicle to suit confined access conditions before proceeding to reduce the risk of vehicle damage.',
    'Sesuaikan kenderaan mengikut keadaan laluan yang sempit sebelum meneruskan perjalanan bagi mengurangkan risiko kerosakan pada kenderaan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3e921c5d-0a6b-496e-a0e7-a6a8386e5f63',
    NULL,
    'You are approaching a busy loading dock where other lorries are waiting to use adjacent bays.',
    'Anda menghampiri loading dock yang sibuk dengan lori lain sedang menunggu untuk menggunakan bay bersebelahan.',
    '["Reverse slowly until the bumper contacts the rubber stop", "Reverse before other lorries can use the bay", "Wait across the neighbouring bay until unloading starts", "Stop well short of the dock to avoid touching the rubber stop"]'::jsonb,
    '["Undur perlahan sehingga bumper menyentuh rubber stop", "Undur sebelum lori lain menggunakan bay tersebut", "Tunggu di hadapan bay bersebelahan sehingga unloading bermula", "Berhenti jauh dari dock untuk mengelakkan bumper menyentuh rubber stop"]'::jsonb,
    0,
    'Accurate docking protects loading equipment, while securing the vehicle and avoiding obstruction supports safe and efficient dock operations.',
    'Dock dengan tepat, amankan kenderaan dan elakkan menghalang operasi loading dock.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.25, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '35ba75d2-c108-4b28-8af1-fcb78f08f22e',
    NULL,
    'Before reversing towards a loading dock, what should you do?',
    'Sebelum mengundur ke loading dock, apakah yang perlu anda lakukan?',
    '["Check the type of dock leveler before reversing", "Reverse slowly until the dock leveler contacts the vehicle", "Ask warehouse staff after the vehicle is docked", "Use the same docking method for every loading bay"]'::jsonb,
    '["Periksa jenis dock leveler sebelum mengundur", "Undur perlahan sehingga dock leveler menyentuh kenderaan", "Tanya kakitangan gudang selepas kenderaan selesai didockkan", "Gunakan kaedah docking yang sama untuk semua loading bay"]'::jsonb,
    0,
    'Different dock levelers require different docking approaches.',
    'Jenis dock leveler yang berbeza memerlukan kaedah docking yang berbeza.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8454ea57-e93f-4aa5-ac45-b4100fa2ca69',
    NULL,
    'You are docking at an unfamiliar warehouse.',
    'Anda sedang melakukan docking di gudang yang tidak biasa anda kunjungi.',
    '["Check the dock leveler type and reverse slowly", "Use your usual docking method", "Reverse until the dock leveler stops the vehicle", "Reverse before other vehicles arrive"]'::jsonb,
    '["Periksa jenis dock leveler dan undur perlahan", "Gunakan kaedah docking biasa", "Undur sehingga dock leveler menghentikan kenderaan", "Undur sebelum kenderaan lain tiba"]'::jsonb,
    0,
    'Adapt your docking method to the dock leveler and reverse slowly to protect equipment.',
    'Sesuaikan kaedah docking mengikut jenis dock leveler dan undur perlahan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.25, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3153986a-4ee1-41df-8547-628ce70b7cb7',
    NULL,
    'Before leaving the loading point with a sealed load, what should you record on the delivery order?',
    'Sebelum meninggalkan tempat loading dengan muatan yang telah di seal, apakah yang perlu anda catatkan pada delivery order?',
    '["The seal number", "The vehicle mileage", "The driver''s licence number", "The loading duration"]'::jsonb,
    '["Nombor seal", "Bacaan odometer kenderaan", "Nombor lesen memandu pemandu", "Tempoh proses loading"]'::jsonb,
    0,
    'Record the seal number to maintain shipment integrity.',
    'Catat nombor seal untuk memastikan integriti penghantaran.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a4f428af-64f1-4e29-b2de-0e6991cf6a4f',
    NULL,
    'You arrive at the customer''s premises with a sealed load.',
    'Anda tiba di premis pelanggan dengan muatan yang telah dipasang seal.',
    '["Let the receiver verify the seal before breaking it", "Break the seal before the receiver arrives", "Remove the seal once the vehicle is parked", "Cut the seal if unloading is delayed"]'::jsonb,
    '["Benarkan penerima memeriksa seal sebelum membukanya", "Buka seal sebelum penerima tiba", "Buka seal sebaik sahaja kenderaan diparkir", "Potong seal jika unloading tertangguh"]'::jsonb,
    0,
    'Break the seal only after the receiver has verified it.',
    'Buka seal hanya selepas penerima mengesahkannya.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a2c59508-7a47-47d3-ad80-d284c99ec0f9',
    NULL,
    'A sealed load is delivered at the customer''s premises.',
    'Muatan yang dipasang seal dihantar ke premis pelanggan.',
    '["Verify the seal number with the receiver before breaking the seal", "Break the seal first to speed up unloading", "Remove the seal if the number matches your records", "Ask the warehouse staff to record the seal after unloading"]'::jsonb,
    '["Sahkan nombor seal bersama penerima sebelum membuka seal", "Buka seal terlebih dahulu untuk mempercepatkan unloading", "Buka seal jika nombornya sepadan dengan rekod anda", "Minta kakitangan gudang merekodkan nombor seal selepas unloading"]'::jsonb,
    0,
    'Verify and document the seal before opening the load.',
    'Sahkan dan rekodkan seal sebelum membuka muatan.',
    ARRAY['MY'],
    'Container Haulage',
    ARRAY['Container Haulage'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);