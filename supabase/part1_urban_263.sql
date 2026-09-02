-- ==========================================================================
-- SafePass Questions Part 1 of 4: Setup & Urban Delivery / Box Van (263 MCQs)
-- ==========================================================================
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS driver_categories TEXT[];
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS reference_number INTEGER;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS explanation_ms TEXT;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS text_ms TEXT;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS options_ms JSONB;

-- Clear existing questions table
TRUNCATE TABLE public.questions CASCADE;

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1cfcec09-2d03-49d8-bd81-79111432687a',
    NULL,
    'After a collision, operations asks whether the vehicle can be moved.',
    'Selepas pelanggaran, bahagian operasi bertanya sama ada kenderaan boleh dialihkan.',
    '["Inform whether the vehicle can be moved or is blocking traffic.", "Move the vehicle without informing anyone.", "Leave it as it is and end the call.", "Decide later after completing documentation."]'::jsonb,
    '["Maklumkan sama ada kenderaan boleh dialihkan atau sedang menghalang trafik.", "Alihkan kenderaan tanpa memaklumkan kepada sesiapa.", "Biarkan sahaja dan tamatkan panggilan.", "Buat keputusan kemudian selepas melengkapkan dokumen."]'::jsonb,
    0,
    'Inform operations about vehicle condition and obstruction status.',
    'Maklumkan keadaan kenderaan dan sama ada ia menghalang trafik.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ff27240c-6712-4894-b323-1193b5c29a9b',
    NULL,
    'You drive in slow traffic. A driver cuts in and brakes sharply.',
    'Anda memandu dalam trafik perlahan. Seorang pemandu memotong masuk dan membrek secara mengejut.',
    '["Reduce speed smoothly and keep a safe pace", "Maintain speed to avoid being pushed back", "Slow briefly, then speed up to create space", "Adjust speed after traffic settles"]'::jsonb,
    '["Kurangkan kelajuan secara lancar dan kekalkan kelajuan selamat", "Kekalkan kelajuan untuk mengelak daripada didorong ke belakang.", "Perlahankan seketika kemudian tambah kelajuan untuk mewujudkan ruang di hadapan", "Sesuaikan kelajuan selepas trafik kembali stabil"]'::jsonb,
    0,
    'Calm speed control prevents impulsive reactions in frustrating traffic.',
    'Kawalan kelajuan yang tenang membantu mengelakkan tindak balas impulsif dalam trafik.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.25, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c77dfe10-d1c1-4944-b943-27a4f256bef3',
    NULL,
    'You need to reverse into a tight space in a site yard. Vehicles and equipment move nearby.',
    'Anda perlu mengundur ke ruang sempit di kawasan tapak. Kenderaan dan jentera bergerak berhampiran.',
    '["Stop and reverse only when space and visibility are clear", "Reverse slowly and adjust speed as conditions change", "Complete the manoeuvre to minimise disruption", "Follow nearby vehicles to guide your reversing speed"]'::jsonb,
    '["Berhenti dan undur hanya apabila ruang dan pandangan jelas", "Undur perlahan dan sesuaikan kelajuan mengikut keadaan", "Selesaikan manuver untuk kurangkan gangguan kepada orang lain", "Ikut pergerakan kenderaan berhampiran untuk panduan kelajuan mengundur"]'::jsonb,
    0,
    'Confirm space and visibility before reversing in busy yards.',
    'Pastikan ruang dan pandangan jelas sebelum mengundur di kawasan tapak sibuk.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '04bc0b67-3117-4928-8c1d-ee7e966e4389',
    NULL,
    'During unloading, site staff give instructions abruptly while you are positioning the vehicle.',
    'Semasa memunggah muatan, kakitangan tapak memberi arahan secara tiba-tiba ketika anda sedang memposisikan kenderaan.',
    '["Respond minimally and focus only on vehicle positioning", "Acknowledge the instructions and coordinate calmly", "Challenge the tone and clarify who is responsible", "Proceed without engaging further"]'::jsonb,
    '["Jawab secara minimum dan fokus pada posisi kenderaan sahaja", "Akui arahan tersebut dan bekerjasama dengan tenang", "Persoalkan nada arahan dan jelaskan siapa bertanggungjawab", "Teruskan tanpa melibatkan diri"]'::jsonb,
    1,
    'Calm coordination helps tasks run smoothly, even when instructions are delivered abruptly.',
    'Bekerjasama dengan tenang membantu kerja berjalan lancar walaupun arahan diberi secara tiba-tiba.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '96fc93b2-3b91-4f26-8a15-27fa2d864d8e',
    NULL,
    'During unloading, a disagreement with site staff begins to escalate over the unloading sequence.',
    'Semasa proses memunggah, berlaku perbezaan pendapat dengan kakitangan tapak mengenai turutan memunggah muatan dan keadaan mula menjadi tegang.',
    '["Pause unloading until someone else decides the unloading sequence.", "Explain calmly in detail why your unloading sequence is correct and safer.", "Continue unloading quietly to avoid making the situation worse", "Justify your approach so everyone understands your reasoning"]'::jsonb,
    '["Hentikan unloading sehingga orang lain menentukan urutan unloading.", "Terangkan dengan tenang secara terperinci mengapa urutan unloading anda adalah betul dan lebih selamat.", "Teruskan proses memunggah secara senyap untuk elak keadaan menjadi lebih tegang", "Pertahankan cara anda supaya semua faham sebabnya"]'::jsonb,
    1,
    'Calm and respectful communication helps resolve disagreements while maintaining safe unloading operations.',
    'Komunikasi yang tenang dan profesional membantu menyelesaikan perselisihan sambil mengekalkan operasi unloading yang selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '84e2cdc4-44b5-48dd-9932-59f72bc752f6',
    NULL,
    'Traffic ahead slows sharply. You increase following distance while vehicles behind close in without warning.',
    'Trafik di hadapan menjadi perlahan secara mendadak. Anda menambah jarak hadapan sementara kenderaan di belakang semakin menghampiri tanpa amaran.',
    '["Reduce speed gradually and maintain a safe following distance", "Maintain speed to avoid confusing drivers behind", "Close the gap to match traffic flow", "Brake later so others are forced to react"]'::jsonb,
    '["Lepaskan pedal minyak lebih awal dan perlahankan kenderaan secara beransur-ansur", "Kekalkan kelajuan supaya tidak mengelirukan pemandu di belakang", "Rapatkan jarak untuk mengikut aliran trafik", "Tekan brek secara mengejut supaya pemandu lain terpaksa bertindak balas"]'::jsonb,
    0,
    'Creating space early and signalling clearly helps others adjust safely to changing traffic conditions.',
    'Mewujudkan ruang lebih awal dan memberi isyarat dengan jelas membantu pemandu lain menyesuaikan diri dengan selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6672c88e-f775-49f8-a1cb-cf1a3ba05e57',
    NULL,
    'You are dressing for your driving shift.',
    'Anda sedang berpakaian untuk syif pemanduan.',
    '["Wear long trousers as required.", "Wear shorts if the weather is hot.", "Wear track pants for comfort.", "Wear any trousers only when visiting customer sites."]'::jsonb,
    '["Pakai seluar panjang seperti yang ditetapkan.", "Pakai seluar pendek jika cuaca panas.", "Pakai seluar trek untuk keselesaan.", "Pakai apa-apa seluar hanya apabila melawat tapak pelanggan."]'::jsonb,
    0,
    'Wear long trousers as part of required duty attire.',
    'Pakai seluar panjang seperti yang ditetapkan semasa bertugas.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3eabf2e8-008c-4a0e-91f5-bc3c783b006f',
    NULL,
    'During a delivery, a customer raises their voice and provokes you.',
    'Semasa membuat penghantaran, seorang pelanggan meninggikan suara dan memprovokasi anda.',
    '["Respond firmly to defend your position.", "Avoid confrontation and report to operations.", "Leave the site immediately without informing anyone.", "Continue arguing until the issue is resolved."]'::jsonb,
    '["Bertindak balas dengan tegas untuk mempertahankan diri.", "Elakkan pertelingkahan dan laporkan kepada bahagian operasi.", "Tinggalkan tapak serta-merta tanpa memaklumkan kepada sesiapa.", "Terus berdebat sehingga isu selesai."]'::jsonb,
    1,
    'Do not engage in confrontation; report the matter to operations.',
    'Elakkan pertelingkahan dan laporkan perkara tersebut kepada bahagian operasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f25fc51c-9c21-4b1c-b10c-a50240d5d6ff',
    NULL,
    'You position your vehicle in a loading area where forklifts and pedestrians are moving.',
    'Anda meletakkan kenderaan di kawasan pemunggahan di mana forklift dan pejalan kaki sedang bergerak.',
    '["Move forward quickly before equipment approaches", "Position only when the area is clear of movement", "Continue moving slowly and watch for operator signals", "Stop close to the loading area to reduce walking"]'::jsonb,
    '["Bergerak cepat ke hadapan sebelum peralatan menghampiri", "Letakkan kenderaan hanya apabila kawasan itu tiada pergerakan", "Terus bergerak perlahan sambil perhatikan isyarat pengendali", "Berhenti dekat kawasan pemunggahan untuk kurangkan berjalan"]'::jsonb,
    1,
    'Keep clear of active loading zones to reduce collision and injury risk.',
    'Kekalkan jarak dari kawasan pemunggahan aktif untuk mengurangkan risiko pelanggaran dan kecederaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fb8d648e-659e-4aa6-b3da-2bf43146f59d',
    NULL,
    'You drive inside a facility. Vehicles queue ahead and forklifts operate near the roadway.',
    'Anda memandu di dalam kawasan fasiliti. Kenderaan beratur di hadapan dan forklift beroperasi berhampiran laluan.',
    '["Increase following distance and keep clear sightlines", "Maintain spacing and close the gap if traffic slows", "Reduce the gap to avoid blocking vehicles behind", "Match the distance used by surrounding vehicles"]'::jsonb,
    '["Tambah jarak kenderaan dan kekalkan pandangan jelas", "Kekalkan jarak dan rapatkan jika trafik perlahan", "Rapatkan jarak untuk elakkan menghalang kenderaan di belakang", "Ikut jarak yang digunakan oleh kenderaan sekeliling"]'::jsonb,
    0,
    'Maintain extra spacing and clear sightlines near operating equipment.',
    'Kekalkan jarak tambahan dan pandangan jelas berhampiran jentera beroperasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c5e5154a-4688-4445-b2ac-654e927fadd6',
    NULL,
    'You plan to install a sun shade, dark tint film, or stickers on the company truck windscreen.',
    'Anda bercadang memasang pelindung matahari, filem gelap, atau pelekat pada cermin hadapan lori syarikat.',
    '["Install them if they do not block the main driving view.", "Do not install them without company approval.", "Use removable shades only during daytime driving.", "Check whether other drivers have done similar modifications."]'::jsonb,
    '["Pasang jika tidak menghalang pandangan utama ketika memandu.", "Jangan pasang tanpa kelulusan syarikat.", "Gunakan pelindung yang boleh ditanggalkan pada waktu siang sahaja.", "Periksa sama ada pemandu lain pernah membuat pengubahsuaian yang sama."]'::jsonb,
    1,
    'Avoid unauthorised vehicle modifications that may affect safety or compliance.',
    'Elakkan pengubahsuaian pada kenderaan tanpa kelulusan yang boleh menjejaskan keselamatan atau pematuhan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1e184dbf-1189-4e63-b477-93666ed1e173',
    NULL,
    'During inspection, you review emergency and fire equipment in the vehicle.',
    'Semasa pemeriksaan, anda menyemak peralatan kecemasan dan pemadam api di dalam kenderaan.',
    '["Check only for long-distance trips.", "Ensure emergency and fire equipment is complete and valid.", "Assume it is sufficient if previously used.", "Check after starting the trip."]'::jsonb,
    '["Periksa hanya untuk perjalanan jarak jauh.", "Pastikan peralatan kecemasan dan pemadam api lengkap dan masih sah untuk digunakan.", "Anggap mencukupi jika pernah digunakan sebelum ini.", "Periksa selepas memulakan perjalanan."]'::jsonb,
    1,
    'Ensure emergency and fire equipment is complete and valid before driving.',
    'Pastikan peralatan kecemasan dan pemadam api lengkap dan masih sah untuk digunakan sebelum memandu.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '55c941e4-b909-4f54-92fe-9413b733348f',
    NULL,
    'After a collision, you are gathering information from the other driver.',
    'Selepas pelanggaran, anda mengumpul maklumat daripada pemandu lain.',
    '["Take the driver\u2019s contact number and identification details.", "Record only the vehicle number.", "Ask them to contact your office directly.", "Leave once traffic clears."]'::jsonb,
    '["Ambil nombor telefon dan butiran pengenalan pemandu tersebut.", "Catat nombor pendaftaran kenderaan sahaja.", "Minta mereka hubungi pejabat anda secara terus.", "Beredar apabila trafik kembali lancar."]'::jsonb,
    0,
    'Obtain necessary contact and identification details.',
    'Dapatkan nombor telefon dan butiran pengenalan yang diperlukan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'abf29f1e-e80c-46dd-a9e0-5d183c99ccd7',
    NULL,
    'Your vehicle catches fire during transit.',
    'Kenderaan anda terbakar semasa dalam perjalanan.',
    '["Inform operations or the company safety team immediately.", "Attempt to control the fire fully before reporting.", "Inform the customer first.", "Report only if damage is severe."]'::jsonb,
    '["Maklumkan kepada bahagian operasi atau pasukan keselamatan syarikat dengan segera.", "Cuba kawal kebakaran sepenuhnya sebelum melaporkan.", "Maklumkan kepada pelanggan terlebih dahulu.", "Laporkan hanya jika kerosakan adalah serius."]'::jsonb,
    0,
    'Report fire incidents immediately.',
    'Laporkan kejadian kebakaran dengan segera.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'aa58a3e7-a336-4c9b-8f47-0ddb491fef00',
    NULL,
    'After a collision, operations asks for your location.',
    'Selepas pelanggaran, bahagian operasi meminta lokasi anda.',
    '["Provide the exact location using junctions or landmarks.", "Say you are \u201cnear the highway\u201d.", "Share the location after police arrival.", "Wait for GPS tracking to update automatically."]'::jsonb,
    '["Berikan lokasi tepat dengan menyatakan simpang atau mercu tanda.", "Berikan anggaran lokasi berdasarkan kawasan sekitar.", "Kongsi lokasi selepas polis tiba.", "Tunggu sistem GPS dikemas kini secara automatik."]'::jsonb,
    0,
    'Provide precise accident location details.',
    'Berikan butiran lokasi kemalangan dengan tepat dan jelas.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '931dea94-1e15-4b4c-a1b4-79506f1b1291',
    NULL,
    'You drive in steady multi-lane traffic. Motorcycles filter between lanes and traffic slows near an exit.',
    'Anda memandu dalam trafik berbilang lorong yang lancar. Motosikal bergerak di antara lorong dan trafik perlahan berhampiran susur keluar.',
    '["Maintain lane position and prepare for sudden movement", "Change lanes early to avoid slowing traffic", "Hold lane but move closer to the lane marking", "Continue normally and react only if traffic slows"]'::jsonb,
    '["Kekalkan kedudukan lorong dan bersedia untuk pergerakan mengejut", "Tukar lorong lebih awal untuk mengelakkan trafik perlahan", "Kekalkan lorong tetapi bergerak lebih dekat ke garisan lorong", "Teruskan seperti biasa dan bertindak hanya jika trafik perlahan"]'::jsonb,
    0,
    'Maintain stable lane position and anticipate sudden movement.',
    'Kekalkan kedudukan lorong yang stabil dan jangka pergerakan mengejut.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '72a9abea-94d3-4e6a-9a97-2519c52d88fa',
    NULL,
    'You approach a checkpoint inside a facility. Vehicles queue unevenly and lanes split toward inspection points.',
    'Anda menghampiri pusat pemeriksaan di dalam fasiliti. Kenderaan beratur tidak sekata dan lorong berpecah ke beberapa laluan pemeriksaan.',
    '["Remain in your lane and wait for checkpoint direction", "Shift early to a less congested lane", "Move forward and adjust position near the checkpoint", "Follow the vehicle ahead if its lane clears faster"]'::jsonb,
    '["Kekalkan lorong dan tunggu arahan pusat pemeriksaan", "Tukar awal ke lorong yang kurang sesak", "Bergerak ke hadapan dan sesuaikan kedudukan berhampiran pusat pemeriksaan", "Ikut kenderaan di hadapan jika lorongnya bergerak lebih cepat"]'::jsonb,
    0,
    'Remain orderly and wait for checkpoint direction in controlled zones.',
    'Kekalkan pergerakan teratur dan tunggu arahan pusat pemeriksaan di kawasan kawalan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'eee30e44-8a33-43b0-acef-269eb89d12f1',
    NULL,
    'A customer becomes verbally aggressive after being told the delivery cannot proceed as requested.',
    'Seorang pelanggan bercakap secara agresif selepas dimaklumkan bahawa penghantaran tidak dapat diteruskan seperti diminta.',
    '["Respond firmly to assert your position", "Stay calm, acknowledge concerns, and explain the situation clearly", "End the conversation and walk away", "Repeat company policy without further engagement"]'::jsonb,
    '["Jawab dengan tegas untuk pertahankan pendirian", "Kekal tenang, dengar perkara yang dibangkitkan dan terangkan keadaan dengan jelas", "Tamatkan perbualan dan beredar", "Ulang dasar syarikat tanpa perbincangan lanjut"]'::jsonb,
    1,
    'Staying calm and acknowledging concerns helps prevent escalation and keeps the situation under control.',
    'Kekal tenang dan beri penjelasan yang jelas membantu elakkan keadaan menjadi lebih tegang dan kekalkan kawalan situasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '51057ddf-bc72-45f8-bbe7-5aedba2d2c41',
    NULL,
    'During a delivery, a customer explains that a small personal gift is customary in their culture.',
    'Semasa penghantaran, seorang pelanggan menjelaskan bahawa pemberian kecil peribadi adalah amalan dalam budayanya.',
    '["Decline respectfully and continue with the delivery as planned", "Accept briefly to avoid appearing disrespectful", "Delay responding and see how others handle it", "Explain carefully why such gifts can cause problems"]'::jsonb,
    '["Tolak dengan hormat dan teruskan penghantaran seperti dirancang", "Terima seketika supaya tidak kelihatan tidak hormat", "Tangguhkan respons dan lihat bagaimana orang lain bertindak", "Terangkan dengan teliti mengapa pemberian itu boleh menimbulkan isu"]'::jsonb,
    0,
    'Respecting culture does not require accepting gifts that compromise integrity.',
    'Menghormati budaya tidak bermaksud menerima pemberian yang boleh menjejaskan integriti.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4fec2e9a-c046-41ba-8d3d-c278a4c8cc58',
    NULL,
    'You have completed 8 hours of driving for the day and one nearby delivery remains.',
    'Anda telah memandu selama 8 jam pada hari tersebut dan satu penghantaran berhampiran masih belum selesai.',
    '["Continue driving to complete the final delivery.", "Stop driving and report reaching the daily limit.", "Drive for another 30 minutes before stopping.", "Reduce speed and complete the delivery carefully."]'::jsonb,
    '["Terus memandu untuk menyelesaikan penghantaran terakhir.", "Hentikan pemanduan dan laporkan bahawa had harian telah dicapai.", "Memandu lagi selama 30 minit sebelum berhenti.", "Kurangkan kelajuan dan selesaikan penghantaran dengan berhati-hati."]'::jsonb,
    1,
    'Follow driving hour limits to maintain safety and compliance.',
    'Patuhi had waktu pemanduan untuk menjaga keselamatan dan pematuhan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c3e9713f-2b38-4962-844b-e9e00ea13923',
    NULL,
    'You check the vehicle and the warning triangle is missing.',
    'Anda memeriksa kenderaan dan mendapati segi tiga amaran tiada.',
    '["Continue driving if hazard lights are working.", "Replace the safety triangle before departure.", "Borrow one only when needed.", "Use cones instead of a triangle."]'::jsonb,
    '["Terus memandu jika lampu kecemasan berfungsi.", "Gantikan segi tiga amaran sebelum memulakan perjalanan.", "Pinjam satu hanya apabila diperlukan.", "Gunakan kon sebagai ganti segi tiga amaran."]'::jsonb,
    1,
    'Carry the required warning triangle before operating.',
    'Bawa segi tiga amaran yang diperlukan sebelum mengendalikan kenderaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a51024e9-d86b-47e8-8ebb-f095ed709da2',
    NULL,
    'After a delivery, you notice the recorded details do not fully match what occurred.',
    'Selepas penghantaran, anda mendapati butiran yang direkod tidak sepenuhnya sepadan dengan apa yang berlaku.',
    '["Clarify the discrepancy and update the records accurately", "Leave the records unchanged to avoid reopening the discussion", "Add brief notes later so the paperwork roughly reflects events", "Ask someone else to adjust the documents if needed"]'::jsonb,
    '["Jelaskan perbezaan dan kemas kini rekod dengan tepat", "Biarkan rekod seperti itu untuk elakkan perbincangan dibuka semula", "Tambah catatan ringkas kemudian supaya dokumen lebih kurang mencerminkan keadaan sebenar", "Minta orang lain mengubah dokumen jika perlu"]'::jsonb,
    0,
    'Correct records promptly to ensure accuracy and prevent misunderstandings.',
    'Betulkan rekod dengan segera untuk memastikan ketepatan dan mengelakkan salah faham.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b90f64f3-02fd-4a94-be22-704cc3849dc3',
    NULL,
    'In a public area, a bystander becomes upset about where your vehicle is stopped.',
    'Di kawasan awam, seorang individu berasa tidak puas hati tentang lokasi kenderaan anda berhenti.',
    '["Stay quiet and wait for the bystander to calm down", "Explain calmly in detail why the stop is necessary and allowed", "Avoid engagement and continue the task to prevent escalation", "Justify your position firmly so the complaint does not continue"]'::jsonb,
    '["Berdiam diri dan tunggu sehingga orang itu bertenang", "Terangkan dengan terperinci mengapa berhenti di situ perlu dan dibenarkan", "Elakkan berinteraksi dan teruskan tugas", "Pertahankan posisi anda dengan tegas supaya aduan tidak berlanjutan"]'::jsonb,
    1,
    'Calm acknowledgement helps ease public tension and prevents situations from escalating.',
    'Respons yang tenang dan jelas membantu redakan ketegangan dan elakkan keadaan menjadi lebih serius.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'cea0a154-85f5-46e8-b6e6-ee6ef6c0586d',
    NULL,
    'Your goods vehicle is experiencing failure at night and you need to step out.',
    'Kenderaan barangan anda mengalami kerosakan pada waktu malam dan anda perlu keluar dari kenderaan.',
    '["Exit quickly to place warning devices.", "Wear a safety vest before exiting.", "Stand beside the vehicle and observe traffic.", "Use your phone light while walking behind the vehicle."]'::jsonb,
    '["Keluar dengan segera untuk meletakkan alat amaran.", "Pakai jaket keselamatan sebelum keluar.", "Berdiri di sebelah kenderaan dan perhatikan trafik.", "Gunakan lampu telefon bimbit semasa berjalan di belakang kenderaan."]'::jsonb,
    1,
    'Ensure personal visibility before exiting to reduce roadside risk.',
    'Pastikan anda mudah dilihat sebelum keluar bagi mengurangkan risiko di tepi jalan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'deda1810-3d24-4acf-98d7-7100be05ab11',
    NULL,
    'You drive inside an industrial site where equipment operates near the roadway.',
    'Anda memandu di dalam kawasan industri di mana jentera beroperasi berhampiran laluan.',
    '["Reduce speed early and keep extra clearance from equipment", "Maintain pace and adjust if equipment enters your path", "Continue slowly to pass before equipment repositions", "Follow the vehicle ahead past the equipment"]'::jsonb,
    '["Kurangkan kelajuan lebih awal dan kekalkan jarak daripada jentera", "Kekalkan kelajuan dan sesuaikan jika jentera memasuki laluan anda", "Terus bergerak perlahan untuk melepasi sebelum jentera beralih", "Ikut kenderaan di hadapan melepasi jentera"]'::jsonb,
    0,
    'Reduce speed early and keep clear of operating equipment.',
    'Kurangkan kelajuan lebih awal dan kekalkan jarak dari jentera beroperasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1cd4a762-7675-4ece-8a75-3d8f3978aa55',
    NULL,
    'During loading, you notice most of the cargo has been placed behind the rear axle.',
    'Semasa kargo sedang dimuatkan, anda mendapati kebanyakan muatan diletakkan di belakang gandar belakang.',
    '["Redistribute the load before the vehicle departs.", "Secure the cargo with additional straps before departure.", "Continue if the total vehicle weight is within the limit.", "Drive more slowly to reduce stress on the rear axle."]'::jsonb,
    '["Agihkan semula muatan sebelum kenderaan bergerak.", "Ikat muatan dengan tali tambahan sebelum bergerak.", "Teruskan jika jumlah berat kenderaan masih dalam had yang dibenarkan.", "Pandu dengan lebih perlahan untuk mengurangkan beban pada gandar belakang."]'::jsonb,
    0,
    'Distribute the load correctly to prevent excessive axle loading and maintain safe vehicle handling.',
    'Agihkan muatan dengan betul bagi mengelakkan beban berlebihan pada gandar dan memastikan kestabilan serta kawalan kenderaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '75f67305-4b66-448d-bec1-df45b01854a2',
    NULL,
    'Before leaving the vehicle to make a delivery, you realise one cab window has been left slightly open.',
    'Sebelum meninggalkan kenderaan untuk membuat penghantaran, anda mendapati salah satu tingkap kabin masih terbuka sedikit.',
    '["Close all windows before leaving the vehicle.", "Leave a small gap for ventilation during the delivery.", "Lock the doors and leave the window slightly open.", "Close the window only if valuables are left inside."]'::jsonb,
    '["Tutup semua tingkap sebelum meninggalkan kenderaan.", "Biarkan tingkap terbuka sedikit untuk pengudaraan semasa membuat penghantaran.", "Kunci pintu dan biarkan tingkap terbuka sedikit.", "Tutup tingkap hanya jika terdapat barang berharga di dalam kenderaan."]'::jsonb,
    0,
    'Secure the vehicle completely before leaving it unattended to reduce the risk of theft.',
    'Pastikan kenderaan ditutup dan dikunci sepenuhnya sebelum ditinggalkan tanpa pengawasan bagi mengurangkan risiko kecurian.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a9e88571-f15d-4a3b-a894-f8e58a37c522',
    NULL,
    'After collecting a COD payment, you realise the cash has been placed together with your vehicle keys.',
    'Selepas menerima bayaran COD, anda mendapati wang tunai tersebut diletakkan bersama kunci kenderaan.',
    '["Separate the cash and vehicle keys immediately.", "Keep them together until the next delivery.", "Move both into a different bag before continuing.", "Keep them together if the remaining deliveries are nearby."]'::jsonb,
    '["Asingkan wang tunai dan kunci kenderaan dengan segera.", "Biarkan kedua-duanya bersama sehingga penghantaran seterusnya.", "Pindahkan kedua-duanya ke dalam beg yang lain sebelum meneruskan perjalanan.", "Biarkan kedua-duanya bersama jika baki lokasi penghantaran berdekatan."]'::jsonb,
    0,
    'Separating cash from vehicle keys helps protect both the driver and company assets if an incident occurs.',
    'Mengasingkan wang tunai daripada kunci kenderaan membantu melindungi pemandu serta aset syarikat sekiranya berlaku sesuatu kejadian.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '80b74817-8c6d-40ed-b55e-be0f92ae2eb5',
    NULL,
    'You are assigned to deliver a heavy item that cannot be handled safely by one person.',
    'Anda ditugaskan menghantar satu barang yang berat dan tidak boleh dikendalikan dengan selamat oleh seorang sahaja.',
    '["Use additional assistance or divide the task into safe stages.", "Carry the item alone to avoid delaying the delivery.", "Move the item quickly before fatigue sets in.", "Drag the item carefully to reduce lifting effort."]'::jsonb,
    '["Dapatkan bantuan tambahan atau bahagikan kerja kepada beberapa peringkat yang selamat.", "Angkat barang tersebut seorang diri supaya penghantaran tidak lewat.", "Alihkan barang dengan cepat sebelum berasa letih.", "Seret barang tersebut dengan berhati-hati untuk mengurangkan usaha mengangkat."]'::jsonb,
    0,
    'Choose a safe handling method whenever an item cannot be moved safely by one person.',
    'Pilih kaedah pengendalian yang selamat apabila sesuatu barang tidak boleh dialihkan dengan selamat oleh seorang sahaja.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '20608ba6-c17d-459d-aa63-ce6cf34685b3',
    NULL,
    'While reversing, you hear the reverse warning beep becoming noticeably faster.',
    'Semasa mengundur, anda mendengar bunyi amaran mengundur berbunyi semakin pantas.',
    '["Stop and check the clearance before continuing.", "Continue reversing slowly until the beep becomes continuous.", "Depend on the reversing camera to confirm the remaining space.", "Reverse more slowly because the warning beep is already active."]'::jsonb,
    '["Berhenti dan pastikan ruang kelegaan mencukupi sebelum meneruskan.", "Terus mengundur perlahan sehingga bunyi amaran berbunyi berterusan.", "Bergantung pada kamera undur untuk mengesahkan baki ruang.", "Undur dengan lebih perlahan kerana bunyi amaran sudah berbunyi."]'::jsonb,
    0,
    'Treat changes in warning signals as an indication to stop and confirm there is sufficient clearance before continuing.',
    'Anggap perubahan bunyi amaran sebagai isyarat untuk berhenti dan memastikan ruang kelegaan mencukupi sebelum meneruskan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '746ebdb5-2fb0-46dd-98e7-fdf81fe74f65',
    NULL,
    'You are completing a proof of delivery (POD) after leaving a parcel at an apartment unit.',
    'Anda sedang melengkapkan bukti penghantaran (POD) selepas meninggalkan bungkusan di sebuah unit apartmen.',
    '["Ensure the unit number is clearly visible in the POD.", "Ensure the parcel is clearly visible in the POD photo.", "Record the unit number only if requested by the customer.", "Complete the POD after returning to the depot."]'::jsonb,
    '["Pastikan nombor unit dapat dilihat dengan jelas dalam POD.", "Pastikan bungkusan kelihatan jelas dalam gambar POD.", "Catat nombor unit hanya jika diminta oleh pelanggan.", "Lengkapkan POD selepas kembali ke depot."]'::jsonb,
    0,
    'A complete POD with clear location details helps verify the delivery and reduces unnecessary follow-up enquiries.',
    'POD yang lengkap dengan butiran lokasi yang jelas membantu mengesahkan penghantaran dan mengurangkan pertanyaan susulan yang tidak perlu.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '25bc63c7-55b7-4f0d-8030-501e4c29ae36',
    NULL,
    'Before leaving the loading point, the delivery order states the quantity of goods loaded.',
    'Sebelum meninggalkan tempat loading, Delivery Order menyatakan kuantiti barang yang telah dimuatkan.',
    '["Verify the quantity of goods against the delivery documents before departure", "Assume the quantity is correct because the warehouse prepared the load", "Check only the main loading units without verifying the total quantity of goods", "Leave once the goods have been loaded without verifying the quantity"]'::jsonb,
    '["Semak kuantiti barang dengan dokumen penghantaran sebelum bertolak", "Anggap kuantiti adalah betul kerana pihak gudang telah menyediakan muatan", "Semak hanya unit utama muatan tanpa mengesahkan jumlah keseluruhan barang", "Terus bertolak sebaik sahaja barang selesai dimuatkan tanpa mengesahkan kuantiti"]'::jsonb,
    0,
    'Always verify the physical quantity of goods against the delivery documents before accepting responsibility for the load.',
    'Sentiasa semak kuantiti fizikal barang dengan dokumen penghantaran sebelum menerima tanggungjawab ke atas muatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd3d00e83-fea1-4a3b-9f01-ec823acf86b3',
    NULL,
    'While loading, you notice several cartons marked "DO NOT STACK."',
    'Semasa loading, anda mendapati beberapa karton berlabel "DO NOT STACK."',
    '["Keep those cartons free from additional loads", "Stack only one lightweight carton above them", "Place them on top of stronger cartons for stability", "Double stack them if space is limited"]'::jsonb,
    '["Pastikan tiada barang diletakkan di atas karton tersebut", "Susun satu karton ringan sahaja di atasnya", "Letakkan di atas karton yang lebih kukuh untuk kestabilan", "Susun dua lapis jika ruang terhad"]'::jsonb,
    0,
    'Always follow the stacking instructions printed on the packaging to prevent cargo damage.',
    'Sentiasa ikut arahan susunan yang tertera pada pembungkusan bagi mengelakkan kerosakan muatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    1,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '28a47eb9-b1f4-4fb7-a2db-9a815f6b4bf1',
    NULL,
    'Your driving document will expire in three weeks.',
    'Dokumen pemanduan anda akan tamat tempoh dalam tiga minggu.',
    '["Renew it two weeks before expiry.", "Renew it on your next off day.", "Renew it when you have free time.", "Renew it during the expiry week."]'::jsonb,
    '["Perbaharui dua minggu sebelum tamat tempoh.", "Perbaharui pada hari cuti anda yang seterusnya.", "Perbaharui apabila ada masa lapang.", "Perbaharui pada minggu tamat tempoh."]'::jsonb,
    0,
    'Renew required documents at least two weeks before expiry.',
    'Perbaharui dokumen yang diperlukan sekurang-kurangnya dua minggu sebelum tamat tempoh.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9c322abd-faf6-4884-99e2-f7896b240de8',
    NULL,
    'You position your vehicle in a loading area where forklifts are operating.',
    'Anda meletakkan kenderaan di Kawasan memuat/memunggah barang di mana forklift sedang beroperasi.',
    '["Move forward quickly and stop near loading", "Stop at a safe distance and proceed when clear", "Continue moving and rely on forklift guidance", "Park as close as possible despite limited space"]'::jsonb,
    '["Bergerak cepat ke hadapan dan berhenti berhampiran kawasan memuat/memunggah barang", "Berhenti pada jarak selamat dan bergerak apabila laluan sudah jelas", "Terus bergerak dan bergantung pada panduan forklift", "Parkir sedekat mungkin walaupun ruang terhad"]'::jsonb,
    1,
    'Keep a safe distance from active loading zones to reduce collision risk.',
    'Kekalkan jarak selamat dari kawasan kawasan pemuatan aktif untuk mengurangkan risiko pelanggaran.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '91ceb0be-75fb-4b57-8aa5-ad8e6b7fbf36',
    NULL,
    'After a pre-trip inspection, you feel an unusual vibration while driving.',
    'Selepas pemeriksaan sebelum perjalanan, anda merasakan getaran tidak biasa semasa memandu.',
    '["Stop and recheck the vehicle before continuing", "Continue driving since the inspection showed no problems", "Complete the trip and report it at the end of the shift", "Ignore it unless a warning indicator appears"]'::jsonb,
    '["Berhenti dan periksa semula kenderaan", "Terus memandu kerana pemeriksaan awalan dizbuat", "Selesaikan perjalanan dan laporkan pada akhir syif", "Abaikan kecuali lampu amaran muncul"]'::jsonb,
    0,
    'Unusual vehicle behaviour requires immediate checking.',
    'Perubahan mekanikal kenderaan perlu diperiksa segera.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '417d44a8-0763-4e14-a851-e5b7fd37a8cb',
    NULL,
    'While driving, the engine feels strained during acceleration though no warning lights appear.',
    'Semasa memandu, enjin terasa kurang responsive semasa memecut walaupun tiada lampu amaran menyala.',
    '["Ease acceleration and monitor the condition", "Maintain normal acceleration since no lights show", "Increase engine output to test the response", "Continue driving and act only if it worsens"]'::jsonb,
    '["Kurangkan pecutan dan pantau keadaan", "Kekalkan pecutan kerana tiada lampu amaran", "Tingkatkan kuasa enjin untuk menguji tindak balas", "Terus memandu dan bertindak hanya jika keadaan bertambah teruk"]'::jsonb,
    0,
    'Respond early to unusual vehicle performance.',
    'Bertindak awal apabila prestasi kenderaan tidak biasa.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '383bd7b4-061b-4b3f-bb49-c4a89ee94865',
    NULL,
    'You notice a large piece of debris on the road ahead while vehicles behind are approaching quickly.',
    'Anda terlihat serpihan besar di jalan di hadapan ketika kenderaan di belakang menghampiri dengan laju.',
    '["Ease off smoothly and press brakes smoothly to warn others", "Maintain speed to avoid confusing traffic behind", "Brake later so following vehicles react together", "Slow suddenly once the debris is closer"]'::jsonb,
    '["Perlahankan kenderaan  secara beransur supaya lampu brek memberi amaran kepada kenderaan belakang", "Kekalkan kelajuan supaya tidak mengelirukan trafik di belakang", "Brek kemudian supaya kenderaan belakang bertindak serentak", "Perlahankan kenderaan secara mengejut apabila objek semakin hampir"]'::jsonb,
    0,
    'Early slowing with clear signals helps other drivers adjust safely to hazards ahead.',
    'Memperlahankan kenderaan lebih awal membantu memberi amaran awal kepada pemandu lain dan membolehkan mereka menyesuaikan diri dengan selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.25, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c15ddc08-2a3a-4057-a054-c480a374e96b',
    NULL,
    'Your goods vehicle is experiencing failure on a highway and you are placing safety cones behind it.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda sedang meletakkan kon keselamatan di belakangnya.',
    '["Place cones a few metres behind the vehicle to alert nearby traffic.", "Position cones to the rear, spaced about 10 metres apart.", "Place one cone directly behind the vehicle as a marker.", "Set the cones beside the vehicle to save time."]'::jsonb,
    '["Letakkan kon beberapa meter di belakang kenderaan untuk memberi amaran kepada trafik berhampiran.", "Letakkan kon di bahagian belakang dengan jarak kira-kira 10 meter antara satu sama lain.", "Letakkan satu kon tepat di belakang kenderaan sebagai penanda.", "Letakkan kon di sisi kenderaan untuk menjimatkan masa."]'::jsonb,
    1,
    'Position warning devices correctly to provide clear rear hazard warning.',
    'Letakkan alat amaran dengan jarak yang sesuai untuk memberi amaran yang jelas kepada trafik dari belakang.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3baf3fb1-1357-481d-a23f-a1a8e49857c8',
    NULL,
    'You approach a busy site exit joining a public road. Space is tight and reversing may be needed to realign.',
    'Anda menghampiri pintu keluar tapak yang bersambung dengan jalan awam. Ruang sempit dan mungkin perlu mengundur untuk melaras kedudukan.',
    '["Edge forward to secure position and adjust if needed", "Stop, assess, and reverse slowly under control", "Use the horn and continue moving", "Reverse quickly before vehicles arrive"]'::jsonb,
    '["Bergerak sedikit ke hadapan untuk mendapatkan kedudukan", "Berhenti, nilai keadaan, dan undur perlahan dengan kawalan", "Gunakan hon dan terus bergerak", "Undur dengan cepat sebelum kenderaan tiba"]'::jsonb,
    1,
    'Stop and maintain full control before reversing near junctions.',
    'Berhenti dan kekalkan kawalan penuh sebelum mengundur berhampiran persimpangan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '272ce455-a6f4-4fa7-ac7e-cd7671868311',
    NULL,
    'During unloading, a tense exchange with site staff starts attracting attention from people nearby.',
    'Semasa proses memunggah, perbualan tegang dengan kakitangan tapak mula menarik perhatian orang di sekeliling.',
    '["Keep your tone calm and behaviour professional", "Raise your voice to make sure everyone understands your position", "Continue the task while limiting further interaction", "Justify your response to avoid appearing at fault"]'::jsonb,
    '["Kekalkan nada tenang dan tingkah laku profesional", "Tinggikan suara supaya semua orang memahami pendirian anda", "Teruskan tugas sambil hadkan interaksi lanjut", "Jelaskan respons anda untuk elak kelihatan bersalah"]'::jsonb,
    0,
    'Maintaining calm, professional behaviour protects your image when situations draw public attention.',
    'Kekalkan sikap tenang dan profesional apabila situasi menarik perhatian orang ramai.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f9838b57-c18e-412d-bc1a-e9c8ecb83e49',
    NULL,
    'While driving, a member of the public provokes you aggressively.',
    'Semasa memandu, seorang orang awam bertindak agresif dan memprovokasi anda.',
    '["React quickly to assert your position.", "Remain calm and report the incident.", "Stop and confront the person.", "Follow the person to clarify the issue."]'::jsonb,
    '["Bertindak segera untuk mempertahankan pendirian anda.", "Kekal tenang dan laporkan kejadian tersebut.", "Berhenti dan bersemuka dengan individu tersebut.", "Ikut individu tersebut untuk menjelaskan keadaan."]'::jsonb,
    1,
    'Avoid impulsive actions and report the incident appropriately.',
    'Kekal tenang dan laporkan kejadian dengan cara yang sesuai.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'fba7e557-dd08-49ee-9d03-768a47fbeddc',
    NULL,
    'You intend to change lanes, but another driver in your blind spot appears unsure of your intention',
    'Anda bercadang untuk menukar lorong, namun pemandu di titik buta kelihatan tidak pasti tentang niat anda.',
    '["Signal early and wait until the other driver responds before moving", "Drift slightly to indicate intention and move when space appears", "Check mirrors again and change lanes once traffic slows", "Hold position and change lanes later without signalling"]'::jsonb,
    '["Beri isyarat awal dan tunggu sehingga diberi ruang", "Hanyut sedikit ke sisi untuk menunjukkan niat dan masuk apabila ada ruang", "Periksa cermin sekali lagi dan tukar lorong apabila trafik menjadi perlahan", "Kekalkan kedudukan dan tukar lorong kemudian tanpa memberi isyarat"]'::jsonb,
    0,
    'Clear signalling helps other drivers understand your intention and reduces uncertainty during lane changes.',
    'Isyarat yang jelas membantu pemandu lain memahami niat anda dan mengurangkan ketidakpastian semasa menukar lorong.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '90c36724-21a0-4d6c-92c0-152c60902583',
    NULL,
    'You are about to start driving the vehicle.',
    'Anda hendak memulakan pemanduan kenderaan.',
    '["Fasten the seat belt before moving.", "Drive first and fasten it later.", "Wear it only on highways.", "Use it only when carrying heavy cargo."]'::jsonb,
    '["Pakai tali pinggang keledar sebelum bergerak.", "Mula memandu dan pakai kemudian.", "Pakai hanya di lebuh raya.", "Pakai hanya apabila membawa muatan berat."]'::jsonb,
    0,
    'Always wear the seat belt before driving.',
    'Pakai tali pinggang keledar sebelum memandu.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a695c5a3-041a-4eea-8d4b-caf6323f185c',
    NULL,
    'Following a collision, what photographic evidence should you collect?',
    'Selepas pelanggaran, bukti gambar apakah yang perlu anda ambil?',
    '["Photos of the scene and vehicles involved.", "Only your own vehicle damage.", "A photo after vehicles are moved.", "No photos if witnesses are present."]'::jsonb,
    '["Gambar lokasi kejadian dan kenderaan yang terlibat.", "Gambar kerosakan kenderaan anda sahaja.", "Gambar selepas kenderaan dialihkan.", "Tidak perlu ambil gambar jika ada saksi."]'::jsonb,
    0,
    'Take clear photos of the accident scene and vehicles.',
    'Ambil gambar yang jelas bagi lokasi kejadian dan kenderaan yang terlibat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '84ad8350-40c6-4183-89c4-905208628d8e',
    NULL,
    'You drive inside a depot with marked lanes. Equipment operates nearby and stacked loads restrict visibility.',
    'Anda memandu di dalam depot dengan lorong bertanda. Jentera beroperasi berhampiran dan susunan muatan menghadkan pandangan.',
    '["Keep to the marked lane and slow until movement is clear", "Adjust position to see past the equipment", "Continue moving so you do not block equipment behind", "Proceed as usual and rely on operators"]'::jsonb,
    '["Kekalkan lorong bertanda dan perlahankan sehingga pergerakan jelas", "Sesuaikan kedudukan untuk melihat melepasi jentera", "Terus bergerak supaya tidak menghalang jentera di belakang", "Teruskan seperti biasa dan bergantung pada pengendali jentera"]'::jsonb,
    0,
    'Keep lane discipline and reduce speed near operating equipment.',
    'Amalkan disiplin lorong dan kurangkan kelajuan berhampiran peralatan beroperasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5057f244-cd47-4ad8-9d46-40d65eb48512',
    NULL,
    'Your vehicle is carrying chemical cargo and is involved in an accident.',
    'Kenderaan anda membawa muatan bahan kimia dan terlibat dalam kemalangan.',
    '["Inform operations of the cargo type and any hazard risk.", "Report the vehicle damage.", "Wait for emergency responders to identify the cargo.", "Mention cargo details when asked."]'::jsonb,
    '["Maklumkan kepada bahagian operasi jenis muatan dan sebarang risiko bahaya.", "Laporkan kerosakan kenderaan.", "Tunggu pasukan kecemasan mengenal pasti jenis muatan.", "Nyatakan butiran muatan bila ditanya."]'::jsonb,
    0,
    'Communicate cargo hazards immediately during an accident.',
    'Maklumkan risiko bahaya muatan dengan segera semasa kemalangan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3a6da48d-5bec-4334-a133-5724d7c78d23',
    NULL,
    'You drive at night in heavy rain on a downhill road. Visibility is reduced and vehicles ahead slow unpredictably.',
    'Anda memandu pada waktu malam dalam hujan lebat di jalan menurun. Pandangan terhad dan kenderaan di hadapan memperlahan secara tidak menentu.',
    '["Reduce speed early for higher risk conditions", "Maintain speed and rely on headlights and braking", "Slow slightly and adjust if visibility worsens", "Keep pace with the vehicle ahead"]'::jsonb,
    '["Kurangkan kelajuan lebih awal kerana keadaan berisiko tinggi", "Kekalkan kelajuan dan bergantung pada lampu serta brek", "Perlahankan sedikit dan sesuaikan kelajuan jika pandangan semakin terhad", "Ikut kelajuan kenderaan di hadapan"]'::jsonb,
    0,
    'Reduce speed in poor visibility to maintain time and control.',
    'Kurangkan kelajuan apabila pandangan terhad untuk kekalkan masa dan kawalan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4ac2b2fa-800f-446a-98f3-c266e9854e63',
    NULL,
    'You are in an active loading area during heavy rain. Surfaces are wet and equipment operates nearby.',
    'Anda berada di kawasan pemuatan aktif semasa hujan lebat. Permukaan basah dan jentera beroperasi berhampiran.',
    '["Stay clear of the loading area until conditions stabilise", "Proceed carefully while adjusting pace for the weather", "Move closer to monitor equipment movement", "Continue approaching so loading can proceed"]'::jsonb,
    '["Kekal jauh dari kawasan pemuatan sehingga keadaan stabil", "Teruskan dengan berhati-hati sambil laraskan kelajuan", "Bergerak lebih dekat untuk memantau pergerakan jentera", "Terus menghampiri supaya proses pemuatan boleh diteruskan"]'::jsonb,
    0,
    'Keep clear of loading activity when weather increases risk.',
    'Kekalkan jarak dari aktiviti pemuatan apabila keadaan cuaca meningkatkan risiko.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'cef8473c-bd27-4b7d-b764-76c2e195eb3d',
    NULL,
    'A customer questions a delivery delay and speaks to you in a frustrated tone.',
    'Seorang pelanggan mempersoalkan kelewatan penghantaran dan bercakap dengan nada tidak puas hati.',
    '["Respond briefly and focus on completing the delivery", "Explain the situation calmly and confirm the next steps", "Defend your actions and point out factors beyond your control", "Avoid discussion and request the customer to contact the office"]'::jsonb,
    '["Jawab secara ringkas dan fokus selesaikan penghantaran", "Terangkan keadaan dengan tenang dan sahkan langkah seterusnya", "Pertahankan tindakan anda dan jelaskan faktor di luar kawalan", "Elakkan perbincangan dan minta pelanggan berhubung dengan pejabat"]'::jsonb,
    1,
    'Calm, clear explanation helps reduce frustration and keeps the interaction professional.',
    'Penjelasan yang tenang dan jelas membantu kurangkan ketegangan dan kekalkan profesionalisme.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '97b17e56-9bbe-4404-ad47-32ed190a6e01',
    NULL,
    'During a delivery, a customer begins recording your interaction on a mobile phone.',
    'Semasa penghantaran, seorang pelanggan mula merakam interaksi anda menggunakan telefon bimbit.',
    '["Continue the discussion calmly and professionally", "Ask the customer to stop recording before continuing", "Keep responses brief and focus on completing the task", "Proceed with the delivery without acknowledging the recording"]'::jsonb,
    '["Teruskan perbincangan dengan tenang dan profesional", "Minta pelanggan berhenti merakam sebelum meneruskan", "Jawab secara ringkas dan fokus untuk selesaikan tugas", "Teruskan penghantaran tanpa mengendahkan rakaman"]'::jsonb,
    0,
    'Maintaining professional behaviour protects your image when interactions are visible or recorded.',
    'Kekalkan tingkah laku profesional apabila interaksi dirakam atau dilihat orang lain.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e78f1678-0b2b-458b-8196-7ea3f17896f0',
    NULL,
    'You have been on duty for 10 hours and are asked to continue working.',
    'Anda telah bertugas selama 10 jam dan diminta untuk terus bekerja.',
    '["Continue if the remaining task is short.", "Stop working after reaching the 10-hour limit.", "Work another hour and rest later.", "Continue if traffic conditions are light."]'::jsonb,
    '["Teruskan jika baki tugasan adalah singkat.", "Hentikan bekerja selepas mencapai had 10 jam.", "Bekerja satu jam lagi dan berehat kemudian.", "Teruskan jika keadaan trafik tidak sibuk."]'::jsonb,
    1,
    'Adhere to the maximum daily working hour limit.',
    'Patuhi had maksimum waktu kerja harian.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '91db0980-7984-496b-a4c7-44be2e279624',
    NULL,
    'During a routine pre-trip inspection, what should you check?',
    'Semasa pemeriksaan pra-perjalanan rutin, apakah yang perlu anda periksa?',
    '["Skip the check if the engine started normally.", "Verify the engine system as part of the safety inspection.", "Check only when warning lights appear.", "Inspect the engine only during scheduled servicing."]'::jsonb,
    '["Abaikan pemeriksaan jika enjin dapat dihidupkan seperti biasa.", "Sahkan sistem enjin sebagai sebahagian daripada pemeriksaan keselamatan.", "Periksa hanya apabila lampu amaran menyala.", "Periksa enjin hanya semasa servis berjadual."]'::jsonb,
    1,
    'Include engine system checks in daily safety inspections.',
    'Periksa sistem enjin setiap hari sebagai sebahagian daripada pemeriksaan keselamatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '955b811c-5790-4275-8dae-73b582625297',
    NULL,
    'You move from an internal roadway toward a loading area. Obstructions and movement change around you.',
    'Anda bergerak dari laluan dalaman menuju kawasan pemunggahan. Halangan dan pergerakan berubah di sekeliling.',
    '["Slow early and adjust your path to surrounding movement", "Maintain pace and react when a hazard appears", "Focus on the path ahead and reassess inside", "Follow vehicles ahead that pass smoothly"]'::jsonb,
    '["Perlahankan kenderaan lebih awal dan sesuaikan laluan mengikut pergerakan sekitar", "Kekalkan kelajuan dan bertindak apabila bahaya muncul", "Fokus pada laluan di hadapan dan nilai semula selepas masuk", "Ikut kenderaan di hadapan yang melalui kawasan dengan lancar"]'::jsonb,
    0,
    'Anticipate early and adjust space to avoid sudden reactions.',
    'Jangka lebih awal dan sesuaikan ruang untuk elakkan tindak balas mengejut.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '30e8f970-be11-4d60-8701-5e097fb138c8',
    NULL,
    'During a roadside inspection, an officer approaches and you realise you are not wearing a safety vest.',
    'Semasa pemeriksaan di tepi jalan, seorang pegawai menghampiri dan anda sedar anda tidak memakai vest keselamatan.',
    '["Put on the safety vest and cooperate with the inspection", "Continue the inspection and wear it if instructed", "Answer the officer\u2019s questions and address it later", "Remain where you are until the inspection ends"]'::jsonb,
    '["Pakai vest keselamatan dan beri kerjasama semasa pemeriksaan", "Teruskan pemeriksaan dan pakai jika diarahkan", "Jawab soalan pegawai dan uruskan kemudian", "Kekal di tempat anda sehingga pemeriksaan selesai"]'::jsonb,
    0,
    'Wear required safety equipment during inspections.',
    'Pakai peralatan keselamatan yang diperlukan semasa pemeriksaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8b4c7c70-1ea4-4ce9-b95f-22c8c1b5c679',
    NULL,
    'In a public area, people nearby are watching and filming while you interact with others.',
    'Di kawasan awam, orang di sekeliling memerhati dan merakam semasa anda berinteraksi dengan orang lain.',
    '["Keep your behaviour calm and professional throughout", "Explain your actions clearly so observers understand your position", "Limit interaction and focus on finishing the task", "Respond firmly to avoid appearing uncertain"]'::jsonb,
    '["Kekalkan tingkah laku tenang dan profesional sepanjang masa", "Terangkan tindakan anda supaya orang yang memerhati faham", "Hadkan interaksi dan fokus selesaikan tugas", "Beri respons dengan tegas supaya tidak kelihatan ragu-ragu"]'::jsonb,
    0,
    'Professional behaviour matters most when actions are visible to the public.',
    'Tingkah laku profesional amat penting apabila tindakan anda dapat dilihat oleh orang awam.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '92906f98-280a-4895-b133-3668c85d2419',
    NULL,
    'Before entering an unfamiliar delivery location, you are unsure whether there is enough space to exit safely.',
    'Sebelum memasuki lokasi penghantaran yang tidak dikenali, anda tidak pasti sama ada terdapat ruang yang mencukupi untuk keluar dengan selamat.',
    '["Confirm a safe exit route before entering.", "Enter slowly and decide on the exit after unloading.", "Ask the customer for directions after parking.", "Enter if there appears to be enough space to turn around."]'::jsonb,
    '["Pastikan laluan keluar yang selamat sebelum memasuki kawasan tersebut.", "Masuk dengan perlahan dan tentukan laluan keluar selepas selesai memunggah.", "Tanya pelanggan arah keluar selepas meletakkan kenderaan.", "Masuk jika kelihatan mempunyai ruang yang mencukupi untuk berpusing."]'::jsonb,
    0,
    'Plan a safe exit route before entering unfamiliar locations to reduce the risk of reversing hazards and vehicle damage.',
    'Rancang laluan keluar yang selamat sebelum memasuki lokasi yang tidak dikenali bagi mengurangkan risiko mengundur dan kerosakan pada kenderaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '51fae2f0-e6f6-4e0e-a6f0-1132fef88155',
    NULL,
    'What makes good photographic evidence?',
    'Apakah yang menjadikan bukti bergambar yang baik?',
    '["Clear photos showing the condition from several angles", "One close-up photo only", "Photos edited to highlight the damage", "Photos taken after the goods have been moved"]'::jsonb,
    '["Gambar yang jelas menunjukkan keadaan barang dari beberapa sudut", "Satu gambar jarak dekat sahaja", "Gambar yang telah disunting untuk menonjolkan kerosakan", "Gambar yang diambil selepas barang dialihkan"]'::jsonb,
    0,
    'Clear photographs from multiple angles provide stronger evidence for delivery verification and damage investigations.',
    'Ambil gambar yang jelas dari beberapa sudut sebagai bukti yang kukuh.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ce437508-372e-4c6f-ab2a-2c788911cd54',
    NULL,
    'Before leaving the depot, you notice your vehicle is leaning noticeably to one side.',
    'Sebelum meninggalkan depot, anda mendapati kenderaan anda condong dengan ketara ke sebelah.',
    '["Rearrange the load before departure.", "Continue the journey at a lower speed because the route is relatively short.", "Add extra straps first and rearrange the load if it still feels unstable.", "Complete the first delivery before adjusting the load if necessary."]'::jsonb,
    '["Susun semula muatan sebelum bergerak.", "Teruskan perjalanan pada kelajuan lebih rendah kerana laluan agak dekat.", "Tambah tali pengikat terlebih dahulu dan susun semula muatan jika masih tidak stabil.", "Selesaikan penghantaran pertama sebelum melaraskan muatan jika perlu."]'::jsonb,
    0,
    'An uneven or unstable load should be corrected before departure to reduce the risk of vehicle instability and cargo movement.',
    'Muatan yang tidak seimbang atau tidak stabil perlu diperbetulkan sebelum bergerak bagi mengurangkan risiko ketidakstabilan kenderaan dan pergerakan muatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8c1a55fe-f95e-4ca5-a0d1-75c5dda7e965',
    NULL,
    'You are preparing to leave the vehicle for a delivery when you realise valuable equipment is visible from outside.',
    'Anda hendak meninggalkan kenderaan untuk membuat penghantaran apabila menyedari peralatan berharga boleh dilihat dari luar.',
    '["Secure the equipment where it cannot be seen.", "Lock the vehicle and leave the equipment in place.", "Park closer to the delivery location before leaving it.", "Return quickly to minimise the time the equipment is unattended."]'::jsonb,
    '["Simpan peralatan di tempat yang tidak dapat dilihat sebelum meninggalkan kenderaan.", "Kunci kenderaan dan biarkan peralatan di tempat asal.", "Letakkan kenderaan lebih dekat dengan lokasi penghantaran sebelum meninggalkannya.", "Kembali dengan segera bagi mengurangkan tempoh peralatan ditinggalkan tanpa pengawasan."]'::jsonb,
    0,
    'Removing visible opportunities helps prevent opportunistic theft.',
    'Menghapuskan peluang yang mudah dilihat dapat membantu mencegah kecurian secara oportunis.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ccd36f24-85b1-42aa-9a2b-cbecb742f81d',
    NULL,
    'While unloading, you realise a heavy item is unsafe to carry in one trip.',
    'Semasa memunggah, anda mendapati satu barang yang berat tidak selamat untuk dibawa dalam satu perjalanan.',
    '["Stop and use a safer handling method.", "Complete the lift carefully to save time.", "Carry the item halfway and rest before continuing.", "Lift the item alone if the distance is short."]'::jsonb,
    '["Berhenti dan gunakan kaedah pengendalian yang lebih selamat.", "Teruskan mengangkat dengan berhati-hati untuk menjimatkan masa.", "Bawa barang separuh jalan dan berehat sebelum meneruskan.", "Angkat barang seorang diri jika jaraknya dekat."]'::jsonb,
    0,
    'Stop and reassess the task whenever manual handling cannot be performed safely.',
    'Berhenti dan nilai semula tugas apabila pengendalian secara manual tidak dapat dilakukan dengan selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b38a8cef-05a1-4284-8bae-d77172beef4b',
    NULL,
    'After completing a long drive, you are about to switch off the engine of a turbocharged vehicle.',
    'Selepas selesai memandu dalam perjalanan yang jauh, anda hendak mematikan enjin kenderaan bercas turbo.',
    '["Allow the engine to idle briefly before switching it off.", "Switch off the engine immediately after parking.", "Increase the engine speed briefly before switching it off.", "Leave the engine running only when the weather is hot."]'::jsonb,
    '["Biarkan enjin melahu seketika sebelum dimatikan.", "Matikan enjin sebaik sahaja kenderaan diparkir.", "Tekan pedal minyak seketika sebelum mematikan enjin.", "Biarkan enjin hidup hanya ketika cuaca panas."]'::jsonb,
    0,
    'Allow a turbocharged engine to cool briefly before switching it off to help protect the turbocharger.',
    'Biarkan enjin bercas turbo melahu seketika sebelum dimatikan bagi membantu melindungi pengecas turbo.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3ba08db2-1a65-433b-8d0f-d703582ea70c',
    NULL,
    'You are handing a fragile item to a customer.',
    'Anda menyerahkan satu barang yang mudah pecah kepada pelanggan.',
    '["Reassure the customer that the item was handled carefully.", "Hand over the item without saying anything.", "Tell the customer to inspect the item only if there is visible damage.", "Leave the item with the customer and continue to the next delivery."]'::jsonb,
    '["Yakinkan pelanggan bahawa barang tersebut telah dikendalikan dengan cermat.", "Serahkan barang tanpa berkata apa-apa.", "Minta pelanggan memeriksa barang hanya jika terdapat kerosakan yang jelas.", "Tinggalkan barang bersama pelanggan dan teruskan ke penghantaran seterusnya."]'::jsonb,
    0,
    'A simple reassurance demonstrates professionalism and helps build customer confidence in the delivery service.',
    'Memberikan sedikit jaminan kepada pelanggan menunjukkan sikap profesional dan membantu meningkatkan keyakinan terhadap perkhidmatan penghantaran.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '61325479-d86d-4f3f-890b-452ccc3b6e06',
    NULL,
    'You receive a cash-on-delivery (COD) payment from a customer.',
    'Kamu terima bayaran COD dari pelanggan.',
    '["Count the cash aloud before completing the transaction.", "Count the cash after returning to the vehicle.", "Accept the amount if the customer confirms it is correct.", "Count the cash only if the customer requests it."]'::jsonb,
    '["Kira wang kuat-kuat depan pelanggan sebelum selesaikan urusan.", "Kira wang lepas balik ke kenderaan.", "Terima je jumlah tu kalau pelanggan cakap cukup.", "Kira wang hanya kalau pelanggan minta."]'::jsonb,
    0,
    'Count COD payments aloud before completing the transaction to reduce payment disputes and improve transaction accuracy.',
    'Kira bayaran COD kuat-kuat depan pelanggan sebelum urusan siap, supaya kurang pertikaian dan urusan jadi lebih tepat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a422090b-3005-44f8-845f-fbee0e81623f',
    NULL,
    'Before starting your delivery, the dashcam does not indicate that recording has started.',
    'Sebelum memulakan penghantaran anda, dashcam tidak menunjukkan bahawa rakaman telah bermula.',
    '["Confirm the dashcam is recording before driving off.", "Start the journey and check the dashcam during the first stop.", "Continue driving if the dashcam screen is switched on.", "Record the journey using your mobile phone if necessary."]'::jsonb,
    '["Pastikan dashcam sedang merakam sebelum memulakan pemanduan.", "Mulakan perjalanan dan periksa dashcam semasa hentian pertama.", "Teruskan pemanduan jika skrin dashcam telah terpasang.", "Rakam perjalanan menggunakan telefon bimbit anda jika perlu."]'::jsonb,
    0,
    'Ensure the dashcam is recording before starting the journey to help protect the driver and company if an incident occurs.',
    'Pastikan dashcam sedang merakam sebelum memulakan perjalanan untuk membantu melindungi pemandu dan syarikat sekiranya berlaku insiden.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f3a91b1c-402c-4833-a306-e9084c0b0104',
    NULL,
    'Some sealed cartons cannot be opened to verify their contents before departure.',
    'Beberapa karton berseal tidak boleh dibuka untuk mengesahkan kandungannya sebelum bertolak.',
    '["Record \"Said To Contain\" on the delivery document where appropriate", "Confirm the contents as correct because the cartons are sealed", "Estimate the quantity based on previous deliveries", "Leave the document unchanged since the cartons cannot be checked"]'::jsonb,
    '["Catat \"Said To Contain\" pada dokumen penghantaran jika berkenaan", "Sahkan kandungan adalah betul kerana karton berseal", "Anggarkan kuantiti berdasarkan penghantaran terdahulu", "Biarkan dokumen tanpa sebarang catatan kerana kandungan tidak boleh diperiksa"]'::jsonb,
    0,
    'When the contents cannot be verified, record "Said To Contain" to accurately reflect the limits of the inspection.',
    'Apabila kandungan tidak dapat disahkan, catat "Said To Contain" bagi menunjukkan had pemeriksaan yang telah dibuat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    2,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '170c3d26-47d3-47dc-aaee-9c06441357a8',
    NULL,
    'You have worked six consecutive days and are scheduled for another duty.',
    'Anda telah bekerja selama enam hari berturut-turut dan dijadualkan untuk bertugas lagi.',
    '["Continue working if you feel fit.", "Take one rest day after six working days.", "Work half a day before taking leave.", "Swap shifts without taking a rest day."]'::jsonb,
    '["Terus bekerja jika anda berasa cergas.", "Ambil satu hari rehat selepas enam hari bekerja.", "Bekerja separuh hari sebelum mengambil cuti.", "Tukar syif tanpa mengambil hari rehat."]'::jsonb,
    1,
    'Take the required rest day after six consecutive working days.',
    'Ambil hari rehat yang ditetapkan selepas bekerja enam hari berturut-turut.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c3ed62f3-a2be-4f74-9de4-981e5de7d77e',
    NULL,
    'You find that the first aid kit is incomplete.',
    'Anda mendapati kit pertolongan cemas tidak lengkap.',
    '["Continue if no emergency is expected.", "Replenish the first aid kit before operating.", "Rely on site facilities if needed.", "Inform later after completing the trip."]'::jsonb,
    '["Teruskan perjalanan jika tiada kecemasan dijangka berlaku.", "Lengkapkan kit pertolongan cemas sebelum mengendalikan kenderaan.", "Bergantung kepada kemudahan di lokasi jika perlu.", "Maklumkan kemudian selepas menamatkan perjalanan."]'::jsonb,
    1,
    'Maintain a complete and ready first aid kit at all times.',
    'Pastikan kit pertolongan cemas sentiasa lengkap dan sedia digunakan pada setiap masa.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '64c6c814-5894-4630-9c0f-e99fc736f5c6',
    NULL,
    'Before departure, you conduct a safety inspection.',
    'Semasa pemeriksaan pra-perjalanan rutin, apakah yang perlu anda periksa?',
    '["Focus only on tyres since they wear faster.", "Check brakes, tyres, steering, and vehicle lights.", "Inspect brakes only if carrying heavy cargo.", "Check lights after beginning the journey."]'::jsonb,
    '["Periksa tayar sahaja kerana ia lebih cepat haus.", "Periksa brek, tayar, stereng dan lampu kenderaan.", "Periksa brek hanya jika membawa muatan berat.", "Periksa lampu selepas memulakan perjalanan."]'::jsonb,
    1,
    'Inspect all critical control and lighting systems before driving.',
    'Periksa semua sistem kawalan dan lampu sebelum memandu.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4cf6d5cd-1ca4-4f51-a6ea-236bf9eb9408',
    NULL,
    'You approach a site entrance from a public road. The access lane is narrow and partially obstructed.',
    'Anda menghampiri pintu masuk tapak dari jalan awam. Laluan masuk sempit dan sebahagiannya terhalang.',
    '["Maintain speed to avoid blocking traffic behind", "Slow early and proceed when the path is clear", "Move closer to assess space before stopping", "Enter the access lane and adjust position inside"]'::jsonb,
    '["Kekalkan kelajuan untuk elakkan menghalang trafik di belakang", "Perlahankan awal dan masuk apabila laluan jelas", "Bergerak lebih dekat untuk menilai ruang sebelum berhenti", "Masuk ke laluan dan laraskan kedudukan di dalam"]'::jsonb,
    1,
    'Slow early and confirm the path is clear before entering a constrained access point.',
    'Perlahankan kenderaan lebih awal dan pastikan laluan jelas sebelum memasuki laluan sempit.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '65cc53cd-6e7a-4e44-b7ae-2679dd5f9534',
    NULL,
    'You are involved in a road collision.',
    'Anda terlibat dalam pelanggaran jalan raya.',
    '["Record the third party\u2019s vehicle type and registration number.", "Record only the third party\u2019s phone number.", "Take photos of the damage without recording vehicle details.", "Ask someone help to record the information for you."]'::jsonb,
    '["Catat jenis kenderaan dan nombor pendaftaran pihak ketiga.", "Catat nombor telefon pihak ketiga sahaja.", "Ambil gambar kerosakan tanpa merekod butiran kenderaan.", "Minta pertolongan orang lain mencatat maklumat bagi pihak anda."]'::jsonb,
    0,
    'Record vehicle type and registration details.',
    'Catat jenis kenderaan dan nombor pendaftaran dengan tepat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '18e5289c-1463-417e-a628-0150bc2b9415',
    NULL,
    'You follow a slow vehicle on a busy road. Traffic flows on the adjacent lane.',
    'Anda mengekori kenderaan yang perlahan di jalan sibuk. Trafik bergerak lancar di lorong sebelah.',
    '["Wait for a clearly safe gap before overtaking", "Overtake quickly to avoid staying behind", "Move closer to signal your intent", "Begin overtaking and adjust as traffic responds"]'::jsonb,
    '["Tunggu ruang yang benar-benar selamat sebelum memotong", "Memotong dengan cepat supaya tidak terus terperangkap", "Bergerak lebih dekat untuk memberi isyarat niat", "Mulakan memotong dan sesuaikan kedudukan mengikut trafik"]'::jsonb,
    0,
    'Manage frustration and wait for a clearly safe gap before overtaking.',
    'Kawal rasa marah dan tunggu ruang yang benar-benar selamat sebelum memotong.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0fb07341-2c4f-424a-a1f7-f29c90d7a29b',
    NULL,
    'Before starting duty, you are choosing your footwear.',
    'Sebelum memulakan tugas, anda memilih kasut untuk dipakai.',
    '["Wear covered shoes for duty.", "Wear slippers for short-distance trips.", "Wear sandals if driving locally.", "Change into shoes only when entering a site."]'::jsonb,
    '["Pakai kasut bertutup semasa bertugas.", "Pakai selipar untuk perjalanan jarak dekat.", "Pakai sandal jika memandu di kawasan setempat.", "Tukar kepada kasut hanya apabila memasuki tapak."]'::jsonb,
    0,
    'Wear proper shoes while on duty.',
    'Pakai kasut yang sesuai semasa bertugas.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4473e378-3b9a-44af-913d-771384b83846',
    NULL,
    'You approach an industrial access road. Surfaces are uneven, obstructions present, and visibility is reduced.',
    'Anda menghampiri laluan masuk kawasan industri. Permukaan jalan tidak rata, terdapat halangan, dan pandangan terhad.',
    '["Reduce speed early and adjust your path for hazards", "Maintain a cautious pace and react if conditions worsen", "Proceed steadily while focusing on the access route", "Follow the vehicle ahead navigating the area"]'::jsonb,
    '["Kurangkan kelajuan lebih awal dan sesuaikan laluan untuk elakkan bahaya", "Kekalkan kelajuan berhati-hati dan bertindak jika keadaan bertambah buruk", "Terus bergerak secara stabil sambil fokus pada laluan utama", "Ikut kenderaan di hadapan yang melalui kawasan itu"]'::jsonb,
    0,
    'Adjust early to surface and visibility risks to maintain control.',
    'Sesuaikan pemanduan lebih awal terhadap risiko permukaan dan pandangan untuk kekalkan kawalan kenderaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '68483abd-1a72-4539-b802-a0e9468d583c',
    NULL,
    'At a junction, you prepare to turn while another vehicle approaches from the side and appears unsure of your intention.',
    'Di simpang jalan, anda bersedia untuk membelok apabila sebuah kenderaan dari sisi kelihatan tidak pasti tentang niat anda.',
    '["Signal early and complete the turn when it is safe", "Roll forward slightly to indicate you intend to go", "Wait longer to see how the other driver reacts", "Turn once there is space to avoid delaying traffic behind"]'::jsonb,
    '["Beri isyarat awal dan belok apabila selamat", "Gerak sedikit ke hadapan untuk menunjukkan niat", "Tunggu lebih lama untuk melihat reaksi pemandu lain", "Belok apabila ada ruang untuk mengelakkan kelewatan di belakang"]'::jsonb,
    0,
    'Clear signalling at junctions helps other drivers understand your intention and reduces uncertainty.',
    'Isyarat yang jelas di simpang membantu pemandu lain memahami niat anda dan mengurangkan ketidakpastian.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e228585d-7f55-400c-ba91-8e5f73b28612',
    NULL,
    'Before starting your shift, you notice dark tint film and stickers on part of the windscreen.',
    'Sebelum memulakan syif, anda mendapati terdapat filem gelap dan pelekat pada sebahagian cermin hadapan.',
    '["Leave them since they were already installed.", "Remove or report them because they may obstruct visibility.", "Start driving and adjust your seating position instead.", "Ignore them as long as the road ahead is visible."]'::jsonb,
    '["Biarkan kerana ia telah dipasang sebelum ini.", "Tanggalkan atau laporkan kerana ia boleh menghalang penglihatan.", "Mulakan pemanduan dan laraskan kedudukan tempat duduk.", "Abaikan selagi jalan di hadapan masih kelihatan."]'::jsonb,
    1,
    'Address unauthorised modifications to protect visibility and vehicle safety.',
    'Tangani pengubahsuaian tanpa kelulusan untuk menjaga penglihatan dan keselamatan kenderaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2813090a-f326-437b-954b-0c6576177e50',
    NULL,
    'You are selected for a random blood and urine test during duty.',
    'Anda dipilih untuk menjalani ujian darah dan air kencing secara rawak semasa bertugas.',
    '["Cooperate and undergo the test as required.", "Request to postpone the test to another day.", "Refuse the test because it is unlawful.", "Agree only if other drivers are tested first."]'::jsonb,
    '["Berikan kerjasama dan jalani ujian tersebut seperti yang dikehendaki.", "Minta supaya ujian ditangguhkan ke hari lain.", "Tolak ujian tersebut kerana ia tidak sah di sisi undang-undang.", "Bersetuju hanya jika pemandu lain diuji terlebih dahulu."]'::jsonb,
    0,
    'Comply with random substance testing as required.',
    'Patuhi ujian saringan bahan terlarang secara rawak seperti yang ditetapkan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9c9c7dc6-5609-4ce9-b8dd-74d2f438c7ea',
    NULL,
    'A roadside altercation with a member of the public escalates and feels unsafe.',
    'Berlaku pertelingkahan di tepi jalan dengan orang awam dan keadaan menjadi tidak selamat.',
    '["Handle the matter personally.", "Go to the nearest police station and report.", "Ignore it and continue driving.", "Confront the individual to settle it."]'::jsonb,
    '["Uruskan sendiri situasi tersebut.", "Pergi ke balai polis terdekat dan buat laporan.", "Abaikan dan teruskan pemanduan.", "Bersemuka untuk menyelesaikan isu."]'::jsonb,
    1,
    'Seek police assistance when safety is threatened.',
    'Dapatkan bantuan polis apabila keselamatan terancam.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4e87c2b2-87cd-4661-af9b-b70bc4870c42',
    NULL,
    'While parked in a public area, a bystander hints that a small payment could allow special access.',
    'Semasa parkir di kawasan awam, seorang individu menyatakan bahawa bayaran kecil boleh membolehkan akses khas.',
    '["Decline politely and continue following normal procedures", "Consider the request since it may avoid inconvenience to others", "Delay responding and see if the situation resolves itself", "Suggest discussing the matter later to keep things moving"]'::jsonb,
    '["Tolak dengan sopan dan ikut prosedur biasa", "Pertimbangkan permintaan itu kerana mungkin elakkan kesulitan", "Tangguhkan respons dan lihat perkembangan keadaan", "Cadangkan bincang perkara itu kemudian supaya urusan dapat diteruskan"]'::jsonb,
    0,
    'Refusing improper offers protects integrity and maintains public trust.',
    'Menolak tawaran yang tidak sesuai membantu kekalkan integriti dan kepercayaan orang awam.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6715a2cc-02b3-4041-aeab-1c03b22f39ed',
    NULL,
    'Your goods vehicle is experiencing failure on a highway and you have stopped on the left shoulder.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda telah berhenti di bahu jalan sebelah kiri.',
    '["Remain inside and assess the situation first.", "Switch on the hazard lights immediately.", "Call your supervisor before taking further action.", "Step out briefly to check approaching traffic."]'::jsonb,
    '["Kekal di dalam kenderaan dan nilai keadaan terlebih dahulu.", "Hidupkan lampu kecemasan dengan segera.", "Hubungi penyelia sebelum mengambil tindakan lanjut.", "Keluar sebentar untuk memeriksa trafik yang menghampiri."]'::jsonb,
    1,
    'Activate hazard lights promptly to alert approaching traffic.',
    'Hidupkan lampu kecemasan segera untuk memberi amaran kepada pengguna jalan lain.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '826cbe2d-6347-4a86-973f-88ce46ea5a9a',
    NULL,
    'Inside a site yard, you merge into an internal lane while equipment operates nearby.',
    'Di dalam kawasan tapak, anda perlu masuk ke lorong dalaman sementara jentera beroperasi berhampiran.',
    '["Wait for a clear gap with safe equipment clearance", "Merge when a small gap appears to maintain flow", "Move forward gradually to secure space", "Follow the vehicle ahead into the lane"]'::jsonb,
    '["Tunggu ruang jelas dengan jarak selamat daripada jentera", "Masuk apabila terdapat ruang kecil untuk kekalkan aliran trafik", "Bergerak ke hadapan secara beransur untuk mendapatkan ruang", "Ikut kenderaan di hadapan masuk ke lorong"]'::jsonb,
    0,
    'Choose a clear gap and keep safe distance from operating equipment.',
    'Tunggu ruang yang jelas dan kekalkan jarak selamat dari jentera beroperasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5457f895-0e34-4548-aeef-73a5f47677ca',
    NULL,
    'While reversing to park, your phone receives a message.',
    'Semasa mengundur untuk parkir, telefon anda menerima mesej.',
    '["Ignore the message and complete the manoeuvre", "Pause and check the message before continuing", "Continue reversing while glancing at the phone", "Stop midway and respond to the message"]'::jsonb,
    '["Abaikan mesej dan selesaikan manuver", "Berhenti seketika dan periksa mesej sebelum meneruskan", "Terus mengundur sambil melihat telefon", "Berhenti separuh jalan dan balas mesej"]'::jsonb,
    0,
    'Avoid device use during manoeuvres.',
    'Elakkan penggunaan telefon semasa manuver.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '64193493-5992-4b7d-a449-1b5669e7bd5e',
    NULL,
    'At the end of your shift, the vehicle cabin is cluttered with items.',
    'Pada akhir syif, kabin kenderaan berselerak dengan barang.',
    '["Tidy the cabin and leave it ready for the next driver", "Leave the cabin since the shift has ended", "Remove personal items and clean it the next shift", "Clean only if the next driver is known"]'::jsonb,
    '["Kemas kabin dan sediakan untuk pemandu seterusnya", "Biarkan kabin kerana syif telah tamat", "Ambil barang peribadi dan kemakan kabin keesokan hari", "Bersihkan hanya jika pemandu seterusnya dikenali"]'::jsonb,
    0,
    'Leave the cabin orderly for the next user.',
    'Tinggalkan kabin dalam keadaan kemas untuk pengguna seterusnya.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '675013e7-6d10-4fcf-b198-f881610749e1',
    NULL,
    'During a delivery, a cultural misunderstanding causes tension between you and the customer.',
    'Semasa penghantaran, berlaku salah faham berkaitan budaya yang menyebabkan ketegangan antara anda dan pelanggan.',
    '["Acknowledge the concern respectfully and respond calmly", "Explain your intentions in detail to clear the misunderstanding", "Step back from the discussion to prevent further discomfort", "Defend your position to avoid being seen as disrespectful"]'::jsonb,
    '["Ambil maklum dengan hormat dan beri respons dengan tenang", "Terangkan niat anda dengan terperinci untuk jelaskan salah faham", "Undur diri daripada perbincangan untuk elak keadaan menjadi lebih tidak selesa", "Pertahankan pendirian supaya tidak dianggap tidak hormat"]'::jsonb,
    0,
    'Respectful acknowledgement and calm response help ease tension caused by misunderstandings.',
    'Pengakuan yang hormat dan respons yang tenang membantu redakan ketegangan akibat salah faham.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1b2bad7c-5110-499f-ab3f-6e123110bbb9',
    NULL,
    'After an accident, operations asks about injuries.',
    'Selepas kemalangan, bahagian operasi bertanya tentang kecederaan.',
    '["Confirm injuries to yourself and others involved.", "Say everyone seems fine without checking.", "Wait for medical staff to assess first.", "Report injuries after confirmed by hospital."]'::jsonb,
    '["Sahkan kecederaan kepada diri sendiri dan pihak yang terlibat.", "Maklumkan semua kelihatan baik tanpa membuat pemeriksaan.", "Tunggu petugas perubatan membuat penilaian terlebih dahulu.", "Laporkan kecederaan selepas disahkan oleh pihak hospital."]'::jsonb,
    0,
    'Provide accurate injury status information promptly.',
    'Berikan maklumat status kecederaan dengan tepat dan segera.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5a3b97a3-7ace-407b-957b-8eb18456f9bb',
    NULL,
    'You drive at night in heavy rain. Spray from vehicles ahead reduces visibility.',
    'Anda memandu pada waktu malam dalam keadaan hujan lebat. Percikan air dari kenderaan di hadapan mengurangkan pandangan.',
    '["Increase following distance for more reaction time", "Maintain distance since traffic speed is steady", "Close the gap to keep sight of the vehicle ahead", "Keep the same distance and react if traffic slows"]'::jsonb,
    '["Tambah jarak kenderaan untuk lebih masa bertindak", "Kekalkan jarak kerana kelajuan trafik stabil", "Rapatkan jarak untuk mengekalkan pandangan kenderaan di hadapan", "Kekalkan jarak dan bertindak jika trafik perlahan"]'::jsonb,
    0,
    'Increase spacing in poor visibility to manage sudden slowing safely.',
    'Tingkatkan jarak antara kenderaan Ketika penglihatan terhad bagi menangani tindakan brek mengejut dengan selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c85f72e5-e39d-4daf-b58b-015580eede99',
    NULL,
    'A customer asks you to change the delivery details on the paperwork.',
    'Pelanggan meminta anda mengubah maklumat penghantaran pada dokumen.',
    '["Complete the paperwork accurately and explain the situation.", "Adjust the delivery details as requested by the customer.", "Consider changing the paperwork to avoid delaying the delivery.", "Agree to the customer''s request before checking whether the paperwork should be changed."]'::jsonb,
    '["Lengkapkan dokumen dengan maklumat yang tepat dan jelaskan keadaan sebenar.", "Ubah maklumat penghantaran seperti yang diminta oleh pelanggan.", "Pertimbangkan untuk mengubah dokumen bagi mengelakkan kelewatan penghantaran.", "Bersetuju dengan permintaan pelanggan sebelum memastikan sama ada dokumen perlu diubah."]'::jsonb,
    0,
    'Accurate documentation ensures transparency and protects everyone involved.',
    'Dokumen yang tepat memastikan ketelusan dan melindungi semua pihak yang terlibat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '36c6c99d-ac58-4707-b28b-3b425f1b8077',
    NULL,
    'You arrive at a delivery location and realise the only exit requires reversing a fully loaded vehicle.',
    'Anda tiba di lokasi penghantaran dan mendapati satu-satunya laluan keluar memerlukan anda mengundur kenderaan yang masih penuh dengan muatan.',
    '["Reassess the approach before proceeding further.", "Continue and reverse out carefully after the delivery.", "Ask someone nearby to guide the reversing manoeuvre.", "Complete the delivery first to avoid delaying the schedule."]'::jsonb,
    '["Nilai semula laluan sebelum meneruskan perjalanan.", "Teruskan dan undur keluar dengan berhati-hati selepas selesai penghantaran.", "Minta seseorang berhampiran membantu mengarah semasa mengundur.", "Selesaikan penghantaran dahulu bagi mengelakkan kelewatan jadual."]'::jsonb,
    0,
    'Avoid situations that require unnecessary reversing by planning vehicle positioning before entering.',
    'Elakkan situasi yang memerlukan pengunduran yang tidak perlu dengan merancang kedudukan kenderaan sebelum memasuki sesuatu kawasan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ca9220a8-7daa-41c2-bf29-fd76f4f7fa1b',
    NULL,
    'You arrive at a factory 30 minutes before your scheduled unloading appointment. All loading bays are occupied.',
    'Anda tiba di sebuah kilang 30 minit lebih awal daripada waktu temujanji unloading. Semua loading bay sedang digunakan.',
    '["Park at the designated waiting area and wait for your assigned slot", "Queue at the factory entrance until a bay becomes available", "Sound your horn to let the gate know you have arrived", "Stop on the roadside near the entrance while waiting"]'::jsonb,
    '["Parkir di kawasan menunggu yang ditetapkan dan tunggu giliran anda", "Beratur di pintu masuk kilang sehingga loading bay tersedia", "Bunyikan hon untuk memaklumkan pengawal bahawa anda telah tiba", "Berhenti di tepi jalan berhampiran pintu masuk sementara menunggu"]'::jsonb,
    0,
    'Follow the site''s appointment and waiting procedures. Early arrival does not guarantee earlier unloading.',
    'Ikuti prosedur temujanji dan kawasan menunggu di premis. Datang awal tidak bermaksud unloading akan dibuat lebih awal.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '45d1a6ef-f915-4f10-8fef-f4b81f8ea9b5',
    NULL,
    'You arrive at a customer''s premises for delivery.',
    'Anda tiba di premis pelanggan untuk membuat penghantaran.',
    '["Register at the guardhouse, wear the visitor pass and proceed as instructed", "Walk directly to the receiving office to save time", "Follow another visitor without registering", "Enter the warehouse once the gate is open"]'::jsonb,
    '["Daftar di pondok pengawal, pakai pas pelawat dan ikut arahan", "Terus ke pejabat penerimaan untuk menjimatkan masa", "Ikut pelawat lain masuk tanpa mendaftar", "Masuk ke gudang sebaik sahaja pintu pagar dibuka"]'::jsonb,
    0,
    'Follow site access procedures and maintain professional conduct at all times.',
    'Patuhi prosedur kemasukan premis dan sentiasa bersikap profesional.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ab5c903c-223f-4729-967f-d36476bd6db0',
    NULL,
    'Your company or customer requires photographic evidence during a delivery. What should you do?',
    'Syarikat atau pelanggan memerlukan bukti bergambar semasa penghantaran. Apakah yang perlu anda lakukan?',
    '["Take the required photographs before completing the delivery", "Take photographs only if damage is found", "Take photographs only if the customer requests them on site", "Skip the photographs if the delivery is completed successfully"]'::jsonb,
    '["Ambil gambar yang diperlukan sebelum melengkapkan penghantaran", "Ambil gambar hanya jika terdapat kerosakan", "Ambil gambar hanya jika diminta oleh pelanggan di premis", "Tidak perlu mengambil gambar jika penghantaran berjaya diselesaikan"]'::jsonb,
    0,
    'When photographic evidence is required by the company or customer, it must be taken as part of the delivery process.',
    'Ambil gambar apabila dikehendaki oleh syarikat atau pelanggan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'bb4bc651-38c5-44af-9d5c-271c0ca21b30',
    NULL,
    'During the final loading check, a carton slides when you perform a push test on the load.',
    'Semasa pemeriksaan akhir muatan, sebuah kotak meluncur apabila anda melakukan ujian tolak pada muatan.',
    '["Secure or re-stack the load before departure.", "Add another strap over the top layer only.", "Continue if the cargo area doors close properly.", "Drive more slowly until the load settles."]'::jsonb,
    '["Ikat atau susun semula muatan sebelum bergerak.", "Tambah satu lagi tali pengikat pada lapisan atas sahaja.", "Teruskan perjalanan jika pintu ruang kargo boleh ditutup dengan sempurna.", "Pandu dengan lebih perlahan sehingga muatan menjadi stabil."]'::jsonb,
    0,
    'Any load that moves during inspection should be secured before the vehicle is moved.',
    'Sebarang muatan yang bergerak semasa pemeriksaan perlu diikat atau disusun semula sebelum kenderaan bergerak.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e1f90107-c8bd-4518-b0db-56ad646d4afe',
    NULL,
    'You stop briefly to deliver a parcel and consider leaving the engine running.',
    'Anda berhenti seketika untuk membuat penghantaran dan mempertimbangkan untuk membiarkan enjin terus hidup.',
    '["Switch off the engine and secure the vehicle.", "Leave the engine running if the stop will be less than a minute.", "Leave the engine running if the vehicle remains within sight.", "Keep the engine running but lock the doors."]'::jsonb,
    '["Matikan enjin dan pastikan kenderaan dikunci serta selamat.", "Biarkan enjin hidup jika berhenti kurang daripada seminit.", "Biarkan enjin hidup jika kenderaan masih berada dalam pandangan.", "Biarkan enjin hidup tetapi kunci pintu kenderaan."]'::jsonb,
    0,
    'Always switch off the engine and secure the vehicle before leaving it unattended.',
    'Sentiasa matikan enjin dan pastikan kenderaan dikunci serta selamat sebelum meninggalkannya tanpa pengawasan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd4283b5b-8727-430d-909d-139fff19b8d2',
    NULL,
    'You are about to deliver a heavy item to an apartment building.',
    'Anda hendak menghantar satu barang yang berat ke sebuah bangunan apartmen.',
    '["Confirm whether the lift is available before unloading the item.", "Unload the item first and check for lift access afterwards.", "Carry the item to the building entrance before checking the lift.", "Ask the building security about the lift after unloading the item."]'::jsonb,
    '["Pastikan lif boleh digunakan sebelum memunggahkan barang tersebut.", "Turunkan barang terlebih dahulu dan periksa kemudahan lif selepas itu.", "Bawa barang ke pintu masuk bangunan sebelum memeriksa lif.", "Tanya pengawal keselamatan tentang lif selepas memunggahkan barang."]'::jsonb,
    0,
    'Confirm access arrangements before unloading heavy items to avoid unnecessary handling, delays and manual handling risks.',
    'Pastikan kemudahan akses disahkan sebelum memunggahkan barang yang berat bagi mengelakkan pengendalian yang tidak perlu, kelewatan dan risiko pengendalian manual.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1f088686-72f6-414f-b052-c2b0f9d615aa',
    NULL,
    'While reversing, heavy rain makes it difficult to see clearly through the reversing camera.',
    'Semasa mengundur, hujan lebat menyebabkan paparan kamera undur sukar dilihat dengan jelas.',
    '["Stop and confirm the clearance before continuing.", "Depend on the warning beep and continue reversing slowly.", "Reverse more slowly without stopping.", "Continue because the mirrors still provide some visibility."]'::jsonb,
    '["Berhenti dan pastikan ruang kelegaan mencukupi sebelum meneruskan.", "Bergantung pada bunyi amaran dan terus mengundur secara perlahan.", "Undur dengan lebih perlahan tanpa berhenti.", "Teruskan kerana cermin sisi masih memberikan sedikit penglihatan."]'::jsonb,
    0,
    'When visibility is reduced, stop and confirm there is sufficient clearance before continuing the manoeuvre.',
    'Apabila penglihatan terhad, berhenti dan pastikan ruang kelegaan mencukupi sebelum meneruskan pergerakan mengundur.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd43a084b-e314-4727-8578-98afde79524d',
    NULL,
    'Your vehicle is temporarily blocking part of a narrow road while unloading.',
    'Kenderaan anda menghalang sebahagian jalan yang sempit semasa kerja memunggah.',
    '["Apologise politely and explain that the vehicle will be moved shortly.", "Continue unloading because the stop will only take a few minutes.", "Ignore the waiting motorists and finish the delivery quickly.", "Tell motorists to use another route until unloading is completed."]'::jsonb,
    '["Minta maaf dengan sopan dan jelaskan bahawa kenderaan akan dialihkan sebentar lagi.", "Teruskan memunggah kerana hanya mengambil masa beberapa minit.", "Abaikan pemandu yang menunggu dan selesaikan penghantaran dengan cepat.", "Minta pemandu lain menggunakan laluan lain sehingga kerja memunggah selesai."]'::jsonb,
    0,
    'A polite explanation helps maintain good public relations and reduces unnecessary complaints.',
    'Penjelasan yang sopan membantu mengekalkan hubungan baik dengan orang awam dan mengurangkan aduan yang tidak perlu.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ce649777-34f7-4755-9dfe-f60859c0eea3',
    NULL,
    'You are completing the proof of delivery (POD) after delivering to a shoplot.',
    'Anda sedang melengkapkan bukti penghantaran (POD) selepas membuat penghantaran ke rumah kedai.',
    '["Ensure the shop signboard is clearly visible in the POD photo.", "Ensure the parcel is clearly visible in the POD photo.", "Take the POD when required.", "Take the photo from the nearest available position."]'::jsonb,
    '["Pastikan papan tanda kedai jelas kelihatan dalam foto POD.", "Pastikan bungkusan jelas kelihatan dalam foto POD.", "Ambil POD apabila diperlukan.", "Ambil foto dari kedudukan terdekat yang tersedia."]'::jsonb,
    0,
    'Include the shop signboard in the POD photo to verify the authorised delivery location and support delivery records.',
    'Sertakan papan tanda kedai dalam foto POD untuk mengesahkan lokasi penghantaran yang dibenarkan dan menyokong rekod penghantaran.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b6130579-ef23-4f7e-96e8-3cc83340bb6d',
    NULL,
    'You are arranging the cargo before departure.',
    'Anda sedang menyusun muatan sebelum bertolak.',
    '["Balance the load with heavier goods low and towards the front", "Place heavy goods at the rear for easier unloading later", "Stack heavy goods on top to maximise available cargo space", "Arrange the cargo according to the planned delivery sequence"]'::jsonb,
    '["Seimbangkan muatan dengan barang berat di bawah dan di hadapan", "Letakkan barang berat di belakang supaya mudah unloading", "Susun barang berat di atas untuk maksimumkan ruang kargo", "Susun muatan mengikut urutan penghantaran"]'::jsonb,
    0,
    'Proper load distribution improves vehicle stability, braking performance and cargo protection throughout the journey.',
    'Agihan muatan yang betul meningkatkan kestabilan, membrek dan perlindungan muatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b4d70804-5e8f-4715-8933-ad5a089a88ff',
    NULL,
    'While unloading, you notice one of the goods is damaged before delivery is completed.',
    'Semasa unloading, anda menyedari terdapat barang yang rosak sebelum penghantaran selesai.',
    '["Take a photo and inform the receiver before continuing", "Complete the delivery before mentioning the damage", "Hide the damaged good until the customer signs", "Set the damaged good aside without informing anyone"]'::jsonb,
    '["Ambil gambar dan maklumkan kepada penerima sebelum meneruskan penghantaran", "Selesaikan penghantaran terlebih dahulu sebelum memaklumkan kerosakan", "Sorokkan barang yang rosak sehingga pelanggan menandatangani penerimaan", "Asingkan barang yang rosak tanpa memaklumkan kepada sesiapa"]'::jsonb,
    0,
    'Document and report damage immediately to ensure an honest delivery process.',
    'Rekod dan laporkan kerosakan dengan segera bagi memastikan proses penghantaran yang jujur.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    3,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ea588c0e-a52b-44b6-9d1f-c155e06c316f',
    NULL,
    'You prepare to change lanes in steady traffic. Motorcycles filter between lanes and traffic slows near an exit.',
    'Anda bersedia untuk menukar lorong dalam trafik lancar. Motosikal bergerak di antara lorong dan trafik perlahan berhampiran susur keluar.',
    '["Signal early and complete full mirror checks before moving", "Signal as you move and rely on others to adjust", "Check mirrors quickly and move when the lane looks clear", "Wait for traffic to stabilise before signalling"]'::jsonb,
    '["Beri isyarat awal dan periksa cermin sepenuhnya sebelum bergerak", "Beri isyarat semasa bergerak dan harap pemandu lain menyesuaikan diri", "Periksa cermin dengan cepat dan bergerak apabila lorong kelihatan jelas", "Tunggu trafik stabil sebelum memberi isyarat"]'::jsonb,
    0,
    'Signal early and complete full checks before changing lanes.',
    'Beri isyarat awal dan lakukan pemeriksaan penuh sebelum menukar lorong.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '914d42c8-f4c8-48c5-9869-c947140db003',
    NULL,
    'After a delivery, you find a required document was not completed according to company procedure.',
    'Selepas selesai penghantaran, anda mendapati dokumen yang diperlukan tidak dilengkapkan mengikut prosedur syarikat.',
    '["Complete and correct the document before closing the job", "Leave it since the delivery is already done", "Make a brief note and update it later if needed", "Proceed to the next task and rely on existing records"]'::jsonb,
    '["Lengkapkan dan betulkan dokumen sebelum menyelesaikan tugasan", "Biarkan sahaja kerana penghantaran sudah selesai", "Buat catatan ringkas dan kemas kini kemudian jika perlu", "Teruskan ke tugasan seterusnya dan bergantung pada rekod sedia ada"]'::jsonb,
    0,
    'Complete documents correctly to maintain procedural compliance.',
    'Lengkapkan dokumen dengan betul untuk memastikan pematuhan terhadap prosedur.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9249b86e-7113-4f2d-9709-4ad587d7982c',
    NULL,
    'You are preparing to start your trip and will return later the same day.',
    'Anda sedang bersedia untuk memulakan perjalanan dan akan kembali pada hari yang sama.',
    '["Conduct inspection only before starting the trip.", "Conduct inspection only after completing the trip.", "Conduct inspections both before and after the trip.", "Conduct inspection only if a defect is suspected."]'::jsonb,
    '["Lakukan pemeriksaan sebelum memulakan perjalanan sahaja.", "Lakukan pemeriksaan selepas menamatkan perjalanan sahaja.", "Lakukan pemeriksaan sebelum dan selepas perjalanan.", "Lakukan pemeriksaan hanya jika terdapat tanda kerosakan."]'::jsonb,
    2,
    'Perform required inspections before and after every trip.',
    'Lakukan pemeriksaan yang ditetapkan sebelum dan selepas setiap perjalanan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a546657b-7f5f-46cc-9487-41c5898ddf4f',
    NULL,
    'You notice only three safety cones are available in the vehicle.',
    'Anda mendapati hanya tiga kon keselamatan tersedia di dalam kenderaan.',
    '["Proceed since cones are rarely used.", "Ensure five compliant safety cones are available.", "Carry additional cones only for highway trips.", "Proceed since 3 cones is enough"]'::jsonb,
    '["Teruskan perjalanan kerana kon jarang digunakan.", "Pastikan lima kon keselamatan yang mematuhi spesifikasi tersedia.", "Bawa kon tambahan hanya untuk perjalanan di lebuh raya.", "Teruskan kerana 3 kon sudah mencukupi."]'::jsonb,
    1,
    'Ensure the required number of compliant safety cones is carried.',
    'Pastikan bilangan kon keselamatan yang mematuhi spesifikasi dibawa seperti yang ditetapkan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ddccbfe1-180e-46e1-bdf4-b0f63bbccf6e',
    NULL,
    'You are on foot near your vehicle in an active loading area. Forklifts operate and stacked goods restrict visibility.',
    'Anda berjalan berhampiran kenderaan di kawasan pemunggahan aktif. Forklift beroperasi dan susunan barangan menghadkan pandangan.',
    '["Keep clear of loading paths and wait until movement settles", "Move closer to observe equipment movement", "Walk through quickly to minimise time in the area", "Stand where operators can see you and keep moving"]'::jsonb,
    '["Kekal jauh dari laluan pemunggahan dan tunggu sehingga pergerakan reda", "Bergerak lebih dekat untuk memerhati pergerakan jentera", "Berjalan cepat untuk kurangkan masa di kawasan itu", "Berdiri di tempat pengendali boleh nampak dan terus bergerak"]'::jsonb,
    0,
    'Keep clear of loading activity to avoid sudden equipment movement and blind spots.',
    'Kekalkan jarak dari aktiviti pemunggahan untuk elakkan pergerakan jentera mengejut dan kawasan titik buta.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'cb6d47b3-6cf4-452c-b98f-332fd9753634',
    NULL,
    'While making a delivery, members of the public are nearby and watching your interaction with the customer.',
    'Semasa membuat penghantaran, orang awam berada berdekatan dan memerhati interaksi anda dengan pelanggan.',
    '["Focus only on the customer and ignore the surroundings", "Maintain calm, respectful behaviour mindful of the public presence", "Keep the exchange short to avoid attention", "Let the customer lead the interaction tone"]'::jsonb,
    '["Fokus pada pelanggan sahaja dan abaikan keadaan sekeliling", "Kekalkan tingkah laku tenang dan hormat dengan mengambil kira kehadiran orang awam", "Pendekkan perbualan untuk elak perhatian", "Biarkan pelanggan tentukan nada interaksi"]'::jsonb,
    1,
    'Professional behaviour matters not only to the customer, but also to the public observing the interaction.',
    'Tingkah laku profesional penting bukan sahaja kepada pelanggan tetapi juga kepada orang awam yang memerhati.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c2ccbb72-3d90-4d9b-8597-f3a6719d5c97',
    NULL,
    'Your goods vehicle is experiencing failure on a highway and you are placing a warning triangle.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan anda sedang meletakkan segi tiga amaran.',
    '["Place it a few metres behind the vehicle for quick visibility.", "Place it about 50 metres to the rear of the vehicle.", "Place it beside the vehicle near the shoulder.", "Hold it while standing near traffic to alert drivers."]'::jsonb,
    '["Letakkan beberapa meter di belakang kenderaan supaya mudah dilihat dengan cepat.", "Letakkan kira-kira 50 meter di belakang kenderaan.", "Letakkan di sisi kenderaan berhampiran bahu jalan.", "Pegang sambil berdiri berhampiran trafik untuk memberi amaran."]'::jsonb,
    1,
    'Position warning devices at a safe rear distance to alert approaching traffic early.',
    'Letakkan alat amaran pada jarak selamat di belakang kenderaan untuk memberi amaran awal kepada trafik yang menghampiri.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a2f450ab-3af7-4180-beb4-b5818dff3a8b',
    NULL,
    'You arrive at a customer site. Access lanes are narrow and forklifts operate near the loading area.',
    'Anda tiba di tapak pelanggan. Laluan masuk sempit dan forklift beroperasi berhampiran kawasan pemuatan.',
    '["Hold back until access is clearly available", "Move forward slowly to secure a position near loading", "Approach while keeping visible to site staff", "Continue advancing to avoid delaying loading"]'::jsonb,
    '["Tunggu di luar sehingga laluan benar-benar jelas", "Bergerak perlahan untuk mendapatkan kedudukan berhampiran kawasan pemuatan", "Hampiri kawasan tersebut dengan memastikan anda kelihatan oleh pekerja tapak", "Terus bergerak untuk elakkan kelewatan proses pemuatan."]'::jsonb,
    0,
    'Keep distance from constrained access and active loading areas.',
    'Kekalkan jarak dari laluan sempit dan kawasan loading aktif.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8d1086bd-573d-4605-bc32-da4b67e4bbc7',
    NULL,
    'At a security checkpoint, the vehicle ahead is being cleared and the guard signals you to move closer.',
    'Di pusat pemeriksaan keselamatan, kenderaan di hadapan sedang diperiksa dan pengawal memberi isyarat supaya anda bergerak lebih dekat.',
    '["Close the gap to speed up clearance", "Keep a safe following distance", "Stop directly behind the vehicle", "Move slowly and rely on the guard to manage spacing"]'::jsonb,
    '["Rapatkan jarak untuk mempercepatkan pemeriksaan", "Kekalkan jarak selamat dengan kenderaan di hadapan", "Berhenti tepat di belakang kenderaan", "Bergerak perlahan dan bergantung pada pengawal untuk mengawal jarak"]'::jsonb,
    1,
    'Checkpoint instructions do not replace safe spacing.',
    'Arahan pusat pemeriksaan tidak menggantikan disiplin jarak selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '13b6f294-c459-4989-8a6a-f644a2035130',
    NULL,
    'While manoeuvring at low speed with a load, you feel the load shift and notice the vehicle is closer than expected to an obstacle.',
    'Semasa membuat manuver pada kelajuan rendah dengan muatan, anda merasakan muatan bergerak dan menyedari kenderaan lebih dekat daripada jangkaan kepada halangan.',
    '["Stop and assess if it is safe to proceed", "Proceed slowly and adjust steering to maintain clearance", "Complete the manoeuvre and check the load afterward", "Continue moving and secure the load once clear"]'::jsonb,
    '["Berhenti dan pastikan selamat sebelum meneruskan", "Terus bergerak perlahan dan laraskan stereng untuk kekalkan jarak", "Selesaikan manuver dan periksa muatan selepas itu", "Terus bergerak dan periksa di tempat perhentian"]'::jsonb,
    0,
    'Stop and reassess when load shift or clearance risk appears.',
    'Berhenti dan nilai semula apabila muatan bergerak atau jarak menjadi sempit.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '17d3dd3a-a56d-4091-9c17-29dc44b8231f',
    NULL,
    'A disagreement arises on site, and the discussion starts to become tense.',
    'Berlaku perbezaan pendapat di tapak dan perbincangan mula menjadi tegang.',
    '["Speak calmly, acknowledge concerns, and clarify next steps", "Restate your position firmly to end the discussion", "Reduce interaction and wait for the situation to pass", "Continue the task without engaging further"]'::jsonb,
    '["Bercakap dengan tenang dan jelaskan langkah seterusnya", "Tegaskan pendirian anda untuk tamatkan perbincangan", "Kurangkan interaksi dan tunggu keadaan reda", "Teruskan tugas tanpa melibatkan diri"]'::jsonb,
    0,
    'Calm acknowledgement and clear steps help prevent disagreements from escalating.',
    'Pendekatan yang tenang dan langkah yang jelas membantu elakkan keadaan menjadi lebih tegang.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2b396223-d020-4721-99b6-ed8311f85825',
    NULL,
    'You are asked to modify the vehicle’s GPS tracking or speedometer settings.',
    'Anda diminta untuk mengubah suai tetapan sistem GPS atau meter kelajuan kenderaan.',
    '["Make the adjustment if it improves convenience.", "Refuse any modification that violates safety or company protocol.", "Adjust the settings temporarily and restore them later.", "Modify only if other drivers have done so."]'::jsonb,
    '["Buat pelarasan jika ia memudahkan urusan.", "Tolak sebarang pengubahsuaian yang melanggar peraturan keselamatan atau prosedur syarikat.", "Ubah tetapan sementara dan pulihkan kemudian.", "Buat Pengubahsuaian hanya jika pemandu lain pernah melakukannya."]'::jsonb,
    1,
    'Do not alter vehicle systems against safety rules or company protocol.',
    'Jangan mengubah suai sistem kenderaan yang bertentangan dengan peraturan keselamatan atau prosedur syarikat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6b6e09c1-b263-4223-85a1-ee0e2049481d',
    NULL,
    'You arrive at a site and the nearest space is marked as a prohibited parking area.',
    'Anda tiba di tapak dan ruang terdekat ditanda sebagai kawasan larangan parkir.',
    '["Park there briefly if unloading is quick.", "Find a permitted parking space.", "Park there if other vehicles are doing the same.", "Stop there with hazard lights switched on."]'::jsonb,
    '["Parkir seketika jika proses menurunkan muatan adalah cepat.", "Cari ruang parkir yang dibenarkan.", "Parkir di situ jika kenderaan lain melakukan perkara yang sama.", "Berhenti di situ dengan lampu kecemasan dihidupkan."]'::jsonb,
    1,
    'Do not park in prohibited areas.',
    'Parkir hanya di kawasan yang dibenarkan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9588a728-17f8-430d-91f2-3452c0371ec2',
    NULL,
    'While reversing slowly in a tight site area, you lose clear sight of one rear corner.',
    'Semasa mengundur perlahan di kawasan tapak yang sempit, anda hilang pandangan jelas pada satu sudut belakang.',
    '["Continue reversing slowly using mirrors", "Stop the vehicle and reassess the situation", "Turn the steering slightly and keep moving", "Rely on previous experience and continue"]'::jsonb,
    '["Terus mengundur perlahan menggunakan cermin", "Berhenti dan nilai semula keadaan", "Pusing stereng sedikit dan terus bergerak", "Bergantung pada pengalaman lalu dan teruskan"]'::jsonb,
    1,
    'Stop when visibility is uncertain to prevent damage and protect people and property.',
    'Berhenti apabila pandangan tidak jelas untuk mengelakkan kerosakan dan melindungi orang serta harta benda.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '853703d5-109e-4e94-8607-bb652aa34753',
    NULL,
    'You slow to turn near pedestrians, and nearby road users appear unsure of your intention.',
    'Anda memperlahankan kenderaan untuk membelok berhampiran pejalan kaki, dan pengguna jalan lain kelihatan tidak pasti tentang niat anda.',
    '["Signal early and make the turn carefully", "Slow further to see how others react", "Turn once there is space without signalling", "Edge forward slightly to show what you intend to do"]'::jsonb,
    '["Beri isyarat awal dan belok secara cermat", "Perlahankan lagi untuk melihat reaksi orang lain", "Belok apabila ada ruang tanpa memberi isyarat", "Gerak sedikit ke hadapan untuk menunjukkan niat"]'::jsonb,
    0,
    'Early signalling helps pedestrians and other road users understand your intention and stay safe.',
    'Isyarat awal membantu pejalan kaki dan pengguna jalan lain memahami niat anda dan kekal selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a810d5fd-1a12-49b9-8be4-d148ae4c7ddf',
    NULL,
    'You enter a narrow roadworks zone with barriers while members of the public are standing nearby',
    'Anda memasuki kawasan pembaikan jalan yang sempit dengan penghadang, sementara orang awam berada berhampiran.',
    '["Reduce speed early and proceed cautiously", "Maintain speed to clear the zone quickly", "Follow the vehicle ahead closely to avoid delay", "Focus on steering accuracy and ignore people nearby"]'::jsonb,
    '["Kurangkan kelajuan lebih awal dan lalui kawasan dengan berhati-hati", "Kekalkan kelajuan untuk melepasi kawasan dengan cepat", "Ikut rapat kenderaan di hadapan supaya tidak lewat", "Fokus pada kawalan stereng dan abaikan orang di sekitar"]'::jsonb,
    0,
    'Reducing speed early in high-risk areas helps protect the public and reduces potential harm.',
    'Mengurangkan kelajuan lebih awal di kawasan berisiko membantu melindungi orang awam dan mengurangkan potensi bahaya.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '17a77c57-4125-451e-a014-d095cbab2da3',
    NULL,
    'A small fire starts near the engine compartment while parked.',
    'Semasa parkir, kebakaran kecil bermula berhampiran ruang enjin.',
    '["Use the ABC fire extinguisher if safe.", "Wait for others to assist before acting.", "Pour available water to reduce flames.", "Observe briefly before deciding."]'::jsonb,
    '["Gunakan alat pemadam api jenis ABC jika keadaan selamat.", "Tunggu bantuan sebelum mengambil tindakan.", "Tuang air yang ada untuk mengurangkan api.", "Perhatikan keadaan seketika sebelum membuat keputusan."]'::jsonb,
    0,
    'Use the appropriate extinguisher if the fire is manageable.',
    'Gunakan alat pemadam api yang sesuai jika kebakaran masih boleh dikawal dan keadaan selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '17e43f81-2d8c-4dd5-804c-f47ff01c9f60',
    NULL,
    'After ensuring safety at the accident scene, what should you do next?',
    'Selepas memastikan keselamatan di lokasi kemalangan, apakah tindakan seterusnya?',
    '["Report immediately to office.", "Complete delivery first and report later.", "Wait until returning to depot.", "Inform only if damage is serious."]'::jsonb,
    '["Laporkan segera kepada pejabat.", "Selesaikan penghantaran dahulu dan laporkan kemudian.", "Tunggu sehingga kembali ke depot.", "Maklumkan hanya jika kerosakan adalah serius."]'::jsonb,
    0,
    'Report the incident immediately and await instruction.',
    'Laporkan kejadian segera dan tunggu arahan lanjut.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '96beb31b-707a-4a2e-9b32-ea6124dcc14c',
    NULL,
    'While driving inside a site, you encounter uneven surfaces and hazards along the route. You are within the speed limit.',
    'Semasa memandu di dalam tapak, anda menghadapi permukaan tidak rata dan bahaya di laluan. Anda masih dalam had laju dibenarkan.',
    '["Reduce speed to suit the hazards", "Maintain speed since it is within the limit", "Adjust speed only near visible obstacles", "Continue at normal speed and rely on steering"]'::jsonb,
    '["Kurangkan kelajuan mengikut keadaan", "Kekalkan kelajuan kerana masih dalam had laju", "Sesuaikan kelajuan hanya berhampiran halangan yang jelas", "Teruskan pada kelajuan biasa dan bergantung pada kawalan stereng"]'::jsonb,
    0,
    'Adjust speed to suit conditions even within the limit.',
    'Sesuaikan kelajuan mengikut keadaan walaupun masih dalam had laju.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4da7753f-72c9-45ae-847f-0dfc57dac0d0',
    NULL,
    'During unloading, a site worker suggests a small personal favour to speed up the process.',
    'Semasa proses memunggah, seorang pekerja tapak mencadangkan bantuan peribadi kecil untuk mempercepatkan proses.',
    '["Decline politely and continue unloading as required", "Agree briefly since it may help everyone finish faster", "Avoid responding directly and keep working to reduce attention", "Suggest handling the request later to keep things moving"]'::jsonb,
    '["Tolak dengan sopan dan teruskan proses memunggah seperti dikehendaki", "Setuju seketika kerana ia mungkin mempercepatkan kerja", "Elakkan memberi respons secara langsung dan teruskan kerja", "Cadangkan urus perkara itu kemudian supaya kerja berjalan"]'::jsonb,
    0,
    'Declining improper requests helps maintain integrity and fair working practices.',
    'Menolak permintaan yang tidak sesuai membantu kekalkan integriti dan amalan kerja yang adil.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'daf6c6bc-73fe-44c6-b2af-cdb055065103',
    NULL,
    'During a delivery, a culturally sensitive interaction is happening while people nearby are watching or recording.',
    'Semasa penghantaran, berlaku interaksi sensitif berkaitan budaya dan orang sekeliling sedang melihat dan merakam.',
    '["Maintain respectful behaviour and continue professionally", "Explain your actions carefully so others do not misinterpret them", "Limit the interaction to avoid drawing further attention", "Adjust your response to match how others expect you to behave"]'::jsonb,
    '["Kekalkan tingkah laku yang hormat dan teruskan secara profesional", "Terangkan tindakan anda dengan teliti supaya tidak disalah tafsir", "Hadkan interaksi untuk elak menarik lebih perhatian", "Ubah respons anda mengikut jangkaan orang sekeliling"]'::jsonb,
    0,
    'Maintaining respectful, professional behaviour protects your image during visible interactions.',
    'Sikap hormat dan profesional membantu melindungi imej anda apabila situasi diperhatikan orang lain.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3000249f-f6a2-4b31-b0cd-75463afd17c6',
    NULL,
    'You prepare to merge into a moving lane when another driver accelerates and blocks the available gap.',
    'Anda bersedia untuk masuk ke lorong yang sedang bergerak apabila seorang pemandu lain memecut dan menutup ruang yang ada.',
    '["Hold back and wait for a clearer gap", "Force the merge to assert your position", "Move closer to pressure the other driver to yield", "Gesture briefly to signal dissatisfaction"]'::jsonb,
    '["Tahan dan tunggu ruang yang lebih jelas serta selamat", "Paksa masuk untuk mempertahankan kedudukan anda", "Rapatkan kenderaan untuk memberi tekanan supaya pemandu lain mengalah", "Buat isyarat ringkas tanda tidak puas hati"]'::jsonb,
    0,
    'Waiting for a safe gap and avoiding confrontation reduces risk and prevents unnecessary conflict.',
    'Menunggu ruang yang selamat dan mengelakkan konfrontasi membantu mengurangkan risiko serta ketegangan di jalan raya.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c25b46a4-3c75-440f-90ad-bcdf5e6b690f',
    NULL,
    'Before entering a narrow access road, you cannot confirm whether it has a suitable exit.',
    'Sebelum memasuki jalan masuk yang sempit, anda tidak dapat memastikan sama ada terdapat laluan keluar yang sesuai.',
    '["Verify the route before driving in.", "Enter slowly and stop if you cannot continue.", "Follow the route if other vehicles have used it.", "Depend on navigation to identify an exit after entering."]'::jsonb,
    '["Sahkan laluan tersebut sebelum memasukinya.", "Masuk dengan perlahan dan berhenti jika tidak dapat meneruskan perjalanan.", "Ikut laluan tersebut jika kenderaan lain pernah melaluinya.", "Bergantung pada sistem navigasi untuk mencari laluan keluar selepas memasuki kawasan tersebut."]'::jsonb,
    0,
    'Verify access and exit routes before entering confined areas to reduce operational risk.',
    'Sahkan laluan masuk dan keluar sebelum memasuki kawasan yang sempit bagi mengurangkan risiko operasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8a77a776-356b-4729-b134-ee5a87b610dd',
    NULL,
    'During hot weather, you are concerned the cab will become warm while making a delivery.',
    'Semasa cuaca panas, anda bimbang kabin akan menjadi panas ketika membuat penghantaran.',
    '["Secure the vehicle before leaving it.", "Leave one window slightly open to improve ventilation.", "Return to the vehicle more frequently to check it.", "Park in the shade and leave the window slightly open."]'::jsonb,
    '["Pastikan kenderaan dikunci dan selamat sebelum meninggalkannya.", "Biarkan satu tingkap terbuka sedikit untuk pengudaraan.", "Kembali ke kenderaan dengan lebih kerap untuk memeriksanya.", "Letakkan kenderaan di tempat teduh dan biarkan tingkap terbuka sedikit."]'::jsonb,
    0,
    'Protecting the vehicle from theft takes priority over personal convenience.',
    'Melindungi kenderaan daripada risiko kecurian adalah lebih penting daripada keselesaan diri.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '52957be2-7d97-49c1-81c6-84925326fdd3',
    NULL,
    'During a delivery, your vehicle accidentally damages a customer''s property. There is no company requirement to take photographs for this situation.',
    'Semasa penghantaran, kenderaan anda secara tidak sengaja merosakkan harta pelanggan. Tiada keperluan syarikat untuk mengambil gambar bagi situasi ini.',
    '["Take clear photographs of all damages", "Report the incident without taking photographs", "Wait until someone asks for photographic evidence", "Leave the site once the incident has been reported"]'::jsonb,
    '["Ambil gambar yang jelas bagi semua kerosakan", "Laporkan kejadian tanpa mengambil gambar", "Tunggu sehingga seseorang meminta bukti bergambar", "Tinggalkan premis selepas kejadian dilaporkan"]'::jsonb,
    0,
    'Whenever goods, vehicles, customer property or third-party assets are damaged, take clear photographs immediately to preserve accurate evidence, even if it is not specifically required by the SOP.',
    'Ambil gambar dengan segera apabila berlaku sebarang kerosakan, walaupun tidak diwajibkan oleh SOP syarikat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1e310772-0deb-4e36-ae00-8f0afe80dfb3',
    NULL,
    'While entering a customer premises, you need to drive over a raised pavement to reach the loading area.',
    'Semasa memasuki premis pelanggan, anda perlu memandu melintasi pavemen untuk sampai ke kawasan pemunggahan.',
    '["Approach the pavement to ensure no underbody contact.", "Drive straight over the pavement at a slow speed.", "Increase speed slightly to clear the pavement quickly.", "Cross the pavement only after unloading the vehicle."]'::jsonb,
    '["Hampiri pavemen bagi memastikan bahagian bawah kenderaan tidak bergesel.", "Pandu terus melintasi pavemen pada kelajuan rendah.", "Tambah sedikit kelajuan supaya dapat melepasi pavemen dengan cepat.", "Lintasi pavemen hanya selepas kenderaan dipunggah."]'::jsonb,
    0,
    'Adapt your approach when crossing raised surfaces to reduce the risk of underbody damage.',
    'Laraskan cara anda menghampiri permukaan yang tinggi seperti pavemen bagi mengurangkan risiko kerosakan pada bahagian bawah kenderaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4d31121a-deba-4755-8628-195c17e29224',
    NULL,
    'Before leaving the vehicle unattended, you realise the rear cargo door has not been secured with the company padlock.',
    'Sebelum meninggalkan kenderaan tanpa pengawasan, anda mendapati pintu belakang ruang kargo belum dikunci menggunakan mangga syarikat.',
    '["Secure the rear cargo door with the padlock before leaving.", "Rely on the standard door lock for this delivery.", "Use the padlock only when carrying valuable cargo.", "Fit the padlock after returning to the vehicle."]'::jsonb,
    '["Kunci pintu belakang ruang kargo menggunakan mangga syarikat sebelum meninggalkan kenderaan.", "Gunakan kunci pintu biasa sahaja untuk penghantaran ini.", "Gunakan mangga hanya apabila membawa kargo yang bernilai tinggi.", "Pasang mangga selepas kembali ke kenderaan."]'::jsonb,
    0,
    'Use all required cargo door security measures before leaving the vehicle unattended.',
    'Gunakan semua langkah keselamatan yang ditetapkan untuk pintu ruang kargo sebelum meninggalkan kenderaan tanpa pengawasan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e0ed0721-ea00-439e-ba09-417151ecd825',
    NULL,
    'During your pre-trip check, you find the dashcam memory card is full.',
    'Semasa pemeriksaan pra-perjalanan anda, anda mendapati kad memori dashcam telah penuh.',
    '["Ensure the dashcam can record before starting the journey.", "Drive as planned and clear the memory card after work.", "Continue if the previous recordings are still available.", "Start the journey and rely on witness statements if an incident occurs."]'::jsonb,
    '["Pastikan dashcam boleh merakam sebelum memulakan perjalanan.", "Pandu seperti yang dirancang dan kosongkan kad memori selepas waktu kerja.", "Teruskan jika rakaman sebelum ini masih tersedia.", "Mulakan perjalanan dan bergantung pada kenyataan saksi jika berlaku insiden."]'::jsonb,
    0,
    'A functioning dashcam helps protect the driver and company by providing reliable evidence when needed.',
    'Dashcam yang berfungsi membantu melindungi pemandu dan Syarikat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd3b809e1-42d7-43cf-bfba-f99b887dbf92',
    NULL,
    'A customer asks you to deliver a parcel to the back of a shop instead of the registered delivery location.',
    'Seorang pelanggan meminta anda menghantar bungkusan ke bahagian belakang kedai dan bukannya ke lokasi penghantaran yang berdaftar.',
    '["Explain politely that deliveries can only be completed at the approved location.", "Complete the delivery at the requested location if the customer confirms ownership.", "Deliver the parcel to the back of the shop if it saves time.", "Leave the parcel at the requested location and update the delivery record."]'::jsonb,
    '["Terangkan dengan sopan penghantaran hanya boleh di lokasi yang diluluskan.", "Selesaikan penghantaran di lokasi yang diminta jika pelanggan mengesahkan pemilikan.", "Hantar bungkusan ke bahagian belakang kedai jika ia menjimatkan masa.", "Tinggalkan bungkusan di lokasi yang diminta dan kemas kini rekod penghantaran."]'::jsonb,
    0,
    'Follow approved delivery procedures even when customers request alternative arrangements.',
    'Patuhi prosedur penghantaran yang diluluskan walaupun pelanggan meminta aturan alternatif.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '02d6d16d-c951-4d6a-b14c-62c15f3b2cf3',
    NULL,
    'Before loading, you find loose straps, old nails and rubbish inside the cargo compartment.',
    'Sebelum loading, anda mendapati tali pengikat, paku lama dan sampah berselerak di dalam ruang kargo.',
    '["Remove the debris and clean the cargo compartment before loading", "Load the cargo first and clean the compartment afterwards", "Remove only the larger items that may obstruct loading", "Continue loading if the customer does not raise any concern"]'::jsonb,
    '["Buang semua sisa dan bersihkan ruang kargo sebelum loading", "Loading dahulu dan bersihkan ruang kargo selepas selesai", "Buang hanya barang yang besar dan menghalang loading", "Teruskan loading jika pelanggan tidak membangkitkan sebarang isu"]'::jsonb,
    0,
    'A clean cargo compartment protects the cargo from damage and demonstrates good operational housekeeping.',
    'Ruang kargo yang bersih melindungi muatan daripada kerosakan dan mencerminkan pengemasan operasi yang baik.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f8fedba5-c42d-4800-8bf7-a1267709fef8',
    NULL,
    'While checking a completed load, you notice most of the heaviest cargo has been placed at the rear.',
    'Semasa memeriksa muatan, anda mendapati kebanyakan barang paling berat diletakkan di bahagian belakang.',
    '["Move the heavy cargo forward and balance both sides", "Drive more slowly and brake more gently throughout the trip", "Add extra straps around the rear cargo before departure", "Leave the load unchanged because the weight limit is complied with"]'::jsonb,
    '["Alihkan barang berat ke hadapan dan seimbangkan kedua-dua belah", "Pandu lebih perlahan dan brek dengan lebih lembut sepanjang perjalanan", "Tambah tali pengikat pada muatan belakang sebelum bertolak", "Biarkan muatan kerana had berat masih dipatuhi"]'::jsonb,
    0,
    'Heavy cargo should be positioned low and towards the front, with the weight balanced from left to right.',
    'Barang berat perlu diletakkan di bawah dan ke hadapan, dengan berat seimbang di kedua-dua belah.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd576261a-7eed-42f8-b4cd-5d3139010d58',
    NULL,
    'You are loading food cartons together with chemical products.',
    'Anda sedang loading karton makanan bersama produk kimia.',
    '["Separate the food and chemical products during loading", "Load them together if both are properly labelled", "Place the food cartons above the chemical products", "Wrap the food cartons with plastic before loading"]'::jsonb,
    '["Asingkan makanan dan produk kimia semasa loading", "Loading bersama jika kedua-duanya mempunyai label yang betul", "Letakkan karton makanan di atas produk kimia", "Balut karton makanan dengan plastik sebelum loading"]'::jsonb,
    0,
    'Separate incompatible goods during loading to prevent contamination and cargo damage.',
    'Asingkan barang yang tidak serasi semasa loading bagi mengelakkan pencemaran dan kerosakan muatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '249b82b6-1404-4ca8-ba58-1a9002ecdd15',
    NULL,
    'While unloading, you discover damaged goods before handing it to the customer.',
    'Semasa unloading, anda mendapati barang rosak sebelum menyerahkannya kepada pelanggan.',
    '["Take a photo before reporting the damage", "Deliver the goods first and report it later", "Wait for the customer to discover the damage", "Separate the carton without recording it"]'::jsonb,
    '["Ambil gambar sebelum melaporkan kerosakan", "Serahkan barang terlebih dahulu dan laporkan kemudian", "Tunggu sehingga pelanggan menemui kerosakan tersebut", "Asingkan barang tanpa merekodkannya"]'::jsonb,
    0,
    'Record damage immediately to support accurate reporting.',
    'Rekodkan kerosakan dengan segera untuk tujuan pelaporan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    4,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5c7c1483-bb88-4367-9074-9d65f388714d',
    NULL,
    'Your goods vehicle is experiencing failure on a highway and there is no nearby exit.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan tiada susur keluar berhampiran.',
    '["Stop in the current lane and switch on hazard lights.", "Move the vehicle to the far left shoulder before stopping.", "Stop immediately and place warning devices behind the vehicle.", "Slow down and remain in the lane until assistance arrives."]'::jsonb,
    '["Berhenti di lorong semasa dan hidupkan lampu kecemasan.", "Gerakkan kenderaan ke bahu kiri paling luar sebelum berhenti.", "Berhenti serta-merta dan letakkan alat amaran di belakang kenderaan.", "Perlahankan kenderaan dan kekal di lorong sehingga bantuan tiba."]'::jsonb,
    1,
    'Move to a safer shoulder area to reduce exposure to traffic.',
    'Gerakkan kenderaan ke bahu jalan yang lebih selamat untuk mengurangkan risiko terdedah kepada trafik.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '60431d4b-4223-4426-ad68-4cd73de54b9d',
    NULL,
    'At a site with active loading operations, you step out of your vehicle in the loading area without a safety helmet.',
    'Di tapak dengan operasi pemuatan aktif, anda keluar dari kenderaan di kawasan pemuatan tanpa topi keselamatan.',
    '["Put on the required PPE and keep clear of loading", "Remain where you are and rely on loading personnel", "Move quickly through the area to reduce time", "Wait for instructions before addressing PPE"]'::jsonb,
    '["Pakai PPE yang diperlukan dan kekal jauh dari operasi pemuatan", "Kekal di tempat dan bergantung pada perkerja loading", "Bergerak cepat melalui kawasan itu untuk kurangkan masa", "Tunggu arahan dan kemudian pakai  PPE"]'::jsonb,
    0,
    'Wear required PPE and keep clear of loading zones.',
    'Pakai PPE yang diperlukan dan kekalkan jarak dari kawasan pemuatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '46ddb692-f57f-4404-8d09-19505a98574f',
    NULL,
    'During a delivery, a customer follows cultural practices unfamiliar to you.',
    'Semasa membuat penghantaran, seorang pelanggan mengikut amalan budaya yang tidak biasa bagi anda.',
    '["Acknowledge the practice and respond respectfully", "Continue the task without engaging further", "Question the practice to clarify expectations", "Follow your usual approach and proceed"]'::jsonb,
    '["Hormati amalan tersebut dan beri respons dengan sesuai", "Teruskan tugas tanpa melibatkan diri", "Persoalkan amalan itu untuk jelaskan jangkaan", "Ikut cara biasa anda dan teruskan"]'::jsonb,
    0,
    'Respecting cultural differences helps maintain positive and professional interactions.',
    'Menghormati perbezaan budaya membantu kekalkan interaksi yang profesional dan baik.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e77a1432-16e1-4791-b70c-1a9d11049b72',
    NULL,
    'After unloading in a public street, a nearby shop owner asks you to record a shorter stop time to avoid complaints.',
    'Selepas memunggah muatan di tepi jalan awam, seorang pemilik kedai meminta anda merekod masa berhenti yang lebih singkat untuk elakkan aduan.',
    '["Record the actual stop time and submit the document as required", "Shorten the recorded time since unloading is already completed", "Leave the timing unclear so it does not attract attention", "Explain the situation verbally and minimise what is written"]'::jsonb,
    '["Catat masa berhenti sebenar dan serahkan dokumen seperti dikehendaki", "Pendekkan masa yang direkod kerana proses memunggah sudah selesai", "Biarkan catatan masa tidak jelas supaya tidak menarik perhatian", "Jelaskan secara lisan dan kurangkan maklumat bertulis"]'::jsonb,
    0,
    'Accurate records uphold accountability, even when there is public pressure.',
    'Catatan yang tepat membantu kekalkan tanggungjawab walaupun ada tekanan dari luar.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd8a877fd-9a68-4bc5-a56e-d8be6db60e6c',
    NULL,
    'Before loading cargo, what should you verify?',
    'Sebelum kargo dimuatkan, apakah yang perlu anda sahkan?',
    '["Confirm the permitted load limit before loading.", "Load first and check weight later.", "Estimate weight based on experience.", "Accept the customer\u2019s estimate without verification."]'::jsonb,
    '["Sahkan had muatan yang dibenarkan sebelum memuatkan kargo.", "Muatkan terlebih dahulu dan periksa berat kemudian.", "Anggarkan berat berdasarkan pengalaman.", "Terima anggaran pelanggan tanpa pengesahan."]'::jsonb,
    0,
    'Confirm the permitted load limit before carrying cargo.',
    'Sahkan had muatan yang dibenarkan bagi kenderaan sebelum kargo dimuatkan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b43dc959-0945-4e2d-b02c-8ea788f4eb98',
    NULL,
    'After a delivery, you are stopped for inspection and asked to present your documents. One document was completed late but is accurate.',
    'Selepas penghantaran, anda ditahan untuk pemeriksaan dan diminta menunjukkan dokumen. Satu dokumen dilengkapkan lewat tetapi maklumatnya tepat.',
    '["Present the documents and clarify the late entry", "Hand over the documents without mentioning the late entry", "Say the document was completed earlier", "Offer to update the document later"]'::jsonb,
    '["Tunjukkan dokumen dan jelaskan tentang pengisian lewat", "Serahkan dokumen tanpa memaklumkan tentang kelewatan pengisian", "Nyatakan bahawa dokumen telah dilengkapkan lebih awal", "Tawarkan untuk mengemas kini dokumen kemudian"]'::jsonb,
    0,
    'Present accurate documents and clarify issues during inspections.',
    'Tunjukkan dokumen yang tepat dan jelaskan perkara berkaitan semasa pemeriksaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '588057c8-f25b-47ca-b87f-3dde8edfdc9a',
    NULL,
    'After a pre-trip inspection, the vehicle behaves differently once you begin moving.',
    'Selepas pemeriksaan sebelum perjalanan, kenderaan menunjukkan keadaan tidak biasa apabila anda mula bergerak.',
    '["Continue driving to see if it settles", "Stop safely and reassess the vehicle", "Adjust driving style to compensate", "Complete the trip and report later"]'::jsonb,
    '["Terus memandu untuk melihat sama ada keadaan kembali normal", "Berhenti dengan selamat dan periksa semula kenderaan", "Laraskan cara pemanduan untuk menyesuaikan keadaan", "Selesaikan perjalanan dan laporkan kemudian"]'::jsonb,
    1,
    'Vehicle behaviour should match inspection results.',
    'Jika kenderaan menunjukkan keadaan tidak biasa, berhenti dan periksa semula sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 1.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4c662580-972d-4433-822f-35dec8a2e561',
    NULL,
    'You slow early after spotting a hazard ahead. The driver behind reacts angrily and closes in.',
    'Anda memperlahankan kenderaan lebih awal selepas melihat bahaya di hadapan. Pemandu di belakang bertindak marah dan merapat.',
    '["Keep your speed steady and avoid engaging", "Speed up slightly to reduce pressure from behind", "Brake again to show there is a hazard ahead", "Gesture briefly to discourage the tailgating"]'::jsonb,
    '["Kekalkan kelajuan yang stabil dan elakkan memberi respons", "Tambah sedikit kelajuan untuk mengurangkan tekanan dari belakang", "Tekan brek sekali lagi untuk menunjukkan terdapat bahaya di hadapan", "Buat isyarat ringkas untuk menghalang tingkah laku tersebut"]'::jsonb,
    0,
    'Maintaining steady driving and avoiding engagement helps manage hazards without escalating conflict.',
    'Mengekalkan pemanduan yang stabil dan tidak bertindak balas membantu mengurus risiko tanpa menambahkan ketegangan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '03d30b98-d6e3-4875-a544-1aa693a7a857',
    NULL,
    'While driving at the posted speed, you see motorcycles filtering between lanes and uneven braking ahead.',
    'Anda memandu pada kelajuan dibenarkan. Motosikal bergerak di antara lorong dan brek tidak sekata berlaku di hadapan.',
    '["Maintain speed and brake if traffic slows suddenly", "Reduce speed early and increase following distance", "Change lanes to avoid slower traffic ahead", "Maintain speed and focus on the vehicle ahead"]'::jsonb,
    '["Kekalkan kelajuan dan brek jika trafik perlahan secara tiba-tiba", "Kurangkan kelajuan lebih awal dan tambah jarak kenderaan", "Tukar lorong untuk mengelakkan trafik perlahan", "Kekalkan kelajuan dan fokus pada kenderaan di hadapan"]'::jsonb,
    1,
    'Reduce speed early to create time and space for sudden road changes.',
    'Kurangkan kelajuan lebih awal untuk memberi masa dan ruang apabila keadaan jalan berubah.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd37695a6-284b-4293-b19b-31b173372d0e',
    NULL,
    'At a controlled checkpoint, valid credentials are required and one credential has expired.',
    'Di pusat pemeriksaan kawalan, kelayakan yang sah diperlukan dan satu kelayakan telah tamat tempoh.',
    '["Stop at the checkpoint and report the issue", "Proceed slowly and resolve it afterward", "Wait to see if access is granted without it", "Continue forward since monitoring appears light"]'::jsonb,
    '["Berhenti di pusat pemeriksaan dan laporkan masalah tersebut", "Terus bergerak perlahan dan selesaikan kemudian", "Tunggu untuk melihat sama ada akses dibenarkan tanpa kelayakan", "Terus bergerak kerana pemantauan kelihatan kurang ketat"]'::jsonb,
    0,
    'Stop and meet credential requirements before proceeding.',
    'Berhenti dan pastikan kelayakan dipenuhi sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '32eb23cf-a8ac-45df-b292-c76d3e03a0b1',
    NULL,
    'After loading at a site, procedure requires using a designated exit route.',
    'Selepas selesai memunggah keluar di tapak, prosedur memerlukan anda menggunakan laluan keluar yang ditetapkan.',
    '["Follow the designated exit route and site rules", "Take a shorter route since no traffic is visible", "Exit on the path that saves the most time", "Exit based on familiarity"]'::jsonb,
    '["Ikut laluan keluar dan peraturan pergerakan tapak", "Ambil laluan lebih pendek kerana tiada trafik kelihatan", "Ambil laluan keluar yang menjimatkan masa", "Keluar berdasarkan kebiasaan"]'::jsonb,
    0,
    'Follow site exit routes and movement rules.',
    'Ikut laluan keluar dan peraturan pergerakan tapak.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '270647bf-45f5-40b0-a8b2-f4bff970867d',
    NULL,
    'During unloading, site staff suggest recording different details on the delivery documents to save time.',
    'Semasa proses memunggah, kakitangan tapak mencadangkan supaya butiran pada dokumen penghantaran direkod berbeza untuk jimat masa.',
    '["Record the actual details accurately", "Adjust the details slightly so unloading can finish smoothly", "Note the change later to keep the paperwork acceptable", "Leave the documents for someone else to complete"]'::jsonb,
    '["Catat butiran yang sebenarnya dengan tepat", "Ubah sedikit butiran supaya proses memunggah selesai dengan lancar", "Catat perubahan kemudian supaya dokumen masih kelihatan boleh diterima", "Biarkan dokumen untuk disiapkan oleh orang lain"]'::jsonb,
    0,
    'Recording accurate details supports accountability and prevents issues later.',
    'Merekod butiran dengan tepat membantu pastikan tanggungjawab jelas dan elakkan masalah pada masa akan datang.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd271d99f-6c4c-42e9-997e-b036cb90f4d7',
    NULL,
    'During inspection, you realise the vehicle has no working torchlight.',
    'Semasa pemeriksaan, anda mendapati tiada lampu suluh yang berfungsi di dalam kenderaan.',
    '["Proceed if driving is during daytime only.", "Replace the torchlight before operating the vehicle.", "Use your phone light if needed.", "Continue since other safety items are present."]'::jsonb,
    '["Teruskan perjalanan jika pemanduan hanya pada waktu siang.", "Gantikan lampu suluh tersebut sebelum mengendalikan kenderaan.", "Gunakan lampu telefon bimbit jika perlu.", "Teruskan kerana peralatan keselamatan lain masih ada."]'::jsonb,
    1,
    'Ensure required safety equipment is present and functional.',
    'Pastikan peralatan keselamatan yang diperlukan tersedia dan berfungsi dengan baik.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd02342cb-6494-4526-b50a-b00cd6035dda',
    NULL,
    'As a driver, you must remain aware of the expiry and renewal dates of vehicle and operating documents.',
    'Sebagai seorang pemandu, anda perlu peka terhadap tarikh tamat tempoh dan pembaharuan dokumen kenderaan serta operasi.',
    '["Monitor the dates and arrange renewal before expiry.", "Wait for reminders from the office.", "Check the dates only during inspections.", "Rely on company personnel to identify expiry."]'::jsonb,
    '["Pantau tarikh tersebut dan uruskan pembaharuan sebelum tamat tempoh.", "Tunggu peringatan daripada pejabat.", "Semak tarikh hanya semasa pemeriksaan.", "Bergantung kepada pegawai syarikat untuk mengenal pasti tarikh tamat tempoh."]'::jsonb,
    0,
    'Be aware of expiry dates and renew documents before they lapse.',
    'Sentiasa peka terhadap tarikh tamat tempoh dan perbaharui dokumen sebelum tempoh sahnya berakhir.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd61afa6a-8c8a-458c-be7f-0442bf02b55f',
    NULL,
    'During pre-trip inspection, you discover a brake defect before departure.',
    'Semasa pemeriksaan pra-perjalanan, anda menemui masalah pada brek sebelum berlepas.',
    '["Proceed carefully and monitor the defect during the journey", "Delay reporting until after completing the delivery", "Report the defect immediately and follow required procedures", "Ignore the defect to avoid operational delays"]'::jsonb,
    '["Teruskan dengan berhati-hati dan pantau masalah sepanjang perjalanan", "Tangguhkan laporan sehingga penghantaran selesai", "Laporkan masalah segera dan ikut prosedur yang ditetapkan", "Abaikan masalah untuk elakkan kelewatan operasi"]'::jsonb,
    2,
    'Defects must be reported before departure to ensure safety and integrity.',
    'Masalah mesti dilaporkan sebelum berlepas untuk memastikan keselamatan dan integriti.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8933bbd6-6371-44bf-af93-77c80432ad34',
    NULL,
    'During a site discussion, you realise the conversation may be overheard or recorded.',
    'Semasa perbincangan di tapak, anda sedar perbualan mungkin didengar atau dirakam.',
    '["Speak carefully and keep the discussion professional", "Lower your voice and limit further discussion", "End the conversation and return to work", "Continue speaking as you normally would"]'::jsonb,
    '["Bercakap dengan berhati-hati dan kekalkan profesionalisme", "Rendahkan suara dan hadkan perbincangan", "Tamatkan perbualan dan kembali bekerja", "Terus bercakap seperti biasa"]'::jsonb,
    0,
    'Choosing words carefully helps protect your professional image in visible situations.',
    'Pilih kata dengan cermat untuk lindungi imej profesional di tempat umum.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f6249469-ce8e-471c-b16a-2e7cee2155a7',
    NULL,
    'You are loading cargo and the total weight is close to the vehicle’s permitted limit.',
    'Anda sedang memuatkan kargo dan jumlah beratnya hampir mencapai had yang dibenarkan untuk kenderaan.',
    '["Load slightly above the limit if the distance is short.", "Ensure the load remains within the permitted weight limit.", "Proceed since the excess weight is minimal.", "Accept the customer\u2019s weight figure without verification."]'::jsonb,
    '["Muatkan sedikit melebihi had jika jarak adalah dekat.", "Pastikan muatan kekal dalam had berat yang dibenarkan.", "Teruskan perjalanan kerana lebihan berat adalah kecil.", "Terima angka berat pelanggan tanpa pengesahan."]'::jsonb,
    1,
    'Always operate within the approved weight limit.',
    'Sentiasa pastikan kenderaan beroperasi dalam had berat yang diluluskan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8a0537be-756f-46fc-87e8-e9550aabf7c2',
    NULL,
    'Before starting your trip, you review the vehicle’s licensing documents.',
    'Sebelum memulakan perjalanan, anda menyemak dokumen lesen kenderaan.',
    '["Proceed if the documents were checked last month.", "Verify that all required vehicle licences are valid.", "Continue driving and check only if stopped.", "Rely on the office to monitor document validity."]'::jsonb,
    '["Teruskan perjalanan jika dokumen telah diperiksa bulan lepas.", "Pastikan semua lesen kenderaan yang diperlukan masih sah.", "Terus memandu dan semak hanya jika ditahan.", "Bergantung kepada pejabat untuk memantau tempoh sah dokumen."]'::jsonb,
    1,
    'Ensure vehicle licensing documents are valid before operating.',
    'Pastikan semua dokumen lesen kenderaan masih sah sebelum mengendalikan kenderaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ef9bf3ca-044c-49ca-9445-b841f41ec3e0',
    NULL,
    'You are scheduled to begin duty at 5:00 AM.',
    'Anda dijadualkan untuk memulakan tugas pada pukul 5:00 pagi.',
    '["Arrive early to prepare before starting duty.", "Arrive exactly at 5:00 AM and prepare afterward.", "Arrive a few minutes late if traffic is light.", "Inform colleagues to cover while you arrive."]'::jsonb,
    '["Tiba lebih awal untuk membuat persediaan sebelum bertugas.", "Tiba tepat pukul 5:00 pagi dan buat persediaan selepas itu.", "Tiba lewat beberapa minit jika trafik lancar.", "Maklumkan rakan sekerja untuk mengambil alih tugas sementara anda tiba."]'::jsonb,
    0,
    'Arrive early to prepare and start duty on time.',
    'Tiba lebih awal untuk membuat persediaan dan memulakan tugas tepat pada masanya.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5a330ea3-fdb2-4169-95e8-fe9eb1620cd9',
    NULL,
    'You need to reverse into a marked bay inside a site. Space is tight, visibility is limited, and vehicles move nearby.',
    'Anda perlu mengundur ke petak bertanda di dalam tapak. Ruang sempit, pandangan terhad, dan kenderaan bergerak berhampiran.',
    '["Stop and reverse only when visibility and clearance are confirmed", "Reverse slowly while checking mirrors and adjusting position", "Continue reversing to avoid delaying vehicles behind", "Reverse carefully and rely on others to keep clear"]'::jsonb,
    '["Berhenti dan undur hanya apabila pandangan dan ruang selamat dipastikan", "Undur perlahan sambil periksa cermin dan sesuaikan kedudukan", "Terus undur untuk elakkan melambatkan kenderaan di belakang", "Undur dengan berhati-hati dan harap orang lain menjauh"]'::jsonb,
    0,
    'Confirm visibility and clearance before reversing in confined areas.',
    'Pastikan pandangan dan ruang selamat sebelum mengundur di kawasan sempit.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ac5ed1cd-0d5e-46fc-88f7-8f3ed3381a4a',
    NULL,
    'During a rest stop, you notice rubbish and food containers inside the truck cabin.',
    'Semasa berhenti rehat, anda melihat sampah dan bekas makanan di dalam kabin lori.',
    '["Leave the cabin unchanged since cleanliness does not affect vehicle operation", "Clean the cabin later when the schedule is less demanding", "Clean and tidy the cabin immediately", "Remove only items that may interfere with driving controls"]'::jsonb,
    '["Biarkan kabin seperti itu kerana kebersihan tidak menjejaskan operasi kenderaan", "Bersihkan kabin kemudian apabila jadual kurang sibuk", "Bersihkan dan kemaskan kabin segera", "Buang hanya barang yang boleh mengganggu kawalan pemanduan"]'::jsonb,
    2,
    'Maintaining cabin cleanliness supports safe operation and professional standards.',
    'Menjaga kebersihan kabin menyokong operasi selamat dan mencerminkan profesionalisme.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a734afa7-5c45-412e-9cef-ac78b15a03e7',
    NULL,
    'Inside a site, you approach a junction where parked equipment limits turning space.',
    'Di dalam tapak, anda menghampiri simpang dan jentera parkir mengehadkan ruang membelok.',
    '["Continue forward and adjust steering during the turn", "Stop early and reposition for a wider, safer turn", "Follow the shortest path to clear the junction", "Move closer before deciding how to turn"]'::jsonb,
    '["Teruskan ke hadapan dan laras stereng semasa membelok", "Berhenti awal dan ubah posisi untuk belokan yang lebih luas dan selamat", "Ikut laluan paling pendek untuk lepasi simpang", "Bergerak lebih dekat sebelum tentukan cara membelok"]'::jsonb,
    1,
    'Early positioning inside sites prevents tight turns, damage, and unnecessary corrections.',
    'Posisi awal yang betul di dalam tapak membantu elakkan belokan sempit, kerosakan dan pembetulan yang tidak perlu.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd815c99d-563e-4ce3-aa63-15601286b3dc',
    NULL,
    'While driving, you notice the sun shade and stickers on the windscreen reduce your side visibility.',
    'Semasa memandu, anda mendapati pelindung matahari dan pelekat pada cermin hadapan mengurangkan penglihatan sisi.',
    '["Continue driving carefully despite reduced visibility.", "Stop at a safe location and remove or adjust the obstruction.", "Reduce speed and rely more on mirrors.", "Adjust your lane position to compensate for the blind area."]'::jsonb,
    '["Terus memandu dengan berhati-hati walaupun penglihatan terhad.", "Berhenti di lokasi yang selamat dan tanggalkan/laraskan halangan tersebut.", "Kurangkan kelajuan dan lebih bergantung pada cermin sisi.", "Laraskan kedudukan lorong untuk mengimbangi kawasan yang terhalang."]'::jsonb,
    1,
    'Ensure full visibility before continuing to drive safely.',
    'Pastikan penglihatan jelas sepenuhnya sebelum meneruskan pemanduan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2be1792a-9bba-4627-aa96-19a8becbe5ed',
    NULL,
    'Before leaving the loading point, you receive the delivery documents and the cargo has been loaded.',
    'Sebelum meninggalkan tempat loading, anda menerima dokumen penghantaran dan muatan telah siap dimuatkan.',
    '["Verify the DO number, PO number and quantity against the loaded cargo before departure", "Accept the documents as long as the warehouse confirms the loading is complete", "Check only the quantity because the document numbers are prepared by the warehouse", "Leave immediately to avoid delaying the delivery schedule"]'::jsonb,
    '["Semak nombor DO, nombor PO dan kuantiti dengan muatan sebelum bertolak", "Terima sahaja dokumen selagi pihak gudang mengesahkan loading telah selesai", "Semak kuantiti sahaja kerana nombor dokumen disediakan oleh pihak gudang", "Terus bertolak supaya jadual penghantaran tidak lewat"]'::jsonb,
    0,
    'Always verify the delivery documents against the loaded cargo before departure to prevent delivery errors.',
    'Sentiasa semak dokumen penghantaran dengan muatan sebelum bertolak bagi mengelakkan kesilapan penghantaran.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '38c7e62a-5347-4f00-944c-d4744692299c',
    NULL,
    'After finishing a cigarette at the designated smoking area, what should you do?',
    'Selepas menghabiskan rokok di kawasan merokok yang dibenarkan, apakah yang perlu anda lakukan?',
    '["Dispose of the cigarette butt in the proper bin", "Drop it on the ground if it is fully extinguished", "Throw it into a nearby drain", "Leave it in the parking area"]'::jsonb,
    '["Buang puntung rokok ke dalam tong sampah", "Buang di atas tanah jika api telah padam sepenuhnya", "Buang ke dalam longkang berhampiran", "Tinggalkan di kawasan parkir"]'::jsonb,
    0,
    'Keep customer premises clean and professional.',
    'Pastikan premis pelanggan sentiasa bersih dan profesional.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd6cd969d-477c-4b49-8b71-83c4a30db7f0',
    NULL,
    'Before departure, you find the load arrangement places excessive weight on the rear axle.',
    'Sebelum bergerak, anda mendapati susunan muatan menyebabkan beban berlebihan pada gandar belakang.',
    '["Correct the load distribution before starting the journey.", "Reduce the delivery load at the next customer location.", "Proceed if the tyres appear to support the load normally.", "Continue using a route with lower travelling speeds."]'::jsonb,
    '["Betulkan agihan muatan sebelum memulakan perjalanan.", "Kurangkan muatan penghantaran di lokasi pelanggan seterusnya.", "Teruskan jika tayar kelihatan masih mampu menampung muatan.", "Gunakan laluan yang membolehkan kelajuan lebih rendah."]'::jsonb,
    0,
    'Correct excessive axle loading before departure to comply with load distribution requirements and improve vehicle safety.',
    'Betulkan beban berlebihan pada gandar sebelum bergerak bagi mematuhi keperluan agihan muatan dan meningkatkan keselamatan kenderaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3784e9bd-2490-4a28-b78d-4e4a32d3fcb4',
    NULL,
    'You are making several short deliveries along the same street.',
    'Anda membuat beberapa penghantaran singkat di sepanjang jalan yang sama.',
    '["Secure the vehicle at every stop.", "Leave the engine running between nearby deliveries.", "Leave the key in the vehicle if you can see it from outside.", "Keep the engine running whenever the next stop is close."]'::jsonb,
    '["Pastikan kenderaan dikunci dan selamat pada setiap hentian.", "Biarkan enjin hidup antara lokasi penghantaran yang berdekatan.", "Tinggalkan kunci di dalam kenderaan jika anda masih dapat melihatnya dari luar.", "Biarkan enjin hidup setiap kali lokasi penghantaran seterusnya berdekatan."]'::jsonb,
    0,
    'Every unattended stop requires the vehicle to be properly secured, regardless of delivery distance.',
    'Setiap kali kenderaan ditinggalkan tanpa pengawasan, ia mesti dikunci dan diamankan dengan betul tanpa mengira jarak penghantaran.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2fd6593d-e7c2-4b9e-8c01-6fa0822ad7bc',
    NULL,
    'You need to leave a parcel at a customer''s doorstep because the recipient is unavailable.',
    'Anda perlu meninggalkan satu bungkusan di hadapan rumah pelanggan kerana penerima tiada.',
    '["Place the parcel on the hinge side of the door.", "Place the parcel directly in front of the door.", "Place the parcel where it is most visible to the customer.", "Place the parcel closest to the door handle."]'::jsonb,
    '["Letakkan bungkusan di bahagian engsel pintu.", "Letakkan bungkusan betul-betul di hadapan pintu.", "Letakkan bungkusan di tempat yang paling mudah dilihat oleh pelanggan.", "Letakkan bungkusan berhampiran pemegang pintu."]'::jsonb,
    0,
    'Place unattended parcels where they are less likely to be damaged when the door is opened.',
    'Letakkan bungkusan yang ditinggalkan tanpa pengawasan di bahagian engsel pintu supaya tidak rosak apabila pintu dibuka.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '27e7ab6b-dc17-4178-b625-9708e1910987',
    NULL,
    'You are assigned to deliver a 20 kg item to a fourth-floor unit without lift access during the hottest part of the day.',
    'Anda ditugaskan untuk menghantar barangan seberat 20 kg ke unit di tingkat empat tanpa akses lif ketika cuaca paling panas.',
    '["Stop and seek a safer delivery arrangement.", "Carry the item upstairs to avoid delaying the customer.", "Take a short rest after reaching each floor.", "Complete the delivery as quickly as possible."]'::jsonb,
    '["Berhenti dan dapatkan aturan penghantaran yang lebih selamat.", "Bawa barangan tersebut naik ke atas untuk mengelakkan kelewatan kepada pelanggan.", "Berehat sebentar selepas sampai di setiap tingkat.", "Selesaikan penghantaran secepat mungkin."]'::jsonb,
    0,
    'Choose a safer delivery method when manual handling conditions present a high risk of injury.',
    'Pilih kaedah penghantaran yang lebih selamat apabila keadaan pengendalian manual memberikan risiko kecederaan yang tinggi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ccb66233-e177-4458-ad0f-ba70b9d7b21b',
    NULL,
    'You are loading cartons of different weights onto the vehicle.',
    'Anda sedang loading karton dengan berat yang berbeza.',
    '["Place heavier cartons below lighter cartons", "Mix heavy and light cartons evenly throughout the load", "Place lighter cartons first to speed up loading", "Stack cartons according to their delivery sequence"]'::jsonb,
    '["Letakkan karton yang lebih berat di bawah dan yang lebih ringan di atas", "Campurkan karton berat dan ringan secara sama rata dalam muatan", "Letakkan karton ringan dahulu supaya loading lebih cepat", "Susun karton mengikut urutan penghantaran"]'::jsonb,
    0,
    'Stack heavier cartons at the bottom and lighter cartons on top to reduce the risk of crushing and maintain load stability.',
    'Susun karton berat di bawah dan karton ringan di atas bagi mengelakkan kerosakan serta mengekalkan kestabilan muatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'be54ebf9-4ce8-49f3-bdb6-71f40b1875fd',
    NULL,
    'After securing the cargo, you notice a large empty gap between the load and the sideboard.',
    'Selepas mengikat muatan, anda mendapati terdapat ruang kosong yang besar antara muatan dan papan sisi.',
    '["Fill the gap with suitable blocking material", "Tighten all the straps once again carefully", "Drive slowly and avoid sudden cornering", "Leave the gap because the load is legal"]'::jsonb,
    '["Isi ruang kosong dengan bahan penyekat yang sesuai", "Ketatkan semua ratchet strap sekali lagi", "Pandu perlahan dan elakkan mengambil selekoh secara mengejut", "Biarkan ruang kosong kerana muatan masih mematuhi peraturan"]'::jsonb,
    0,
    'Remove excessive gaps by using suitable blocking materials to minimise cargo movement during transport.',
    'Isi ruang kosong bagi mengurangkan pergerakan muatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '09230cfc-8b74-42b6-91c9-96a937d61046',
    NULL,
    'The customer rejects part of the delivery.',
    'Pelanggan menolak sebahagian daripada barangan penghantaran.',
    '["Ask the receiver to record the reason on the delivery order", "Accept the rejection and return the goods immediately", "Record the reason yourself after leaving the site", "Take back the goods without any written record"]'::jsonb,
    '["Minta penerima mencatatkan sebab penolakan pada delivery order", "Terima penolakan tersebut dan terus bawa balik barang", "Catatkan sendiri sebab penolakan selepas meninggalkan premis", "Bawa balik barang tanpa sebarang rekod bertulis"]'::jsonb,
    0,
    'Obtain written confirmation before returning rejected goods.',
    'Dapatkan pengesahan bertulis sebelum membawa balik barang yang ditolak.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '405a386a-48bd-4d27-b726-b6c288d78d2c',
    NULL,
    'A customer rejects some goods but says written confirmation is unnecessary.',
    'Pelanggan menolak sebahagian barang tetapi memaklumkan bahawa pengesahan bertulis tidak diperlukan.',
    '["Explain that the rejection must be recorded in the DO", "Return the goods based on the customer''s verbal instruction", "Ask the warehouse to decide after leaving the site", "Bring back the goods and complete the records later"]'::jsonb,
    '["Terangkan bahawa penolakan mesti direkodkan pada DO", "Bawa balik barang berdasarkan arahan lisan pelanggan", "Minta gudang membuat keputusan selepas meninggalkan premis", "Bawa balik barang dan lengkapkan rekod kemudian"]'::jsonb,
    0,
    'Ensure rejected goods are returned with honest and complete records.',
    'Pastikan barang yang ditolak dibawa balik dengan rekod yang lengkap dan jujur.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    5,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd5392818-c987-4b64-bcb9-8fcd7e01647d',
    NULL,
    'A colleague asks to ride in your cabin as a second driver for convenience.',
    'Seorang rakan sekerja meminta untuk menaiki kabin anda sebagai pemandu kedua atas alasan kemudahan.',
    '["Allow the ride if the journey is short.", "Decline unless company authorisation is given.", "Allow the ride if the colleague is an employee.", "Permit the ride if no customers are affected."]'::jsonb,
    '["Benarkan jika perjalanan adalah singkat.", "Tolak kecuali terdapat kebenaran daripada syarikat.", "Benarkan jika rakan tersebut ialah pekerja syarikat.", "Benarkan jika tiada pelanggan yang terjejas."]'::jsonb,
    1,
    'Do not carry passengers without proper company authorisation.',
    'Jangan membawa penumpang tanpa kebenaran rasmi daripada syarikat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a7c4f56e-882f-4e4d-9728-26539aebb51e',
    NULL,
    'After a road collision, what should you record first?',
    'Selepas berlaku pelanggaran jalan raya, apakah yang perlu anda catat terlebih dahulu?',
    '["The exact accident location.", "The damages", "The estimated repair cost.", "The traffic condition."]'::jsonb,
    '["Lokasi kemalangan yang tepat.", "Kerosakan yang berlaku.", "Anggaran kos pembaikan.", "Keadaan trafik."]'::jsonb,
    0,
    'Record the accident location accurately.',
    'Catat lokasi kemalangan dengan tepat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4b1d0c18-80a0-47aa-93e3-792d2dfb923e',
    NULL,
    'You approach a junction inside an industrial site. Internal lanes intersect and site rules require vehicles to yield.',
    'Anda menghampiri persimpangan di dalam kawasan industri. Laluan dalaman bersilang dan peraturan tapak memerlukan kenderaan memberi laluan.',
    '["Slow down and follow the site junction rule", "Roll forward and proceed when the path looks clear", "Edge into the junction to signal intention", "Enter if nearby vehicles move through safely"]'::jsonb,
    '["Perlahankan kenderaan dan ikut peraturan persimpangan tapak", "Bergerak perlahan dan masuk apabila laluan kelihatan jelas", "Masuk sedikit ke persimpangan untuk memberi isyarat niat", "Masuk jika kenderaan berhampiran kelihatan melalui dengan selamat"]'::jsonb,
    0,
    'Apply site junction rules to prevent conflicts at internal intersections.',
    'Perlahankan kenderaan dan patuhi peraturan persimpangan tapak untuk mengelakkan konflik di persimpangan dalaman.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b6e430a8-d419-4d8b-a14a-941d1a6967ff',
    NULL,
    'While preparing for delivery, you notice the cargo is not fully secured and the customer is waiting.',
    'Semasa bersedia untuk penghantaran, anda mendapati muatan tidak dikunci dengan sempurna dan pelanggan sedang menunggu.',
    '["Pause and secure the cargo before proceeding", "Continue carefully and address it afterward", "Proceed to avoid delay and handle carefully", "Proceed while explaining the situation to the customer"]'::jsonb,
    '["Berhenti seketika dan pastikan muatan dikunci dengan betul sebelum meneruskan", "Teruskan dengan berhati-hati dan selesaikan isu kemudian", "Teruskan untuk mengelakkan kelewatan dan kendalikan dengan berhati-hati", "Teruskan sambil menerangkan keadaan kepada pelanggan"]'::jsonb,
    0,
    'Secure cargo before delivery despite time pressure.',
    'Pastikan muatan selamat sebelum meneruskan penghantaran walaupun terdapat tekanan masa.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e54b698d-a536-4fa4-9c18-27b2c5af165a',
    NULL,
    'While reversing slowly inside a site, you notice steering response feels abnormal.',
    'Semasa mengundur perlahan di dalam tapak, anda merasakan tindak balas stereng tidak normal.',
    '["Continue reversing carefully to clear the area", "Stop the manoeuvre and assess the defect", "Complete the reverse and report afterward", "Reduce speed further and keep moving"]'::jsonb,
    '["Terus mengundur dengan berhati-hati untuk lepasi kawasan itu", "Hentikan manuver dan periksa keadaan", "Selesaikan undur dan laporkan selepas itu", "Kurangkan lagi kelajuan dan teruskan bergerak"]'::jsonb,
    1,
    'Stopping immediately when a defect is felt during manoeuvres prevents damage and injury.',
    'Hentikan kenderaan apabila terasa tanda tidak normal semasa manuver untuk elakkan kerosakan dan kecederaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd9fc1652-adf5-4f27-b535-70dc8c00acc0',
    NULL,
    'You have completed a delivery at a customer site.',
    'Anda telah menyelesaikan penghantaran di tapak pelanggan.',
    '["Obtain the receiver\u2019s signature only.", "Obtain signature, company stamp, time received, and receiver\u2019s name.", "Take a photo of the unloaded goods as proof.", "Record the delivery details after returning to the office."]'::jsonb,
    '["Dapatkan tandatangan penerima sahaja.", "Dapatkan tandatangan, cap syarikat, masa terima dan nama penerima.", "Ambil gambar barang yang telah diturunkan sebagai bukti.", "Rekodkan butiran penghantaran selepas kembali ke pejabat."]'::jsonb,
    1,
    'Ensure full and proper customer confirmation for every delivery.',
    'Pastikan pengesahan penerimaan lengkap bagi setiap penghantaran.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2b256e7b-48b3-419f-90bb-58437582d169',
    NULL,
    'During initial reporting, what should you do if additional relevant details arise?',
    'Semasa laporan awal dibuat, apakah yang perlu anda lakukan jika terdapat maklumat tambahan yang berkaitan?',
    '["Share any information that supports the initial report.", "Limit information to basic facts only.", "Provide extra details only if requested later.", "Wait until writing a formal report."]'::jsonb,
    '["Kongsikan maklumat yang menyokong laporan awal.", "Hadkan maklumat kepada fakta asas sahaja.", "Berikan butiran tambahan hanya jika diminta kemudian.", "Tunggu sehingga menyediakan laporan rasmi."]'::jsonb,
    0,
    'Provide all relevant information for the initial response.',
    'Berikan semua maklumat yang berkaitan untuk tindakan awal yang tepat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4563c57e-e8ee-4b4c-835b-31e869b93829',
    NULL,
    'You approach a narrow access point inside a facility. Visibility is limited and vehicles may enter from the opposite direction.',
    'Anda menghampiri laluan masuk sempit di dalam fasiliti. Pandangan terhad dan kenderaan mungkin masuk dari arah bertentangan.',
    '["Slow early and wait until the access path is clear", "Continue forward cautiously and adjust if a vehicle appears", "Enter the access point to hold position", "Follow the vehicle ahead through the access"]'::jsonb,
    '["Perlahankan kenderaan lebih awal dan tunggu sehingga laluan benar-benar jelas", "Terus bergerak dengan berhati-hati dan sesuaikan jika kenderaan muncul", "Masuk ke laluan untuk menunggu", "Ikut kenderaan di hadapan melalui laluan"]'::jsonb,
    0,
    'Slow early and confirm the path is clear before entering.',
    'Perlahankan kenderaan lebih awal dan pastikan laluan jelas sebelum masuk.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3519313e-01cb-4fc6-b5c4-a51f87a4a649',
    NULL,
    'At a checkpoint, you are asked to present documents and notice the delivery time was recorded inaccurately.',
    'Di tempat pemeriksaan, anda diminta menunjukkan dokumen dan menyedari masa penghantaran direkod tidak tepat.',
    '["Present the document and clarify the timing if asked", "Hand over the document without mentioning the timing", "Explain verbally that the details are correct", "Ask for time to update the document before presenting it"]'::jsonb,
    '["Serahkan dokumen dan jelaskan masa jika ditanya", "Serahkan dokumen tanpa menyebut tentang masa", "Jelaskan secara lisan bahawa butiran adalah betul", "Minta masa untuk mengemas kini dokumen sebelum menyerahkannya"]'::jsonb,
    3,
    'Accurate documents and cooperation support smooth inspections.',
    'Dokumen yang tepat dan kerjasama membantu pemeriksaan berjalan lancar.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '32414249-6ff5-4538-afdf-2d3330383f48',
    NULL,
    'While manoeuvring at low speed in a confined space, you notice resistance and a faint scraping sound.',
    'Semasa membuat manuver pada kelajuan rendah di ruang sempit, anda merasakan rintangan dan bunyi geseran ringan.',
    '["Stop and reassess clearance before continuing", "Proceed slowly and rely on steering to clear the space", "Apply more throttle to finish quickly", "Continue and inspect the vehicle after the manoeuvre"]'::jsonb,
    '["Berhenti dan semak semula ruang sebelum meneruskan", "Terus bergerak perlahan dan bergantung pada stereng", "Tekan minyak lebih untuk menyelesaikan manuver dengan cepat", "Teruskan dan periksa kenderaan selepas manuver selesai"]'::jsonb,
    0,
    'Stop when unusual resistance or sounds occur.',
    'Berhenti apabila terdapat rintangan atau bunyi tidak biasa.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2c1cf9fc-4e14-47f7-b99f-70c41c3ec765',
    NULL,
    'Before departure, you identify a cargo safety concern while another party pressures you to move immediately.',
    'Sebelum berlepas, anda mengenal pasti isu keselamatan muatan sementara pihak lain mendesak anda bergerak segera.',
    '["Proceed carefully to avoid further discussion", "Address the safety concern and explain the delay calmly", "Agree to move briefly to reduce tension", "Remain silent and delay action"]'::jsonb,
    '["Teruskan dengan berhati-hati untuk elakkan perbincangan lanjut", "Tangani isu keselamatan muatan dan jelaskan kelewatan dengan tenang", "Setuju bergerak seketika untuk mengurangkan ketegangan", "Berdiam diri dan tangguhkan tindakan"]'::jsonb,
    1,
    'Address safety concerns first while responding calmly to others.',
    'Utamakan keselamatan sambil bertindak balas dengan tenang kepada pihak lain.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '86182bd1-a14d-4f78-b5b4-0175baf4b0d9',
    NULL,
    'While moving on a wet, uneven surface, you notice abnormal vibration and reduced vehicle response.',
    'Semasa bergerak di permukaan basah dan tidak rata, anda merasakan getaran tidak normal dan tindak balas kenderaan berkurang.',
    '["Maintain steady movement to avoid wheel slip", "Stop and assess before continuing", "Adjust speed slightly and continue through the area", "Complete the movement and report the issue later"]'::jsonb,
    '["Kekalkan pergerakan stabil untuk elakkan gelinciran tayar", "Berhenti dan periksa sebelum meneruskan", "Laraskan kelajuan sedikit dan teruskan melalui kawasan itu", "Selesaikan pergerakan dan laporkan masalah kemudian"]'::jsonb,
    1,
    'Pause to assess mechanical signals under challenging surface conditions.',
    'Berhenti dan periksa isu mekanikal dalam keadaan permukaan yang mencabar.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b60cb981-69df-41d7-b3c2-9fdc0e3e8577',
    NULL,
    'A colleague suggests you keep quiet about a major issue to avoid attention from management.',
    'Seorang rakan sekerja mencadangkan  supaya anda berdiam diri tentang satu isu besar untuk elakkan perhatian pihak pengurusan.',
    '["Explain clearly why the issue should be reported", "Agree to stay quiet to keep things smooth", "Avoid responding and let the matter pass", "Say little and continue with your work"]'::jsonb,
    '["Jelaskan dengan terang mengapa isu itu perlu dilaporkan", "Setuju untuk berdiam diri supaya keadaan kekal tenang", "Elakkan memberi respons dan biarkan perkara itu berlalu", "Kurangkan bercakap dan teruskan kerja anda"]'::jsonb,
    0,
    'Clear communication and honesty help prevent larger problems later.',
    'Komunikasi yang jelas dan jujur membantu elakkan masalah menjadi lebih besar.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'cd5176b6-9601-435c-9b2c-80fcc399bdc3',
    NULL,
    'After a road accident, the Emergency Response Team contacts you.',
    'Selepas kemalangan jalan raya, Pasukan Tindak Balas Kecemasan menghubungi anda.',
    '["Provide clear details of what happened, time, location, and vehicles involved.", "Inform them only that an accident occurred.", "Ask them to obtain details from witnesses.", "Provide information after returning to depot."]'::jsonb,
    '["Berikan maklumat jelas tentang apa yang berlaku, masa, lokasi dan kenderaan yang terlibat.", "Maklumkan bahawa kemalangan telah berlaku sahaja.", "Minta mereka mendapatkan maklumat daripada saksi.", "Berikan maklumat selepas kembali ke depot."]'::jsonb,
    0,
    'Provide clear and accurate accident details immediately.',
    'Berikan maklumat kemalangan yang jelas dan tepat dengan segera.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '236b035b-d75f-4732-9d56-914e1cbb78b4',
    NULL,
    'You are reversing toward a loading bay when the loading supervisor signals you to stop because workers are still nearby.',
    'Anda sedang mengundur ke petak loading apabila penyelia loading memberi isyarat supaya berhenti kerana masih ada pekerja berhampiran.',
    '["Stop immediately and wait for the supervisor''s signal before continuing.", "Continue reversing slowly because the workers can move aside.", "Ask the workers to clear the area while continuing to reverse.", "Ignore the supervisor''s signal because your mirrors show the path is clear."]'::jsonb,
    '["Berhenti serta-merta dan tunggu isyarat penyelia sebelum meneruskan.", "Terus mengundur perlahan kerana pekerja boleh beredar.", "Minta pekerja beredar sambil terus mengundur.", "Abaikan isyarat penyelia kerana laluan kelihatan jelas melalui cermin."]'::jsonb,
    0,
    'Stop manoeuvring when instructed and continue only after receiving a clear signal that it is safe.',
    'Berhenti apabila diarahkan dan teruskan hanya selepas penyelia memberi isyarat bahawa keadaan selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0c909f86-be1a-4f55-ac9f-553bfae2408d',
    NULL,
    'While driving through a community area, people nearby gesture for you to slow down as you pass.',
    'Semasa melalui kawasan komuniti, orang di sekitar memberi isyarat supaya anda memperlahankan kenderaan.',
    '["Reduce speed and continue driving considerately", "Maintain your speed since you are within the limit", "Slow briefly, then resume your previous speed", "Focus ahead and avoid reacting to the gestures"]'::jsonb,
    '["Kurangkan kelajuan dan teruskan pemanduan dengan penuh pertimbangan", "Kekalkan kelajuan kerana masih dalam had yang dibenarkan", "Perlahankan seketika, kemudian sambung semula kelajuan asal", "Fokus ke hadapan dan abaikan isyarat tersebut"]'::jsonb,
    0,
    'Adjusting speed in response to community signals shows courtesy and respect for local conditions.',
    'Melaras kelajuan mengikut keadaan setempat menunjukkan sikap hormat dan prihatin terhadap komuniti.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '37db8aab-01a4-4955-8e43-97aaf660da4e',
    NULL,
    'Your goods vehicle is experiencing failure on a highway and assistance has arrived.',
    'Kenderaan barangan anda mengalami kerosakan di lebuh raya dan bantuan telah tiba.',
    '["Leave the vehicle where it stopped since help is present.", "Move the vehicle to a safer location when possible.", "Wait until traffic reduces before relocating.", "Relocate only if other drivers signal it is safe."]'::jsonb,
    '["Biarkan kenderaan di tempat ia berhenti kerana bantuan telah tiba.", "Alihkan kenderaan ke lokasi yang lebih selamat jika keadaan mengizinkan.", "Tunggu sehingga trafik berkurangan sebelum mengalihkan kenderaan.", "Alihkan hanya jika pemandu lain memberi isyarat selamat."]'::jsonb,
    1,
    'Relocate the vehicle to minimise continued traffic exposure.',
    'Alihkan kenderaan ke lokasi lebih selamat untuk mengurangkan pendedahan berterusan kepada trafik.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '747866ba-cdf4-4470-acf1-fcdf21a6886c',
    NULL,
    'While driving inside a site with pedestrians and equipment moving nearby, your phone receives a message.',
    'Semasa memandu di dalam tapak dengan pekerja dan jentera bergerak berhampiran, telefon anda menerima mesej.',
    '["Ignore the message and maintain full attention", "Check the message briefly since speed is low", "Slow down and glance when the area looks clear", "Respond quickly."]'::jsonb,
    '["Abaikan mesej dan kekalkan tumpuan penuh", "Periksa mesej seketika kerana kelajuan rendah", "Perlahankan dan lihat mesej apabila kawasan kelihatan selamat", "Balas mesej dengan cepat."]'::jsonb,
    0,
    'Avoid distractions in mixed-movement areas.',
    'Elakkan gangguan di kawasan pergerakan bercampur.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '11865285-3239-44b5-aa01-c81a7dc9ec9a',
    NULL,
    'You drive at cruising speed. Vehicles ahead brake intermittently and motorcycles filter between lanes.',
    'Anda memandu pada kelajuan tetap. Kenderaan di hadapan membrek dan motosikal bergerak di antara lorong.',
    '["Increase following distance for sudden slowing", "Maintain distance and brake if traffic slows", "Move closer to match the pace ahead", "Change lanes to avoid unpredictable movement"]'::jsonb,
    '["Tambah jarak kenderaan untuk lebih bersedia", "Kekalkan jarak dan brek jika trafik perlahan", "Bergerak lebih dekat untuk ikut kelajuan di hadapan", "Tukar lorong untuk elakkan pergerakan tidak menentu"]'::jsonb,
    0,
    'Extra space gives more time to respond to hazards ahead.',
    'Ruang tambahan memberi lebih masa untuk bertindak terhadap bahaya di hadapan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '67b86cb1-9d67-46de-bf7f-4972bef1c542',
    NULL,
    'While driving, your phone receives a message and you are slightly above the speed limit.',
    'Semasa memandu, telefon anda menerima mesej dan anda memandu sedikit melebihi had laju.',
    '["Slow to the legal speed and ignore the message", "Maintain speed and quickly check the message", "Reduce speed slightly and read when traffic allows", "Keep speed steady and reply briefly"]'::jsonb,
    '["Kurangkan kelajuan ke had yang dibenarkan dan abaikan mesej tersebut", "Kekalkan kelajuan dan periksa mesej dengan cepat", "Kurangkan sedikit kelajuan dan baca apabila keadaan sesuai", "Kekalkan kelajuan dan balas mesej secara ringkas"]'::jsonb,
    0,
    'Follow speed limits and avoid device use while driving.',
    'Patuhi had laju dan elakkan penggunaan telefon semasa memandu.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6b054682-cb19-4325-b4d6-e22ab7c179df',
    NULL,
    'After a trip, you identify a minor defect before completing the handover documentation.',
    'Selepas tamat perjalanan, anda mengesan kerosakan kecil sebelum melengkapkan dokumentasi serahan kenderaan.',
    '["Record the defect accurately and submit the documentation", "Submit the documentation first and update the defect record later", "Delay recording the defect until the next scheduled inspection", "Note the defect informally and proceed with documentation"]'::jsonb,
    '["Rekodkan kerosakan dengan tepat dan serahkan dokumentasi", "Serahkan dokumentasi dahulu dan kemas kini rekod kerosakan kemudian", "Tangguhkan merekod kerosakan sehingga pemeriksaan seterusnya", "Catat kerosakan secara tidak rasmi dan teruskan dokumentasi"]'::jsonb,
    0,
    'Defects must be formally recorded to ensure proper documentation and accountability.',
    'kerosakan mesti direkod secara rasmi untuk memastikan dokumentasi dan akauntabiliti yang betul.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.75, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '641d0c35-7f76-48df-8497-432e123992f6',
    NULL,
    'The reflective string delineators are damaged and no longer reflective.',
    'Tali delineator reflektif rosak dan tidak lagi memantulkan cahaya.',
    '["Continue if cones are available.", "Replace them with compliant reflective delineators.", "Use hazard lights instead.", "Keep them until the next inspection cycle."]'::jsonb,
    '["Teruskan perjalanan jika kon keselamatan tersedia.", "Gantikan dengan delineator reflektif yang mematuhi spesifikasi.", "Gunakan lampu kecemasan sebagai ganti.", "Kekalkan penggunaannya sehingga pemeriksaan seterusnya."]'::jsonb,
    1,
    'Maintain compliant reflective equipment for roadside safety.',
    'Pastikan peralatan reflektif yang mematuhi spesifikasi sentiasa tersedia untuk keselamatan di tepi jalan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '112bcbd2-8c31-4428-9cef-d5761fb79a4b',
    NULL,
    'While parked at a public roadside stop, your engine is running near pedestrians and nearby premises.',
    'Semasa parkir di tepi jalan awam, enjin kenderaan masih hidup berhampiran pejalan kaki dan premis berdekatan.',
    '["Keep the engine running to maintain cabin comfort", "Shut down the engine while parked", "Keep the engine running and remain inside the vehicle", "Leave the engine running briefly before moving off"]'::jsonb,
    '["Biarkan enjin hidup untuk keselesaan kabin", "Matikan enjin semasa parkir", "Biarkan enjin hidup dan kekal di dalam kenderaan", "Biarkan enjin hidup seketika sebelum bergerak"]'::jsonb,
    1,
    'Shutting down the engine when parked protects company assets and shows respect for the public.',
    'Mematikan enjin semasa parkir melindungi aset syarikat dan menunjukkan hormat kepada orang awam.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ac1d4748-3f38-403c-983b-dac611097806',
    NULL,
    'Before leaving the vehicle, you notice a company mobile phone has been left in plain view.',
    'Sebelum meninggalkan kenderaan, anda mendapati telefon bimbit syarikat diletakkan di tempat yang mudah dilihat.',
    '["Store the phone out of sight before leaving the vehicle.", "Leave it where it is if the stop will be brief.", "Cover it with delivery documents before locking the vehicle.", "Take the phone only if the delivery location appears busy."]'::jsonb,
    '["Simpan telefon di tempat yang tidak kelihatan sebelum meninggalkan kenderaan.", "Biarkan telefon di situ jika berhenti hanya seketika.", "Tutup telefon dengan dokumen penghantaran sebelum mengunci kenderaan.", "Bawa telefon hanya jika lokasi penghantaran kelihatan sibuk."]'::jsonb,
    0,
    'Keep valuable items out of sight to reduce the risk of opportunistic theft.',
    'Simpan barang berharga di tempat yang tidak mudah dilihat bagi mengurangkan risiko kecurian secara oportunis.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1ba1c905-1799-465d-a32c-da32219ad20f',
    NULL,
    'You need to smoke while waiting for loading instructions.',
    'Anda perlu merokok sementara menunggu arahan loading.',
    '["Smoke at the designated smoking area", "Smoke beside the lorry if loading has not started", "Smoke near the dock and discard the butt afterwards", "Leave the premises briefly and throw the cigarette butt near the entrance"]'::jsonb,
    '["Merokok di kawasan merokok yang dibenarkan", "Merokok di sebelah lori jika loading belum bermula", "Merokok berhampiran dock dan buang puntung rokok selepas itu", "Keluar sebentar dari premis dan buang puntung rokok berhampiran pintu masuk"]'::jsonb,
    0,
    'Follow site rules and maintain professional conduct on customer premises.',
    'Patuhi peraturan premis dan sentiasa bersikap profesional.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '874e2282-1a40-417f-82ce-6e6a91aa81c2',
    NULL,
    'While loading, you notice several heavy boxes have been stacked on top of lighter cartons.',
    'Semasa kargo sedang dimuatkan, anda mendapati beberapa kotak berat diletakkan di atas kotak yang lebih ringan.',
    '["Rearrange the load so heavier boxes are placed at the bottom", "Secure the stacked boxes with extra straps before departure", "Leave the load as arranged if it fits within the cargo area", "Drive more carefully to reduce the effect of load movement"]'::jsonb,
    '["Susun semula muatan supaya kotak berat diletakkan di bahagian bawah", "Ikat susunan kotak dengan tali tambahan sebelum bergerak", "Biarkan susunan muatan seperti sedia ada jika masih muat dalam ruang kargo", "Pandu dengan lebih berhati-hati untuk mengurangkan kesan pergerakan muatan"]'::jsonb,
    0,
    'Arrange heavier cargo at the bottom to improve load stability and reduce the risk of load movement or vehicle instability during transport.',
    'Susun kargo yang lebih berat di bahagian bawah untuk meningkatkan kestabilan muatan dan mengurangkan risiko pergerakan muatan atau ketidakstabilan kenderaan semasa perjalanan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '58d954bb-21fd-4019-835d-8bff3de7f23c',
    NULL,
    'You are about to make a delivery when you realise the rear cargo door is secured only with the standard lock.',
    'Anda hendak membuat penghantaran apabila mendapati pintu belakang ruang kargo hanya dikunci menggunakan kunci biasa.',
    '["Secure the door with the company padlock before leaving.", "Continue if the delivery will only take a few minutes.", "Park where the rear doors are less visible.", "Ask a colleague to watch the vehicle while you deliver."]'::jsonb,
    '["Kunci pintu menggunakan mangga syarikat sebelum meninggalkan kenderaan.", "Teruskan jika penghantaran hanya mengambil masa beberapa minit.", "Letakkan kenderaan di tempat yang pintu belakangnya kurang kelihatan.", "Minta rakan mengawasi kenderaan semasa anda membuat penghantaran."]'::jsonb,
    0,
    'Additional cargo door security helps reduce the risk of opportunistic theft.',
    'Penggunaan mangga tambahan pada pintu ruang kargo membantu mengurangkan risiko kecurian secara oportunis.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8fb8df0f-ea5a-471b-af9f-4959985ff9dd',
    NULL,
    'You are leaving a parcel at a customer''s doorstep and need to choose the safest placement.',
    'Anda meninggalkan satu bungkusan di hadapan rumah pelanggan dan perlu memilih lokasi yang paling selamat untuk meletakkannya.',
    '["Position the parcel where opening the door is least likely to disturb it.", "Place the parcel directly in front of the entrance for easy visibility.", "Place the parcel nearest to the door handle for convenient collection.", "Place the parcel against the door so it cannot be seen from outside."]'::jsonb,
    '["Letakkan bungkusan di tempat yang tidak akan terganggu apabila pintu dibuka.", "Letakkan bungkusan betul-betul di hadapan pintu supaya mudah dilihat.", "Letakkan bungkusan berhampiran pemegang pintu supaya mudah diambil.", "Letakkan bungkusan rapat pada pintu supaya tidak dapat dilihat dari luar."]'::jsonb,
    0,
    'Choose a placement that reduces the risk of the parcel being knocked over or damaged when the door is opened.',
    'Pilih lokasi yang mengurangkan risiko bungkusan terlanggar atau rosak apabila pintu dibuka.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6d4ae59e-38b5-4439-9c0c-f3817c72498f',
    NULL,
    'After driving continuously for a long time, you stop at your destination.',
    'Selepas memandu secara berterusan dalam tempoh yang lama, anda berhenti di destinasi.',
    '["Let the engine idle briefly before shutting it down.", "Switch off the engine immediately to reduce fuel consumption.", "Rev the engine once before switching it off.", "Keep the engine running until unloading is completed."]'::jsonb,
    '["Biarkan enjin melahu seketika sebelum dimatikan.", "Matikan enjin serta-merta untuk menjimatkan bahan api.", "Tekan pedal minyak sekali sebelum mematikan enjin.", "Biarkan enjin terus hidup sehingga selesai memunggah."]'::jsonb,
    0,
    'A short cooling period after a long drive helps reduce unnecessary wear on the turbocharger.',
    'Tempoh melahu yang singkat selepas perjalanan yang jauh membantu mengurangkan kehausan yang tidak perlu pada pengecas turbo.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ca9ca079-a4c5-4481-9867-1f2ac5db21f4',
    NULL,
    'You are parking the vehicle overnight in an area where fuel theft has occurred previously.',
    'Anda parking kenderaan semalaman di kawasan yang pernah berlaku kes curi minyak sebelum ini.',
    '["Park the vehicle so the fuel tank is difficult to access.", "Park in the nearest available space for convenience.", "Leave the vehicle where it is easiest to leave the next morning.", "Park under a streetlight without considering fuel tank access."]'::jsonb,
    '["Parking kenderaan supaya tangki minyak susah untuk dicapai.", "Parking di tempat paling dekat semata-mata untuk kemudahan.", "Biarkan kenderaan di tempat yang paling senang untuk keluar pagi esok.", "Parking di bawah lampu jalan tanpa mengambil kira akses tangki minyak."]'::jsonb,
    0,
    'Park the vehicle in a way that reduces opportunities for fuel theft and protects company assets.',
    'Parking kenderaan dengan cara yang mengurangkan peluang curi minyak dan melindungi aset syarikat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'efdc863b-62ca-4188-87d5-b2bc34609d75',
    NULL,
    'You arrive at a delivery location and discover there is no lift to an upper-floor unit for a heavy item.',
    'Anda tiba di lokasi penghantaran dan mendapati tiada lif ke unit di tingkat atas untuk barangan berat.',
    '["Reassess the task before starting the delivery.", "Carry the item upstairs if the customer is waiting.", "Make several short rests while carrying the item.", "Complete the delivery alone if the distance is not far."]'::jsonb,
    '["Nilai semula tugasan sebelum memulakan penghantaran.", "Bawa barangan tersebut naik ke atas jika pelanggan sedang menunggu.", "Berehat beberapa kali sebentar semasa membawa barangan tersebut.", "Selesaikan penghantaran secara bersendirian jika jaraknya tidak jauh."]'::jsonb,
    0,
    'Stop and reassess the task whenever the delivery cannot be completed safely using the planned method.',
    'Berhenti dan nilai semula tugasan sekiranya penghantaran tidak dapat diselesaikan dengan selamat menggunakan kaedah yang dirancang.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '98c5e175-33af-4123-8773-1b94ff694108',
    NULL,
    'During unloading, a small amount of liquid spill occurs on the customer''s floor.',
    'Semasa unloading, berlaku tumpahan cecair kecil di lantai premis pelanggan.',
    '["Use the spill kit immediately and follow the site''s spill procedure", "Wait for warehouse staff before taking any action", "Finish unloading before cleaning the spill", "Cover the spill with cardboard and continue working"]'::jsonb,
    '["Gunakan spill kit dengan segera dan ikut prosedur tumpahan premis", "Tunggu kakitangan gudang sebelum mengambil sebarang tindakan", "Selesaikan unloading sebelum membersihkan tumpahan", "Tutup tumpahan dengan kadbod dan teruskan kerja"]'::jsonb,
    0,
    'Contain spills promptly and comply with the customer''s site procedures.',
    'Kawal tumpahan dengan segera dan patuhi prosedur premis pelanggan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4de7c0b2-b200-47d5-9ef4-96a0c2313d8d',
    NULL,
    'You notice damage to the goods during delivery.',
    'Anda menyedari terdapat kerosakan pada barang semasa penghantaran.',
    '["Take photographs before handling the goods", "Continue unloading and photograph them later", "Report the damage without taking photographs", "Wait until the customer requests photographs"]'::jsonb,
    '["Ambil gambar sebelum mengendalikan barang", "Teruskan unloading dan ambil gambar kemudian", "Laporkan kerosakan tanpa mengambil gambar", "Tunggu sehingga pelanggan meminta gambar"]'::jsonb,
    0,
    'Photographs taken immediately provide reliable evidence of the condition before any changes occur.',
    'Ambil gambar dengan segera sebagai bukti sebelum keadaan berubah.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    6,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1ef4ca31-feca-482c-bfea-e28f82b91a64',
    NULL,
    'You are preparing for duty.',
    'Anda sedang membuat persediaan untuk bertugas.',
    '["Wear a collared shirt before reporting for duty.", "Wear any casual T-shirt as long as it is clean.", "Wear a sleeveless shirt in hot weather.", "Change only if instructed by a supervisor."]'::jsonb,
    '["Pakai baju berkolar sebelum melapor diri untuk bertugas.", "Pakai mana-mana baju T kasual asalkan bersih.", "Pakai baju tanpa lengan ketika cuaca panas.", "Tukar pakaian hanya jika diarahkan oleh penyelia."]'::jsonb,
    0,
    'Wear proper collared attire as required for duty.',
    'Pakai pakaian berkolar yang sesuai seperti yang ditetapkan semasa bertugas.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e7f1b4a3-57ee-42b9-8896-9ba20b5ad7ad',
    NULL,
    'After completing your assignment, you are returning the vehicle.',
    'Selepas menamatkan tugasan, anda hendak memulangkan kenderaan.',
    '["Park the truck at any available space nearby.", "Park the truck at the company\u2019s designated area.", "Leave the truck where it is most convenient.", "Park outside temporarily and inform later."]'::jsonb,
    '["Parkir lori di mana-mana ruang yang tersedia berhampiran.", "Parkir lori di kawasan yang ditetapkan oleh syarikat.", "Tinggalkan lori di tempat yang paling mudah.", "Parkir di luar buat sementara dan maklumkan kemudian."]'::jsonb,
    1,
    'Park company vehicles only at approved locations.',
    'Parkir kenderaan syarikat hanya di lokasi yang diluluskan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e9fa63bb-3d6a-4d5b-85ce-258003771bac',
    NULL,
    'You are driving through a residential area where pedestrians are present and traffic is light.',
    'Anda memandu melalui kawasan perumahan dengan kehadiran pejalan kaki dan trafik yang ringan.',
    '["Maintain an appropriate speed and remain mindful of people nearby", "Drive slightly faster to clear the area quickly", "Match the flow of traffic and continue as usual", "Focus on the road ahead and avoid reacting to bystanders"]'::jsonb,
    '["Kekalkan kelajuan yang sesuai dan peka terhadap orang di sekeliling", "Pandu sedikit lebih laju untuk keluar dari kawasan itu dengan cepat", "Ikut aliran trafik dan teruskan seperti biasa", "Fokus ke hadapan dan abaikan pergerakan orang di tepi jalan"]'::jsonb,
    0,
    'Reducing speed in residential areas shows consideration for pedestrian safety.',
    'Mengurangkan kelajuan di kawasan perumahan menunjukkan keprihatinan terhadap keselamatan pejalan kaki.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0b24c736-376c-4fec-a740-646d41ec0427',
    NULL,
    'You merge from a slip road onto a busy highway. Vehicles ahead brake unevenly and motorcycles pass between lanes.',
    'Anda memasuki lebuh raya dari laluan masuk. Kenderaan di hadapan membrek tidak sekata dan motosikal bergerak di antara lorong.',
    '["Wait for a clearly safe gap before merging", "Merge and adjust speed once on the highway", "Use the gap quickly before traffic closes", "Move forward to signal intent and merge when traffic slows"]'::jsonb,
    '["Tunggu jarak/ruang yang benar-benar selamat sebelum masuk", "Masuk dahulu dan ubah kelajuan di lebuh raya", "Gunakan ruang  dengan cepat sebelum trafik menjadi padat/sesak", "Bergerak ke hadapan untuk beri isyarat niat dan masuk apabila trafik perlahan"]'::jsonb,
    0,
    'Choose a safe gap to avoid sudden braking and conflict during merging.',
    'Pilih jarak yang selamat untuk mengelakkan brek mengejut dan konflik semasa masuk ke lebuh raya.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0a60390c-d2a8-4071-bba6-cf40e1b3eee2',
    NULL,
    'At a site entrance, valid driving credentials are required. One required credential has expired.',
    'Di pintu masuk tapak, kelayakan memandu yang sah diperlukan. Satu kelayakan telah tamat tempoh.',
    '["Stop the entry process and report the issue", "Complete the safety induction and resolve it later", "Proceed since rules will be explained during induction", "Wait to see if access is granted"]'::jsonb,
    '["Hentikan proses masuk dan laporkan masalah tersebut", "Selesaikan taklimat keselamatan dan uruskan kemudian", "Teruskan masuk kerana peraturan akan diterangkan semasa taklimat", "Tunggu untuk melihat sama ada akses dibenarkan"]'::jsonb,
    0,
    'Valid credentials are required before site entry.',
    'Kelayakan yang sah diperlukan sebelum memasuki tapak.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '28d0e871-bc38-4250-ac56-e254a0396cd1',
    NULL,
    'While waiting inside a confined site area, the vehicle is idling near structures and pedestrians.',
    'Semasa menunggu di kawasan tapak yang sempit, enjin masih hidup berhampiran struktur dan pejalan kaki.',
    '["Keep the engine idling so you can move off quickly", "Switch off the engine while waiting", "Keep idling until instructed to move", "Remain stationary with the engine running"]'::jsonb,
    '["Biarkan enjin hidup supaya boleh bergerak segera", "Matikan enjin semasa menunggu", "Terus biarkan enjin hidup sehingga diarahkan bergerak", "Kekal berhenti dengan enjin masih hidup"]'::jsonb,
    1,
    'Switching off the engine when stationary reduces risk and unnecessary exposure in confined areas.',
    'Matikan enjin semasa berhenti untuk kurangkan risiko dan pendedahan',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'de012285-7f52-455a-ad8f-6eedbbf6caae',
    NULL,
    'During a delivery discussion, someone becomes upset after you refuse an improper request.',
    'Semasa perbincangan penghantaran, seseorang menjadi tidak puas hati selepas anda menolak permintaan yang tidak sesuai.',
    '["Restate your position calmly and keep the discussion respectful", "Explain in detail why the request is wrong and unacceptable", "End the discussion abruptly to avoid further disagreement", "Respond firmly to make it clear the matter is closed"]'::jsonb,
    '["Nyatakan semula pendirian anda dengan tenang dan kekalkan perbincangan secara hormat", "Terangkan dengan terperinci mengapa permintaan itu salah dan tidak boleh diterima", "Tamatkan perbincangan secara mendadak untuk elak pertelingkahan lanjut", "Beri respons dengan tegas supaya jelas perkara itu telah selesai"]'::jsonb,
    0,
    'Holding your position calmly helps resolve issues without escalating conflict.',
    'Kekalkan pendirian dengan tenang untuk selesaikan isu tanpa meningkatkan ketegangan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3a6f2f23-3bf2-46ae-b8ff-78410c2e3aee',
    NULL,
    'A driver behind you flashes headlights repeatedly and gestures, appearing impatient with your speed.',
    'Seorang pemandu di belakang anda berulang kali memberi lampu tinggi dan membuat isyarat, kelihatan tidak sabar dengan kelajuan anda.',
    '["Keep your speed steady and avoid responding to the behaviour", "Speed up slightly so the situation does not turn into an argument", "Change lanes when possible to prevent further confrontation", "React briefly to signal you have noticed the other driver"]'::jsonb,
    '["Kekalkan kelajuan secara konsisten dan elakkan memberi respons", "Tambah sedikit kelajuan supaya keadaan tidak menjadi tegang", "Tukar lorong apabila selamat untuk mengelakkan konfrontasi", "Beri respons ringkas untuk menunjukkan anda sedar akan kehadirannya"]'::jsonb,
    0,
    'Maintaining steady driving and not reacting helps prevent conflicts from escalating.',
    'Pemanduan yang stabil dan tidak bertindak balas membantu mengelakkan situasi daripada menjadi tegang.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b77d49f6-8ef3-4557-9e23-87e54f9840ee',
    NULL,
    'Your vehicle is due for scheduled maintenance according to the company/manufacturer’s manual.',
    'Kenderaan anda telah tiba masa menjalani penyelenggaraan berjadual mengikut manual syarikat atau pengeluar.',
    '["Continue operating since the vehicle is running smoothly.", "Follow the scheduled maintenance requirement.", "Postpone the service until the next trip cycle.", "Wait for further confirmation before arranging service."]'::jsonb,
    '["Terus beroperasi kerana kenderaan masih berfungsi dengan baik.", "Patuhi keperluan penyelenggaraan berjadual.", "Tangguhkan servis sehingga kitaran perjalanan seterusnya.", "Tunggu pengesahan lanjut sebelum mengaturkan servis."]'::jsonb,
    1,
    'Follow the company/manufacturer’s maintenance schedule as required.',
    'Patuhi jadual penyelenggaraan yang ditetapkan oleh syarikat atau pengeluar.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6018cfc4-279e-48ee-8132-74712ad63ad7',
    NULL,
    'During inspection, you notice the fire extinguisher has passed its expiry date.',
    'Semasa pemeriksaan, anda mendapati alat pemadam api telah melepasi tarikh luput.',
    '["Keep using it since it has not been discharged.", "Replace it with a compliant 9kg extinguisher within validity.", "Replace it with a compliant 6kg extinguisher within validity.", "Replace it with a compliant 5.5kg extinguisher within validity."]'::jsonb,
    '["Terus gunakan kerana ia belum pernah digunakan.", "Gantikan dengan alat pemadam api 9kg yang mematuhi spesifikasi dan masih dalam tempoh sah.", "Gantikan dengan alat pemadam api 6kg yang mematuhi spesifikasi dan masih dalam tempoh  sah.", "Gantikan dengan alat pemadam api 5.5kg yang mematuhi spesifikasi dan masih dalam tempoh  sah."]'::jsonb,
    1,
    'Ensure the required fire extinguisher meets the approved specification and validity.',
    'Pastikan alat pemadam api yang diperlukan mematuhi spesifikasi dan tempoh sah yang ditetapkan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2a5d211f-0af5-4870-a839-21e6f4633a65',
    NULL,
    'You arrive at a delivery location and notice the address differs from the delivery note.',
    'Anda tiba di lokasi penghantaran dan mendapati alamat berbeza daripada yang tertera pada nota penghantaran.',
    '["Deliver to the new address if the customer confirms verbally.", "Contact operations for confirmation before proceeding.", "Deliver if the location is nearby.", "Leave the goods with the person present at the site."]'::jsonb,
    '["Hantar ke alamat baharu jika pelanggan mengesahkan secara lisan.", "Hubungi bahagian operasi untuk pengesahan sebelum meneruskan penghantaran.", "Hantar jika lokasi berhampiran.", "Tinggalkan barang kepada individu yang berada di tapak."]'::jsonb,
    1,
    'Verify address changes with operations before delivery.',
    'Sahkan sebarang perubahan alamat dengan bahagian operasi sebelum membuat penghantaran.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a51884ed-d071-485d-a533-1720ef6fad9b',
    NULL,
    'You approach a busy junction. Traffic slows and visibility is partly blocked by surrounding vehicles.',
    'Anda menghampiri persimpangan yang sibuk. Trafik perlahan dan sebahagian pandangan terhalang oleh kenderaan sekeliling.',
    '["Reduce speed early and prepare to stop", "Maintain speed and brake only if needed", "Slow slightly and move when the vehicle ahead moves", "Keep moving to clear the junction quickly"]'::jsonb,
    '["Kurangkan kelajuan lebih awal dan bersedia untuk berhenti", "Kekalkan kelajuan dan brek hanya jika perlu", "Perlahankan sedikit dan bergerak apabila kenderaan di hadapan bergerak", "Terus bergerak untuk melepasi persimpangan dengan cepat"]'::jsonb,
    0,
    'Reduce speed before junctions to respond safely to unexpected movement.',
    'Kurangkan kelajuan sebelum persimpangan untuk bertindak balas dengan selamat terhadap pergerakan mengejut.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '2f3cb7b2-2c5b-4781-93dd-a87196bea5e5',
    NULL,
    'After a delivery, you park in a designated area where idling is prohibited.',
    'Selepas penghantaran, anda parkir di kawasan yang ditetapkan di mana enjin tidak dibenarkan hidup.',
    '["Switch off the engine and follow the parking procedure", "Leave the engine running briefly to save time", "Complete the procedure and address the engine later", "Wait in the vehicle with the engine on"]'::jsonb,
    '["Matikan enjin dan ikut prosedur parkir", "Biarkan enjin hidup seketika untuk menjimatkan masa", "Lengkapkan prosedur dahulu dan matikan enjin kemudian", "Tunggu di dalam kenderaan dengan enjin masih hidup"]'::jsonb,
    0,
    'Follow procedures and switch off the engine where idling is prohibited.',
    'Ikut prosedur dan matikan enjin di kawasan yang melarang melahu enjin.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f2f900aa-a2fc-44e3-9d1d-a46bbf54edc3',
    NULL,
    'While waiting in an active loading zone, you notice cargo movement that may affect load stability.',
    'Semasa menunggu di zon pemuatan aktif, anda melihat pergerakan muatan yang boleh menjejaskan kestabilan muatan.',
    '["Remain in position and allow loading to continue", "Stop the process and alert site staff to address the cargo risk", "Move the vehicle slightly to reduce exposure", "Monitor the situation and proceed once loading appears stable"]'::jsonb,
    '["Kekal di tempat dan biarkan proses pemuatan diteruskan", "Hentikan proses dan maklumkan kakitangan tapak tentang risiko muatan", "Gerakkan kenderaan sedikit untuk mengurangkan pendedahan", "Pantau keadaan dan teruskan apabila pemuatan kelihatan stabil"]'::jsonb,
    1,
    'Address cargo instability promptly to prevent incidents in loading areas.',
    'Tangani ketidakstabilan muatan dengan segera untuk mengelakkan insiden di kawasan pemuatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '13e324bf-803b-4be4-a44e-3b3869355d15',
    NULL,
    'A staff member at the delivery premise hints that a small personal favour could speed up your delivery process.',
    'Seorang pekerja ditempat pelanggan mencadangkan bantuan peribadi kecil boleh mempercepatkan proses penghantaran.',
    '["Decline politely and follow standard procedures", "Accept the request to maintain good customer relations", "Delay the decision and see how the situation develops", "Refer the matter to another driver on site"]'::jsonb,
    '["Tolak dengan sopan dan ikut prosedur biasa", "Terima permintaan itu untuk jaga hubungan pelanggan", "Tangguhkan keputusan dan lihat perkembangan keadaan", "Rujuk perkara itu kepada pemandu lain di tapak"]'::jsonb,
    0,
    'Following standard procedures protects fairness and avoids improper influence.',
    'Mengikut prosedur yang sah membantu kekalkan keadilan dan elakkan pengaruh yang tidak wajar.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '1320550c-dcaa-44f8-ab41-203b71e566be',
    NULL,
    'Feeling unusually tired due to insufficient rest, you are about to enter a site with narrow internal lanes.',
    'Anda berasa amat letih kerana kurang rehat dan akan memasuki tapak dengan laluan dalaman sempit.',
    '["Delay site entry to take a short rest", "Enter carefully and rely on slow speed", "Proceed since the site is familiar", "Enter and take breaks after the manoeuvre"]'::jsonb,
    '["Tangguhkan kemasukan ke tapak untuk berehat seketika", "Masuk dengan berhati-hati dan bergantung pada kelajuan rendah", "Teruskan kerana tapak tersebut sudah biasa", "Masuk dan berehat selepas selesai manuver"]'::jsonb,
    0,
    'Address fatigue before entering confined areas.',
    'Atasi keletihan sebelum memasuki kawasan sempit.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a88530ae-8c43-49f2-bee4-96a474d78a42',
    NULL,
    'After a collision, the third party offers to settle repair costs privately.',
    'Selepas pelanggaran, pihak ketiga menawarkan untuk menyelesaikan kos pembaikan secara persendirian.',
    '["Accept the offer to avoid paperwork.", "Inform operations and wait for instruction.", "Negotiate and settle on the spot.", "Accept payment and continue duty."]'::jsonb,
    '["Terima tawaran untuk mengelakkan urusan dokumentasi.", "Maklumkan bahagian operasi dan tunggu arahan selanjutnya.", "Berunding dan selesaikan di tempat kejadian.", "Terima bayaran dan teruskan tugas."]'::jsonb,
    1,
    'Do not agree to private settlements without company instruction.',
    'Jangan bersetuju dengan penyelesaian persendirian tanpa arahan syarikat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e61a87a1-a49a-4620-b901-d1c7ccbb2fa4',
    NULL,
    'You are holding your lane in slow traffic when another driver begins tailgating and sounding the horn.',
    'Anda mengekalkan lorong dalam trafik perlahan apabila pemandu di belakang mula mengekori rapat dan membunyikan hon.',
    '["Maintain your lane position and avoid reacting to the behaviour", "Shift position slightly to signal cooperation and reduce tension", "Change lanes quickly to get away from the situation", "Gesture briefly to show you have noticed the other driver"]'::jsonb,
    '["Kekalkan kedudukan lorong dan elakkan memberi respons", "Ubah sedikit kedudukan untuk menunjukkan kerjasama dan mengurangkan ketegangan", "Tukar lorong dengan cepat untuk menjauhkan diri daripada situasi", "Buat isyarat ringkas untuk menunjukkan anda sedar akan kehadirannya"]'::jsonb,
    0,
    'Holding lane discipline and not reacting helps prevent aggressive situations from escalating.',
    'Mengekalkan disiplin lorong dan tidak bertindak balas membantu mengelakkan situasi agresif daripada menjadi lebih tegang.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'd605c046-5acd-4e9f-8c83-40ceca4c564c',
    NULL,
    'In a local area, another driver gestures courteously for you to merge while traffic slows.',
    'Di kawasan tempatan, seorang pemandu memberi isyarat sopan untuk membenarkan anda masuk ketika trafik semakin perlahan.',
    '["Signal clearly and merge when safe", "Merge promptly to return the courtesy", "Hesitate briefly to avoid appearing disrespectful", "Acknowledge the gesture and continue moving"]'::jsonb,
    '["Beri isyarat dengan jelas dan masuk apabila selamat", "Masuk segera untuk membalas kesopanan tersebut", "Tangguh seketika supaya tidak kelihatan tidak menghormati", "Balas isyarat tersebut dan teruskan bergerak"]'::jsonb,
    0,
    'Clear signalling should guide merging decisions, even when courtesy is shown by others.',
    'Isyarat yang jelas dan pertimbangan keselamatan perlu menjadi panduan walaupun diberi laluan oleh pemandu lain.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '19a6d417-107e-4739-9a4f-90ddacd099f2',
    NULL,
    'A fire on your vehicle becomes large and difficult to control.',
    'Kebakaran pada kenderaan anda menjadi besar dan sukar dikawal.',
    '["Contact the fire brigade immediately.", "Continue using the extinguisher repeatedly.", "Wait for operations to arrive first.", "Move the vehicle slightly before deciding."]'::jsonb,
    '["Hubungi pasukan bomba dengan segera.", "Terus gunakan alat pemadam api berulang kali.", "Tunggu bahagian operasi tiba dahulu.", "Gerakkan kendaraan sedikit sebelum membuat keputusan."]'::jsonb,
    0,
    'Contact fire brigade when the fire escalates.',
    'Hubungi bomba apabila kebakaran menjadi besar dan tidak terkawal.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f80808cb-7425-4580-8f77-867cff9b97f7',
    NULL,
    'While waiting inside a site, an emergency alarm sounds and vehicles are directed to clear the area.',
    'Semasa menunggu di dalam tapak, penggera kecemasan berbunyi dan kenderaan diarahkan mengosongkan kawasan.',
    '["Follow evacuation instructions.", "Keep the engine running and leave quickly", "Wait for clarification before acting", "Continue idling until site personnel approach"]'::jsonb,
    '["Ikut arahan pemindahan", "Kekalkan enjin hidup dan keluar dengan cepat", "Tunggu penjelasan lanjut sebelum bertindak", "Terus hidupkan enjin sehingga kakitangan tapak datang"]'::jsonb,
    0,
    'Follow evacuation instructions and manage the vehicle safely.',
    'Ikut arahan pemindahan dan kendalikan kenderaan dengan selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ef77556d-6c5c-4685-a743-86a7d772b90e',
    NULL,
    'While driving, you notice unusual vibration and a new mechanical noise from the vehicle.',
    'Semasa memandu, anda merasakan getaran tidak normal dan bunyi mekanikal baharu daripada kenderaan.',
    '["Continue driving and observe if the noise disappears", "Stop safely and report the issue clearly to the supervisor", "Reduce speed and complete the trip as planned", "Mention the issue during the next scheduled check"]'::jsonb,
    '["Teruskan memandu dan lihat sama ada bunyi itu hilang", "Berhenti di tempat selamat dan laporkan masalah kepada penyelia", "Kurangkan kelajuan dan teruskan perjalanan seperti dirancang", "Nyatakan masalah semasa pemeriksaan seterusnya"]'::jsonb,
    1,
    'Early detection and clear reporting help prevent minor issues from becoming safety risks.',
    'Pengesanan awal dan laporan yang jelas membantu mengelakkan masalah kecil menjadi risiko keselamatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5f45cd90-475a-4acc-9b66-5668e87477af',
    NULL,
    'At a site checkpoint, you notice a vehicle defect just before being cleared to proceed.',
    'Di checkpoint tapak, anda perasan ada kerosakan pada kenderaan sejurus sebelum dibenarkan bergerak.',
    '["Proceed through the checkpoint and report the defect afterwards", "Stop at the checkpoint and report the defect immediately", "Move past the checkpoint and assess the defect", "Request guidance while remaining in the queue"]'::jsonb,
    '["Terus melepasi checkpoint dan laporkan kerosakan kemudian", "Berhenti di checkpoint dan laporkan kerosakan segera", "Lepasi checkpoint dan periksa kerosakan", "Minta panduan sambil kekal dalam barisan"]'::jsonb,
    1,
    'Reporting defects at checkpoints prevents unsafe entry into controlled zones.',
    'Laporkan kerosakan sebelum bergerak untuk elakkan risiko semasa masuk atau keluar kawasan terkawal.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'eaba366b-0e57-4a78-a6da-9393b1515283',
    NULL,
    'Before leaving the vehicle overnight, you realise the locking fuel cap has been left unlocked.',
    'Sebelum meninggalkan kenderaan semalaman, anda sedar bahawa penutup tangki minyak yang berkunci tidak dikunci.',
    '["Lock the fuel cap before leaving the vehicle.", "Leave it unlocked if the fuel tank is almost empty.", "Lock it only when parking in unfamiliar areas.", "Check the fuel cap the following morning before departure."]'::jsonb,
    '["Kunci penutup tangki minyak sebelum meninggalkan kenderaan.", "Biarkan tidak berkunci jika tangki minyak hampir kosong.", "Kunci hanya apabila parking di kawasan yang tidak dikenali.", "Periksa penutup tangki minyak pada pagi esok sebelum bertolak."]'::jsonb,
    0,
    'Lock the fuel cap before leaving the vehicle to reduce the risk of fuel theft.',
    'Kunci penutup tangki minyak sebelum meninggalkan kenderaan bagi mengurangkan risiko curi minyak.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'f8b254ca-f93a-4f16-9f03-2d59e4b02198',
    NULL,
    'Heavy traffic means you expect to arrive more than 15 minutes after your scheduled unloading appointment.',
    'Kesesakan lalu lintas menyebabkan anda dijangka tiba lebih 15 minit lewat daripada waktu temujanji unloading.',
    '["Inform the site controller of the expected delay and follow further instructions", "Continue to the factory without notifying anyone", "Wait nearby until another unloading slot becomes available before contacting the site", "Request immediate unloading upon arrival regardless of the appointment schedule"]'::jsonb,
    '["Maklumkan kepada penyelaras tapak tentang kelewatan dan ikut arahan seterusnya", "Terus ke kilang tanpa memaklumkan sesiapa", "Tunggu berhampiran sehingga ada slot unloading sebelum menghubungi pihak tapak", "Minta unloading dilakukan serta-merta sebaik tiba tanpa mengira jadual temujanji"]'::jsonb,
    0,
    'Communicating delays promptly helps the site manage unloading appointments safely and efficiently.',
    'Maklumkan kelewatan secepat mungkin supaya pihak tapak dapat mengurus jadual unloading dengan selamat dan lancar.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3c176825-3b9e-448c-9a15-4f77fe07a930',
    NULL,
    'While checking, you notice only the top layer of cartons has been secured with a ratchet strap.',
    'Semasa membuat pemeriksaan, anda mendapati hanya lapisan paling atas kotak telah diikat menggunakan tali ratchet.',
    '["Secure every load layer before departure.", "Tighten the top strap because it supports the entire load.", "Drive more smoothly to reduce movement between the cartons.", "Check the load again after completing the first delivery."]'::jsonb,
    '["Pastikan setiap lapisan muatan diikat sebelum bergerak.", "Ketatkan tali pengikat bahagian atas kerana ia menyokong keseluruhan muatan.", "Pandu dengan lebih lancar untuk mengurangkan pergerakan antara kotak.", "Periksa semula muatan selepas selesai penghantaran pertama."]'::jsonb,
    0,
    'Secure each load layer properly before departure to reduce cargo movement and prevent load displacement during sudden braking.',
    'Pastikan setiap lapisan muatan diikat dengan betul sebelum bergerak bagi mengurangkan pergerakan kargo dan mengelakkan muatan beralih semasa membrek secara mengejut.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7432a4fb-cb89-4930-96bd-f15e98f44f54',
    NULL,
    'Before leaving the loading area, you find the door has not fully engaged after being closed.',
    'Sebelum meninggalkan kawasan pemuatan, anda mendapati pintu tidak terkunci sepenuhnya selepas ditutup.',
    '["Confirm the door is fully secured before departure.", "Drive carefully and check the door at the next stop.", "Secure the cargo with extra straps before leaving.", "Reduce speed to minimise vibration during the journey."]'::jsonb,
    '["Pastikan pintu ditutup dan dikunci sepenuhnya sebelum bergerak.", "Pandu dengan berhati-hati dan periksa pintu di hentian seterusnya.", "Ikat muatan dengan tali tambahan sebelum bergerak.", "Kurangkan kelajuan untuk mengurangkan gegaran semasa perjalanan."]'::jsonb,
    0,
    'Ensure cargo doors are fully secured before departure to prevent load loss during transport.',
    'Pastikan pintu ruang kargo ditutup dan dikunci sepenuhnya sebelum bergerak bagi mengelakkan kehilangan muatan semasa perjalanan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c4af316a-0b20-43a9-a9cf-2a04d08bc89e',
    NULL,
    'Before entering a delivery location, you notice a low overhead awning that appears close to the height of your vehicle.',
    'Sebelum memasuki lokasi penghantaran, anda mendapati sebuah bumbung rendah kelihatan hampir menyamai ketinggian kenderaan anda.',
    '["Stop and confirm there is sufficient clearance before proceeding.", "Drive through slowly if the awning appears high enough.", "Continue if similar vehicles have entered the area before.", "Ask the customer after parking whether the vehicle can pass safely."]'::jsonb,
    '["Berhenti dan pastikan ruang kelegaan mencukupi sebelum meneruskan perjalanan.", "Pandu perlahan jika bumbung kelihatan cukup tinggi.", "Teruskan jika kenderaan lain yang serupa pernah memasuki kawasan tersebut.", "Tanya pelanggan selepas meletakkan kenderaan sama ada laluan itu selamat untuk dilalui."]'::jsonb,
    0,
    'Check overhead clearance before entering areas with height restrictions to prevent vehicle and property damage.',
    'Periksa ruang kelegaan di bahagian atas sebelum memasuki kawasan yang mempunyai had ketinggian bagi mengelakkan kerosakan pada kenderaan dan harta benda.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '4bc8c5ef-b64d-4ade-9cb3-115d2d5674bb',
    NULL,
    'After collecting a cash-on-delivery (COD) payment, you are preparing to continue your delivery route.',
    'Selepas menerima bayaran tunai semasa penghantaran (COD), anda bersedia untuk meneruskan laluan penghantaran.',
    '["Keep the cash and vehicle keys separately.", "Keep the cash and vehicle keys together for easier access.", "Keep the cash with your delivery documents.", "Keep the cash and vehicle keys together until returning to the depot."]'::jsonb,
    '["Simpan wang tunai dan kunci kenderaan secara berasingan.", "Simpan wang tunai dan kunci kenderaan bersama supaya lebih mudah dicapai.", "Simpan wang tunai bersama dokumen penghantaran.", "Simpan wang tunai dan kunci kenderaan bersama sehingga kembali ke depot."]'::jsonb,
    0,
    'Separating cash from vehicle keys helps reduce the risk of losing both during a theft or robbery.',
    'Mengasingkan wang tunai daripada kunci kenderaan membantu mengurangkan risiko kehilangan kedua-duanya sekiranya berlaku kecurian atau rompakan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '42bfc48d-403d-40cd-8416-96d903aa1694',
    NULL,
    'A motorist becomes impatient because your vehicle is blocking access during a delivery.',
    'Seorang pemandu menjadi tidak sabar kerana kenderaan anda menghalang laluan semasa membuat penghantaran.',
    '["Respond politely and explain the situation briefly.", "Ignore the motorist until the delivery is completed.", "Tell the motorist the delivery will not take long.", "Continue working without responding because the stop is authorised."]'::jsonb,
    '["Berikan respons dengan sopan dan jelaskan keadaan secara ringkas.", "Abaikan pemandu tersebut sehingga penghantaran selesai.", "Beritahu pemandu bahawa penghantaran tidak akan mengambil masa yang lama.", "Teruskan kerja tanpa memberi respons kerana anda dibenarkan berhenti di situ."]'::jsonb,
    0,
    'Responding courteously helps reduce public frustration and promotes professional conduct.',
    'Memberi respons secara sopan membantu mengurangkan rasa tidak puas hati orang awam dan mencerminkan sikap profesional.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.0, "professionalism": 1.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '47734c79-4a82-4725-97d1-7f1bf56493dc',
    NULL,
    'Before loading, you notice moisture on the trailer roof supports.',
    'Sebelum loading, anda mendapati terdapat kelembapan pada rangka bumbung treler.',
    '["Wipe the wet roof supports before loading", "Load only waterproof goods in that section", "Close the trailer curtains immediately", "Increase the spacing between the cargo stacks"]'::jsonb,
    '["Lap sehingga kering rangka bumbung sebelum loading", "Loading hanya barang kalis air di bahagian tersebut", "Tutup canvas treler dengan segera", "Tambahkan jarak antara susunan muatan"]'::jsonb,
    0,
    'Remove moisture inside the trailer before loading to reduce the risk of water damage to cargo.',
    'Pastikan bahagian dalam treler kering sebelum loading.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '6b251850-5a37-4ccb-8229-b232ffb92726',
    NULL,
    'After a hard braking event, what should you do before continuing the journey?',
    'Selepas membrek secara mengejut, apakah yang perlu anda lakukan sebelum meneruskan perjalanan?',
    '["Stop safely and inspect the load restraints", "Continue if no warning lights appear", "Drive slower until reaching the destination", "Check the cargo after completing the delivery"]'::jsonb,
    '["Berhenti di tempat yang selamat dan periksa pengikat muatan", "Teruskan perjalanan jika tiada lampu amaran menyala", "Pandu lebih perlahan sehingga tiba di destinasi", "Periksa muatan selepas penghantaran selesai"]'::jsonb,
    0,
    'A significant braking event can loosen or shift the load. Inspect the load restraints before continuing the journey.',
    'Periksa pengikat muatan sebelum meneruskan perjalanan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e425422c-578a-4f5e-8402-dd82c97e3e90',
    NULL,
    'When unloading, you discover damaged goods that were not noticed earlier.',
    'Semasa turun barang anda menyedari terdapat barang yang rosak yang tidak disedari sebelum ini.',
    '["Inform the receiver and your controller immediately", "Hide the damaged goods beneath other cargo", "Deliver the undamaged goods and leave quietly", "Wait until the customer raises the issue"]'::jsonb,
    '["Maklumkan kepada penerima dan pengawal operasi anda dengan segera", "Sorokkan barang rosak di bawah muatan lain", "Serahkan barang yang tidak rosak dan beredar tanpa memaklumkan apa-apa", "Tunggu sehingga pelanggan membangkitkan isu tersebut"]'::jsonb,
    0,
    'Report damage honestly as soon as it is discovered.',
    'Laporkan kerosakan dengan jujur sebaik sahaja disedari.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    7,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '202eeb3e-5ab4-46a7-b100-1b5302c6c284',
    NULL,
    'While moving through a busy site, you feel abnormal resistance and hear a new mechanical sound.',
    'Semasa bergerak di tapak yang sibuk, anda merasakan rintangan tidak normal dan bunyi mekanikal baharu.',
    '["Continue moving slowly to clear the area", "Stop safely, assess the issue, and proceed only when clear", "Adjust steering and throttle to maintain site flow", "Complete the movement and report the issue afterward"]'::jsonb,
    '["Terus bergerak perlahan untuk keluar dari kawasan itu", "Berhenti di tempat selamat, periksa keadaan, dan teruskan hanya apabila jelas selamat", "Laraskan stereng dan pendikit untuk mengekalkan aliran pergerakan tapak", "Selesaikan pergerakan dan laporkan masalah selepas itu"]'::jsonb,
    1,
    'Respond promptly to mechanical cues and ensure the area is safe before proceeding.',
    'Bertindak segera terhadap tanda mekanikal dan pastikan kawasan selamat sebelum meneruskan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0c971390-66cb-42d8-a9dd-960493638ff1',
    NULL,
    'After completing your task, you still have the lorry key.',
    'Selepas menamatkan tugasan, anda masih memegang kunci lori.',
    '["Take the key home for the next shift.", "Return the key to the company as required.", "Leave the key inside the vehicle.", "Keep the key until requested."]'::jsonb,
    '["Bawa pulang kunci untuk syif seterusnya.", "Pulangkan kunci kepada syarikat seperti yang ditetapkan.", "Tinggalkan kunci di dalam kenderaan.", "Simpan kunci sehingga diminta."]'::jsonb,
    1,
    'Return vehicle keys to the company after duty.',
    'Pulangkan kunci kenderaan kepada syarikat selepas bertugas.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '23205640-f0ae-46a8-b1c7-471b78a19bce',
    NULL,
    'You increase following distance in slow traffic. The driver behind closes in and flashes headlights repeatedly.',
    'Anda menambah jarak kenderaan dalam trafik perlahan. Pemandu di belakang merapat dan berulang kali memberi lampu tinggi.',
    '["Keep your distance and continue without responding", "Ease closer to avoid further confrontation behind you", "Acknowledge the other driver briefly so they know you noticed", "Adjust your driving to discourage the behaviour"]'::jsonb,
    '["Kekalkan jarak dan teruskan tanpa memberi respons", "Rapatkan sedikit jarak untuk mengelakkan ketegangan di belakang", "Beri isyarat ringkas supaya pemandu lain tahu anda sedar", "Sesuaikan cara pemanduan untuk menghalang tingkah laku tersebut"]'::jsonb,
    0,
    'Maintaining safe distance and not reacting helps prevent tension from escalating in traffic.',
    'Mengekalkan jarak selamat dan tidak bertindak balas membantu mengelakkan ketegangan di jalan raya.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '94bb1722-a277-4e49-8fe2-257750d6bcaf',
    NULL,
    'You notice there is no compliant safety vest in the vehicle.',
    'Anda mendapati tiada vest keselamatan yang mematuhi spesifikasi di dalam kenderaan.',
    '["Proceed if you remain inside the vehicle.", "Ensure a compliant safety vest is available before departure.", "Wear any bright-coloured clothing instead.", "Borrow one only when entering a site."]'::jsonb,
    '["Teruskan perjalanan jika anda kekal berada di dalam kenderaan.", "Pastikan vest keselamatan yang mematuhi spesifikasi tersedia sebelum memulakan perjalanan.", "Pakai sebarang pakaian berwarna terang sebagai ganti.", "Pinjam vest hanya apabila memasuki tapak."]'::jsonb,
    1,
    'Carry the required safety vest before operating.',
    'Pastikan vest keselamatan yang diperlukan dibawa sebelum beroperasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '82021d0f-129f-45a2-9696-a3464c40030b',
    NULL,
    'While parked inside a site, an emergency alarm sounds and evacuation routes must be kept clear.',
    'Semasa parkir di dalam tapak, penggera kecemasan berbunyi dan laluan keluar mesti dikekalkan bebas halangan.',
    '["Remain in the cabin and wait for instructions", "Secure cabin items and clear the evacuation path immediately", "Leave the vehicle as it is and exit quickly", "Move the vehicle slightly to create more space"]'::jsonb,
    '["Kekal di dalam kabin dan tunggu arahan", "Pastikan barang dalam kabin tidak bergerak dan kosongkan laluan keluar segera", "Tinggalkan kenderaan seperti sedia ada dan keluar dengan cepat", "Gerakkan kenderaan sedikit untuk beri lebih ruang"]'::jsonb,
    1,
    'Secure loose items and clear evacuation routes immediately.',
    'Pastikan barang tidak bergerak dan kekalkan laluan keluar jelas dengan segera.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '22b1fcca-b52b-49ea-b8b5-505cb829846d',
    NULL,
    'After unloading, someone pressures you to change delivery records so the issue does not escalate.',
    'Selepas proses memunggah, seseorang menekan anda supaya mengubah rekod penghantaran agar isu tersebut tidak menjadi lebih besar.',
    '["Say the records must stay as they are and continue calmly", "Change the records slightly so the discussion can end", "Leave the records for now to avoid further disagreement", "Explain repeatedly why the records cannot be changed"]'::jsonb,
    '["Nyatakan rekod mesti kekal seperti sedia ada dan teruskan dengan tenang", "Ubah sedikit rekod supaya perbincangan boleh dihentikan", "Biarkan rekod dahulu untuk elak pertelingkahan lanjut", "Terangkan berulang kali mengapa rekod tidak boleh diubah"]'::jsonb,
    0,
    'Keeping records accurate while staying calm helps prevent conflict from escalating.',
    'Kekalkan rekod yang tepat sambil bersikap tenang untuk elakkan keadaan menjadi lebih tegang.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.25, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'c4f34c9c-893d-4c46-90fb-461690ee2de6',
    NULL,
    'You are reporting for duty after several weeks without a haircut.',
    'Anda melapor diri untuk bertugas selepas beberapa minggu tanpa memotong rambut.',
    '["Maintain short and neat hair as required.", "Keep long hair if tied properly.", "Trim only when reminded by HR.", "Maintain appearance only for inspections."]'::jsonb,
    '["Pastikan rambut sentiasa pendek dan kemas seperti yang ditetapkan.", "Simpan rambut panjang asalkan diikat dengan kemas.", "Potong rambut hanya apabila diingatkan oleh pihak sumber manusia (HR).", "Jaga penampilan hanya semasa pemeriksaan dijalankan."]'::jsonb,
    0,
    'Maintain neat and appropriate grooming for duty.',
    'Kekalkan penampilan yang kemas dan sesuai semasa bertugas.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8e0513d0-215a-460d-acea-e862dbe5b2c9',
    NULL,
    'You approach a busy junction. Traffic slows unevenly and vehicles from the side edge forward.',
    'Anda menghampiri persimpangan sibuk. Trafik perlahan secara tidak sekata dan kenderaan dari sisi bergerak ke hadapan.',
    '["Hold your lane and approach at reduced speed", "Shift slightly within your lane to improve visibility", "Edge closer to discourage other vehicles", "Maintain speed and react only if a vehicle enters"]'::jsonb,
    '["Kekalkan lorong dan hampiri pada kelajuan rendah", "Bergerak sedikit dalam lorong untuk tingkatkan pandangan", "Bergerak lebih dekat untuk menghalang kenderaan lain", "Kekalkan kelajuan dan bertindak hanya jika kenderaan masuk"]'::jsonb,
    0,
    'Clear lane position and early speed control reduce conflict at junctions.',
    'Kedudukan lorong yang jelas dan kawalan kelajuan awal mengurangkan konflik di persimpangan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'aacb2681-5140-4655-92f2-3916eec6e805',
    NULL,
    'Inside a site yard, equipment operates near your path when another vehicle cuts across.',
    'Di kawasan tapak, jentera beroperasi berhampiran laluan anda dan tiba-tiba sebuah kenderaan melintas di hadapan.',
    '["Slow down, keep distance from equipment, and continue calmly", "Adjust position to regain progress while watching equipment", "Proceed steadily to clear the area quickly", "Follow the vehicle ahead closely to avoid delay"]'::jsonb,
    '["Perlahankan, kekalkan jarak dari jentera, dan teruskan dengan tenang", "Laraskan kedudukan untuk meneruskan pergerakan sambil memerhati jentera", "Terus bergerak untuk melepasi kawasan itu dengan cepat", "Ikut kenderaan di hadapan dengan rapat untuk elakkan kelewatan"]'::jsonb,
    0,
    'Maintain composure and distance near operating equipment.',
    'Kekalkan ketenangan dan jarak selamat berhampiran jentera beroperasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.0, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5d2323c0-d81e-4154-8f9c-d78169d14cd3',
    NULL,
    'Before starting duty, you have not completed the required rest and are still under medication.',
    'Sebelum memulakan tugas, anda belum mendapat rehat yang cukup dan masih di bawah kesan ubat.',
    '["Delay starting duty and report the issue", "Start the trip carefully since the route is familiar", "Begin driving and stop later if you feel affected", "Proceed and take rest after your shift"]'::jsonb,
    '["Tangguhkan tugas dan laporkan keadaan tersebut", "Mulakan perjalanan dengan berhati-hati kerana laluan sudah biasa", "Mula memandu dan berhenti kemudian jika terasa terjejas", "Teruskan dan ambil rehat selepas tamat syif"]'::jsonb,
    0,
    'Confirm fitness for duty before driving.',
    'Pastikan kecergasan untuk bertugas sebelum memandu.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '503eb950-4251-4a1d-bfa3-ff4640d1f1c8',
    NULL,
    'You arrive at a customer  premise and are told unloading will take longer than expected. The vehicle is parked safely.',
    'Anda tiba di tempat pelanggan dan dimaklumkan proses memunggah keluar akan mengambil masa lebih lama daripada jangkaan. Kenderaan telah diparkir dengan selamat.',
    '["Switch off the engine while waiting", "Keep the engine running to be ready to move", "Rev the engine occasionally", "Leave the engine idling and monitor the situation"]'::jsonb,
    '["Matikan enjin semasa menunggu", "Biarkan enjin hidup untuk bersedia bergerak", "Tekan minyak sekali-sekala", "Biarkan enjin melahu sambil memantau keadaan"]'::jsonb,
    0,
    'Switch off the engine during long waiting periods.',
    'Matikan enjin semasa menunggu lama untuk mengelakkan pembaziran bahan api.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.75, "discipline": 0.25, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '3d4bb1bd-db7b-4d9e-b8c1-f84d120e1794',
    NULL,
    'You approach a road section with temporary cones where pedestrians are crossing near your lane.',
    'Anda menghampiri laluan yang dipasang kon sementara dengan pejalan kaki melintas berhampiran lorong anda.',
    '["Maintain correct lane position and proceed cautiously past the area", "Move closer to the lane edge to pass through more quickly", "Adjust position to follow vehicles ahead without slowing", "Focus on traffic flow and avoid reacting to people nearby"]'::jsonb,
    '["Kekalkan kedudukan lorong yang betul dan pandu dengan berhati-hati melalui kawasan tersebut", "Rapat ke tepi lorong untuk melepasi kawasan dengan lebih cepat", "Laraskan kedudukan mengikut kenderaan di hadapan tanpa memperlahankan", "Fokus pada aliran trafik dan abaikan orang di sekitar"]'::jsonb,
    0,
    'Maintaining lane discipline and caution protects pedestrians and reflects responsible public conduct.',
    'Disiplin lorong dan pemanduan berhati-hati melindungi pejalan kaki serta mencerminkan sikap bertanggungjawab di tempat awam.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7598bb30-e899-4d78-b467-74a41debdca5',
    NULL,
    'You are involved in a minor incident during vehicle operation.',
    'Anda terlibat dalam satu insiden kecil semasa mengendalikan kenderaan.',
    '["Report the incident within 2 hours as required.", "Report it at the end of the workday.", "Report only if damage is visible.", "Wait until instructed before reporting."]'::jsonb,
    '["Laporkan insiden dalam tempoh 2 jam seperti yang ditetapkan.", "Laporkan pada akhir hari kerja.", "Laporkan hanya jika terdapat kerosakan yang dapat dilihat.", "Tunggu arahan sebelum membuat laporan."]'::jsonb,
    0,
    'Report accidents or incidents within the required reporting timeframe.',
    'Laporkan kemalangan atau insiden dalam tempoh masa pelaporan yang ditetapkan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.0, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a017a0a1-ad0a-4799-af34-cf69b552a6ee',
    NULL,
    'You are completing a delivery trip.',
    'Anda menamatkan satu perjalanan penghantaran.',
    '["Record the meter reading only at the end of the trip.", "Record the meter reading before and after the trip.", "Record it only if fuel usage seems unusual.", "Estimate the reading based on distance travelled."]'::jsonb,
    '["Catat bacaan meter hanya pada akhir perjalanan.", "Catat bacaan meter sebelum dan selepas perjalanan.", "Catat hanya jika penggunaan bahan api kelihatan luar biasa.", "Anggarkan bacaan berdasarkan jarak perjalanan."]'::jsonb,
    1,
    'Record meter readings before and after each trip.',
    'Catat bacaan meter sebelum dan selepas setiap perjalanan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '57eb8b81-4cf0-4f6e-a5fe-bdf5e1656860',
    NULL,
    'While driving inside a site, you see a posted speed limit.',
    'Semasa memandu di dalam tapak, anda melihat had laju yang dipaparkan.',
    '["Adjust speed to comply with the posted limit", "Maintain current speed since traffic is light", "Reduce speed slightly but continue comfortably", "Match the speed of other vehicles"]'::jsonb,
    '["Laraskan kelajuan untuk mematuhi had laju yang dipaparkan", "Kekalkan kelajuan kerana trafik ringan", "Kurangkan kelajuan sedikit tetapi teruskan dengan selesa", "Ikut kelajuan kenderaan lain"]'::jsonb,
    0,
    'Follow posted speed limits inside operational sites.',
    'Patuhi had laju yang ditetapkan di dalam kawasan operasi.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '59107132-041e-4373-92ae-66f9dd5672ab',
    NULL,
    'A customer calls you during the trip and urges you to arrive faster due to a delay.',
    'Seorang pelanggan menelefon semasa perjalanan dan mendesak anda tiba lebih cepat kerana berlaku kelewatan.',
    '["Maintain a safe speed and explain your expected arrival time", "Increase speed slightly to show effort and responsiveness", "Reassure the customer and focus on reaching sooner", "Shorten the conversation and continue driving as planned"]'::jsonb,
    '["Kekalkan kelajuan selamat dan maklumkan anggaran masa ketibaan", "Tambah sedikit kelajuan untuk tunjuk usaha dan responsif", "Yakinkan pelanggan dan cuba sampai lebih awal", "Pendekkan perbualan dan teruskan perjalanan seperti biasa"]'::jsonb,
    0,
    'Maintaining safe speed while giving a clear update supports both safety and customer trust.',
    'Kekalkan kelajuan selamat sambil beri maklumat jelas bagi menjaga keselamatan dan kepercayaan pelanggan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '29b5fa56-6691-4b3e-92a8-8c218b5fc10c',
    NULL,
    'A vehicle cuts in sharply, making you angry. You need to change lanes while drivers around you are unsure of your intention',
    'Sebuah kenderaan memotong masuk secara mengejut sehingga anda berasa marah. Anda perlu menukar lorong ketika pemandu lain di sekitar tidak pasti tentang niat anda.',
    '["Regain composure and signal clearly before changing lanes", "Change lanes quickly to get away from the situation", "Sound the horn briefly to express frustration", "Hold your lane without signalling until traffic settles"]'::jsonb,
    '["Tenangkan diri dan beri isyarat dengan jelas sebelum menukar lorong", "Tukar lorong dengan cepat untuk menjauhkan diri daripada situasi", "Bunyi hon seketika untuk meluahkan rasa tidak puas hati", "Kekalkan lorong tanpa memberi isyarat sehingga trafik kembali stabil"]'::jsonb,
    0,
    'Clear signalling after regaining composure helps others understand your intentions and keeps traffic moving safely.',
    'Isyarat yang jelas selepas menenangkan diri membantu pemandu lain memahami niat anda dan memastikan aliran trafik kekal selamat.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '5c759ca0-d259-428f-8d0f-3dd8b08b1c67',
    NULL,
    'You are starting  your work shift for the day.',
    'Anda memulakan syif kerja pada hari tersebut.',
    '["Record your attendance at the end of the shift.", "Record your attendance  at the beginning and end of the shift.", "Inform your supervisor.", "Record attendance only when requested."]'::jsonb,
    '["Rekodkan kehadiran pada akhir syif.", "Rekodkan kehadiran pada awal dan akhir syif.", "Maklumkan kepada penyelia.", "Rekodkan kehadiran hanya apabila diminta."]'::jsonb,
    1,
    'Record attendance properly at the start and end of duty.',
    'Rekod kehadiran dengan betul pada awal dan akhir tugas.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '7c168518-6098-48ec-bbcc-8e6ed7033220',
    NULL,
    'After completing your trip, you notice a minor defect that developed during the drive.',
    'Selepas selesai perjalanan, anda mendapati kerosakan kecil berlaku semasa memandu.',
    '["Report the defect and ensure the vehicle is checked before reuse", "Note the defect later since the trip is completed", "Mention it informally to the next driver", "Leave the vehicle available since it still operates"]'::jsonb,
    '["Laporkan kerosakan dan pastikan kenderaan diperiksa sebelum digunakan semula", "Catat kerosakan kemudian kerana perjalanan telah selesai", "Beritahu secara tidak rasmi kepada pemandu seterusnya", "Biarkan kenderaan digunakan kerana masih boleh beroperasi"]'::jsonb,
    0,
    'Report defects promptly to prevent risk in the next operation.',
    'Laporkan kerosakan dengan segera untuk mengelakkan risiko dalam operasi seterusnya.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.75, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '39719c08-f60d-40ba-bb18-2e9df0c611d2',
    NULL,
    'Traffic slows unexpectedly, and a supervisor asks if you can make up time on the road.',
    'Trafik tiba-tiba menjadi perlahan dan penyelia bertanya sama ada anda boleh mengejar semula masa di jalan raya.',
    '["Keep to a safe speed and give a clear, realistic update", "Say you will try to make up time where possible", "Reassure them and focus on pushing ahead", "Keep the call short and continue driving"]'::jsonb,
    '["Kekalkan kelajuan selamat dan beri maklumat yang jelas serta realistik", "Beritahu bahawa anda akan cuba mengejar masa jika boleh", "Yakinkan penyelia dan fokus untuk bergerak lebih laju", "Pendekkan panggilan dan teruskan perjalanan"]'::jsonb,
    0,
    'Clear updates and safe driving help manage expectations without increasing risk.',
    'Maklumat yang jelas dan pemanduan selamat membantu urus jangkaan tanpa menambah risiko.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '58fe3681-25c0-40ed-92dc-a5e331039947',
    NULL,
    'Traffic ahead is moving, but you keep extra distance. A customer messages asking why progress feels slow.',
    'Trafik di hadapan bergerak, namun anda mengekalkan jarak yang lebih selamat. Pelanggan menghantar mesej bertanya mengapa pergerakan agak lambat.',
    '["Maintain safe following distance and explain the situation calmly", "Close the gap slightly so movement appears faster", "Reassure the customer and focus on keeping pace", "Ignore the message and continue driving"]'::jsonb,
    '["Kekalkan jarak selamat dan jelaskan keadaan dengan tenang", "Rapatkan sedikit jarak supaya pergerakan nampak lebih cepat", "Yakinkan pelanggan dan cuba kekalkan kelajuan trafik", "Abaikan mesej dan teruskan pemanduan"]'::jsonb,
    0,
    'Keeping a safe following distance while explaining the reason supports safety and customer confidence.',
    'Mengekalkan jarak selamat sambil memberi penjelasan membantu menjaga keselamatan dan keyakinan pelanggan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.25, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'e42246ae-d0a2-4327-9774-3c932a6273b7',
    NULL,
    'Another driver cuts in suddenly, forcing you to brake, then begins gesturing angrily at you.',
    'Seorang pemandu memotong masuk secara tiba-tiba sehingga anda terpaksa membrek, kemudian menunjukkan isyarat marah kepada anda.',
    '["Regain composure and continue driving without reacting", "Respond briefly to show you were affected by the move", "Accelerate to move away from the situation", "Slow further to signal your frustration"]'::jsonb,
    '["Tenangkan diri dan teruskan pemanduan tanpa memberi respons", "Beri respons ringkas untuk menunjukkan anda terkesan", "Tambah kelajuan untuk menjauhkan diri daripada situasi", "Perlahankan lagi kenderaan sebagai tanda tidak puas hati"]'::jsonb,
    0,
    'Maintaining composure and not reacting helps prevent aggressive situations from escalating.',
    'Mengekalkan ketenangan dan tidak bertindak balas membantu mengelakkan situasi agresif daripada menjadi lebih tegang.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.0, "professionalism": 0.75}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '0efeed6d-a678-4869-b272-08206401c111',
    NULL,
    'Before driving into a customer premises, you are unsure whether your vehicle can safely clear an overhead structure.',
    'Sebelum memasuki premis pelanggan, anda tidak pasti sama ada kenderaan anda mempunyai ruang kelegaan yang mencukupi untuk melepasi struktur di bahagian atas.',
    '["Verify the available clearance before entering.", "Continue carefully while watching the roof clearance.", "Ask a colleague to observe the vehicle as you drive through.", "Reverse out only if the vehicle makes contact with the structure."]'::jsonb,
    '["Sahkan ruang kelegaan yang tersedia sebelum memasuki kawasan tersebut.", "Teruskan dengan berhati-hati sambil memerhatikan ruang kelegaan di bahagian atas.", "Minta rakan memerhati kenderaan semasa anda melaluinya.", "Undur keluar hanya jika kenderaan terkena struktur tersebut."]'::jsonb,
    0,
    'When clearance is uncertain, verify it before proceeding to avoid collisions with overhead structures.',
    'Jika ruang kelegaan tidak pasti, sahkannya terlebih dahulu sebelum meneruskan perjalanan bagi mengelakkan pelanggaran dengan struktur di bahagian atas.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '9965d27c-7985-4a43-9423-8db78c33bd91',
    NULL,
    'Before entering a narrow lane to make a delivery, you realise your vehicle may not have enough side clearance.',
    'Sebelum memasuki lorong yang sempit untuk membuat penghantaran, anda mendapati kenderaan anda mungkin tidak mempunyai ruang sisi yang mencukupi.',
    '["Fold the side mirrors before entering if it is safe to do so.", "Continue slowly while watching both mirrors closely.", "Ask pedestrians to guide the vehicle through the lane.", "Enter only after sounding the horn to warn others."]'::jsonb,
    '["Lipat cermin sisi sebelum memasuki lorong jika selamat berbuat demikian.", "Teruskan perlahan sambil memerhati kedua-dua cermin sisi.", "Minta pejalan kaki membantu mengarah kenderaan melalui lorong tersebut.", "Masuk hanya selepas membunyikan hon untuk memberi amaran kepada orang lain."]'::jsonb,
    0,
    'Adapt the vehicle to suit confined access conditions before proceeding to reduce the risk of vehicle damage.',
    'Sesuaikan kenderaan mengikut keadaan laluan yang sempit sebelum meneruskan perjalanan bagi mengurangkan risiko kerosakan pada kenderaan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 1.0, "discipline": 0.0, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '25478039-8831-43bb-95de-67428648afa9',
    NULL,
    'During the final load check, the middle layer of cartons shifts when pushed by hand.',
    'Semasa pemeriksaan akhir muatan, lapisan tengah kotak bergerak apabila ditolak dengan tangan.',
    '["Secure the load before starting the journey.", "Continue if the upper layer remains firmly secured.", "Reduce travelling speed until the next delivery point.", "Monitor the load during the journey and adjust if necessary."]'::jsonb,
    '["Ikat muatan dengan kemas sebelum memulakan perjalanan.", "Teruskan perjalanan jika lapisan atas masih diikat dengan kukuh.", "Kurangkan kelajuan sehingga tiba di lokasi penghantaran seterusnya.", "Pantau muatan sepanjang perjalanan dan laraskan jika perlu."]'::jsonb,
    0,
    'A load that shifts during inspection must be secured before the vehicle is moved.',
    'Muatan yang bergerak semasa pemeriksaan mesti diikat dengan betul sebelum kenderaan bergerak.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8baf9c59-28b0-4cb5-98e0-56c068886030',
    NULL,
    'You are making a short delivery and expect to be away from the vehicle for less than a minute.',
    'Anda membuat penghantaran yang singkat dan menjangkakan akan meninggalkan kenderaan kurang daripada seminit.',
    '["Secure the vehicle before leaving it unattended.", "Leave the window slightly open because the stop is brief.", "Leave the engine running to save time.", "Keep the vehicle unlocked if it remains within sight."]'::jsonb,
    '["Pastikan kenderaan dikunci dan selamat sebelum ditinggalkan tanpa pengawasan.", "Biarkan tingkap terbuka sedikit kerana berhenti hanya seketika.", "Biarkan enjin hidup untuk menjimatkan masa.", "Biarkan kenderaan tidak berkunci jika masih berada dalam pandangan."]'::jsonb,
    0,
    'The duration of a stop does not reduce the need to secure the vehicle against theft.',
    'Tempoh berhenti yang singkat tidak mengurangkan keperluan untuk mengunci dan mengamankan kenderaan bagi mengurangkan risiko kecurian.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '8640b8d9-2964-43d6-a80e-26592e1c1cfa',
    NULL,
    'A customer insists that you hand over the parcel at an unapproved location behind the building.',
    'Seorang pelanggan bertegas meminta anda menyerahkan bungkusan di lokasi yang tidak diluluskan di belakang bangunan.',
    '["Decline the request and complete the delivery only at the authorised location.", "Hand over the parcel if the customer can identify the order.", "Complete the delivery if another person confirms the customer''s identity.", "Leave the parcel at the requested location and notify the office afterwards."]'::jsonb,
    '["Tolak permintaan dan hantar hanya di lokasi yang dibenarkan.", "Serahkan bungkusan jika pelanggan dapat mengenal pasti pesanan.", "Selesaikan penghantaran jika orang lain mengesahkan identiti pelanggan.", "Tinggalkan bungkusan di lokasi yang diminta dan maklumkan kepada pejabat selepas itu."]'::jsonb,
    0,
    'Deliver parcels only at authorised locations to protect company assets and prevent fraudulent claims.',
    'Serahkan bungkusan hanya di lokasi yang dibenarkan untuk melindungi aset syarikat dan mengelakkan tuntutan palsu.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'ad09474d-bd93-4d05-84ac-2dcd155feb49',
    NULL,
    'Before loading starts, you notice oil stains and a wet floor inside the cargo compartment.',
    'Sebelum loading bermula, anda mendapati kesan minyak dan lantai basah di dalam ruang kargo.',
    '["Clean and dry the cargo compartment before accepting the load", "Continue loading because the cartons are packed securely", "Cover the affected area with cardboard and continue loading", "Inform the customer after the loading is completed"]'::jsonb,
    '["Bersihkan dan keringkan ruang kargo sebelum menerima muatan", "Teruskan loading kerana kotak telah dibungkus dengan selamat", "Tutup kawasan tersebut dengan kadbod dan teruskan loading", "Maklumkan kepada pelanggan selepas loading selesai"]'::jsonb,
    0,
    'Always ensure the cargo compartment is clean and dry before loading to prevent cargo contamination or damage.',
    'Pastikan ruang kargo sentiasa bersih dan kering sebelum loading bagi mengelakkan pencemaran atau kerosakan pada muatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'b100d5b9-a7e3-4d38-b895-6e986248675d',
    NULL,
    'After loading, a warehouse staff member tells you that the documents are correct and asks you to leave quickly without checking them.',
    'Selepas loading, seorang kakitangan gudang memberitahu bahawa dokumen adalah betul dan meminta anda bertolak segera tanpa membuat semakan.',
    '["Verify the documents and cargo before accepting responsibility for the load", "Accept the documents since the warehouse prepared them", "Check the documents only if you notice a loading problem", "Deliver the cargo first and report any discrepancy later"]'::jsonb,
    '["Semak dokumen dan muatan sebelum menerima tanggungjawab ke atas muatan", "Terima sahaja dokumen kerana ia disediakan oleh pihak gudang", "Semak dokumen hanya jika anda mengesan masalah semasa loading", "Hantar dahulu muatan dan laporkan sebarang percanggahan kemudian"]'::jsonb,
    0,
    'Always verify the delivery documents against the loaded cargo before accepting responsibility for the load.',
    'Sentiasa semak dokumen penghantaran dengan muatan sebelum menerima tanggungjawab ke atas muatan.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.25, "discipline": 0.5, "professionalism": 0.25}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'a66d85a1-f5ef-4df3-afce-b204b731ec06',
    NULL,
    'Rain is expected before your lorry leaves the loading area.',
    'Hujan dijangka turun sebelum lori anda meninggalkan kawasan loading.',
    '["Cover the cargo with a heavy-duty tarpaulin", "Wait until it starts raining before covering the load", "Cover only the front section of the cargo", "Drive faster to avoid the rain"]'::jsonb,
    '["Tutup muatan dengan tarpaulin yang sesuai", "Tunggu sehingga hujan turun sebelum menutup muatan", "Tutup hanya bahagian hadapan muatan", "Pandu lebih laju untuk mengelakkan hujan"]'::jsonb,
    0,
    'Protect exposed cargo with a suitable heavy-duty tarpaulin before transport to prevent weather damage.',
    'Lindungi muatan dengan tarpaulin sebelum bertolak.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.5, "discipline": 0.5, "professionalism": 0.0}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '846d8057-941a-4fe6-824a-ffb029fab7f4',
    NULL,
    'A customer rejects some goods during delivery.',
    'Pelanggan menolak sebahagian barang semasa penghantaran.',
    '["Obtain written rejection before returning the goods", "Return the goods and update the records later", "Accept the verbal rejection and take photos only", "Leave the rejected goods at the customer''s premises until instructed"]'::jsonb,
    '["Dapatkan pengesahan penolakan secara bertulis sebelum membawa balik barang", "Bawa balik barang dan kemas kini rekod kemudian", "Terima penolakan secara lisan dan ambil gambar sahaja", "Tinggalkan barang yang ditolak di premis pelanggan sehingga menerima arahan"]'::jsonb,
    0,
    'Return rejected goods only after obtaining proper documentation.',
    'Bawa balik barang yang ditolak hanya selepas mendapat dokumentasi yang lengkap.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);

INSERT INTO public.questions (
    id, reference_number, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    'be12254c-81cb-40e8-ab1d-e8b90941bafe',
    NULL,
    'Before carrying goods that may leak, what should your spill kit contain?',
    'Sebelum membawa barang yang berisiko menyebabkan tumpahan, apakah yang perlu ada dalam spill kit anda?',
    '["Sawdust or absorbent material and cleaning rags", "Water bottle and spare gloves only", "Broom and empty cartons", "Rope and warning triangles"]'::jsonb,
    '["Habuk kayu atau bahan penyerap dan kain pembersih", "Botol air dan sarung tangan ganti sahaja", "Penyapu dan kotak kosong", "Tali dan segi tiga amaran"]'::jsonb,
    0,
    'Carry a basic spill kit suitable for containing minor spills.',
    'Bawa spill kit asas yang sesuai untuk mengawal tumpahan kecil.',
    ARRAY['MY'],
    'Box Van',
    ARRAY['Box Van','Urban Delivery'],
    'intermediate',
    8,
    '{"operation": 0.0, "discipline": 0.5, "professionalism": 0.5}'::jsonb
);