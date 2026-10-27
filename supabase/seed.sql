insert into schemes(id,code,name,uri,owner,languages) values
 ('10000000-0000-4000-8000-000000000001','OPS','Harbour operations vocabulary','https://example.org/schemes/ops','Mara Chen',array['en','mi']),
 ('10000000-0000-4000-8000-000000000002','GUIDES','Harbour guide vocabulary','https://example.org/schemes/guides','Ari Patel',array['en']) on conflict do nothing;
insert into concepts(id,scheme_id,code,uri,definition,owner,status,review_due,approved_by,approved_at,updated_at) values
 ('20000000-0000-4000-8000-000000000001','10000000-0000-4000-8000-000000000001','WATER','https://example.org/ops/water','Water topics used to classify operational guidance.','Mara Chen','approved',current_date+60,'Ari Patel',now(),now()),
 ('20000000-0000-4000-8000-000000000002','10000000-0000-4000-8000-000000000001','QUALITY','https://example.org/ops/quality','Records describing water quality.','Mara Chen','draft',current_date-7,null,null,now()-interval '40 days'),
 ('20000000-0000-4000-8000-000000000003','10000000-0000-4000-8000-000000000001','SUPPLY','https://example.org/ops/supply','','','draft',current_date+3,null,null,now()-interval '45 days'),
 ('20000000-0000-4000-8000-000000000004','10000000-0000-4000-8000-000000000002','GUIDE','https://example.org/guides/guide','A guide describing a repeatable working practice.','Ari Patel','approved',current_date+90,'Mara Chen',now(),now()) on conflict do nothing;
insert into labels(concept_id,kind,lang,value) values
 ('20000000-0000-4000-8000-000000000001','pref','en','Water'),('20000000-0000-4000-8000-000000000001','pref','mi','Wai'),
 ('20000000-0000-4000-8000-000000000002','pref','en','Water quality'),('20000000-0000-4000-8000-000000000002','alt','en','Water testing'),
 ('20000000-0000-4000-8000-000000000003','pref','en','Water supply'),('20000000-0000-4000-8000-000000000003','alt','en','Water testing'),
 ('20000000-0000-4000-8000-000000000004','pref','en','Guide') on conflict do nothing;
insert into relations(subject_id,kind,object_id) values ('20000000-0000-4000-8000-000000000002','broader','20000000-0000-4000-8000-000000000001') on conflict do nothing;
insert into requests(id,concept_id,title,owner,due) values ('30000000-0000-4000-8000-000000000001','20000000-0000-4000-8000-000000000002','Confirm definition with the operations editor','Ari Patel',current_date-5) on conflict do nothing;
