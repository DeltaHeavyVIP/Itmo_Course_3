create or replace function future_excursions_count() returns bigint as
$$
SELECT count(id) as result
from db_course_work_backend_group
where "TIME" > now();
$$ language sql;
create or replace function accredited_guides_count() returns bigint as
$$
SELECT count(DISTINCT "MOBILE_NUMBER") as result
from db_course_work_backend_guide
         join db_course_work_backend_document_accreditation_guide ГДА on db_course_work_backend_guide."MOBILE_NUMBER" = ГДА.guide_id
         join db_course_work_backend_document_accreditation ДА on ДА.id = ГДА.document_accreditation_id
where ДА."DATE_CANCELLATION" > now();
$$ language sql;
create or replace function if_guide_accessed_to_museum(guide_phone bigint, museum_id integer) returns bool as
$$
SELECT count(DISTINCT "MOBILE_NUMBER") != 0 as result
from db_course_work_backend_guide
         join "ГИД_ДОКУМЕНТ_АККРЕДИТАЦИИ" ГДА on "ГИД"."МОБИЛЬНЫЙ_НОМЕР" = ГДА."ГИД_id"
         join "ДОКУМЕНТ_АККРЕДИТАЦИИ" ДА on ДА.id = ГДА."ДОКУМЕНТ_АККРЕДИТАЦИИ_id"
where ДА."ДАТА_АННУЛИРОВАНИЯ" > now()
  and ДА."УЧРЕЖДЕНИЕ" = (select "НАЗВАНИЕ" from "МУЗЕЙ" where id = museum_id)
  and "МОБИЛЬНЫЙ_НОМЕР" = guide_phone;
$$ language sql;
