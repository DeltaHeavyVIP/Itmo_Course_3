CREATE OR REPLACE FUNCTION check_dates()
    RETURNS TRIGGER AS
$$
DECLARE
BEGIN
    IF NEW."DATE_ISSUE" <= NEW."DATE_CANCELLATION"
    THEN
        RAISE EXCEPTION 'Wrong dates in ДОКУМЕНТ_АККРЕДИДАЦИИ([id:%])',
            NEW.id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER check_dates_trigger
    AFTER INSERT OR UPDATE
    ON db_course_work_backend_document_accreditation
    FOR EACH ROW
EXECUTE PROCEDURE check_dates();

CREATE OR REPLACE FUNCTION check_free_slots()
    RETURNS TRIGGER AS
$$
DECLARE
    MAX_COUNT     integer;
    CURRENT_COUNT integer;
BEGIN
    SELECT into MAX_COUNT "NUMBER_SEATS" from db_course_work_backend_group where db_course_work_backend_group.id = NEW.group_id;
    SELECT into CURRENT_COUNT count(excursionist_id)
    from db_course_work_backend_group_excursionist
    where db_course_work_backend_group_excursionist.group_id = NEW.group_id;

    IF CURRENT_COUNT > MAX_COUNT
    THEN
        RAISE EXCEPTION 'No slots';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER check_free_slots_trigger
    AFTER INSERT OR UPDATE
    ON db_course_work_backend_group_excursionist
    FOR EACH ROW
EXECUTE PROCEDURE check_free_slots();



CREATE OR REPLACE FUNCTION check_ЭКСКУРСИЯ_ЭКСПОНАТ()
    RETURNS TRIGGER AS
$$
DECLARE
    МЕСТО_ЭКСПОНАТ integer;
BEGIN
    SELECT into МЕСТО_ЭКСПОНАТ "МЕСТОРАСПОЛОЖЕНИЕ" from "ЭКСПОНАТ" where id = new."ЭКСПОНАТ_id";

    IF МЕСТО_ЭКСПОНАТ not in (
        SELECT "МЕСТОРАСПОЛОЖЕНИЕ"
        from "ЭКСКУРСИЯ_МУЗЕЙ"
                 join "МУЗЕЙ" М on М.id = "ЭКСКУРСИЯ_МУЗЕЙ"."МУЗЕЙ_id"
        where "ЭКСКУРСИЯ_МУЗЕЙ"."ЭКСКУРСИЯ_id" = new."ЭКСКУРСИЯ_id"
    )
    THEN
        RAISE EXCEPTION 'Экскурсия % не проходит в месте, где находится экспонат %', new."ЭКСКУРСИЯ_id", new."ЭКСПОНАТ_id";
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER check_ЭКСКУРСИЯ_ЭКСПОНАТ_trigger
    AFTER INSERT OR UPDATE
    ON "ЭКСКУРСИЯ_ЭКСПОНАТ"
    FOR EACH ROW
EXECUTE PROCEDURE check_ЭКСКУРСИЯ_ЭКСПОНАТ();

CREATE OR REPLACE FUNCTION check_ЭКСКУРСИЯ_ВЫСТАВКА()
    RETURNS TRIGGER AS
$$
DECLARE
    МЕСТО_ВЫСТАВКА integer;
BEGIN
    SELECT into МЕСТО_ВЫСТАВКА "МЕСТОРАСПОЛОЖЕНИЕ" from "ВЫСТАВКА" where id = new."ВЫСТАВКА_id";

    IF МЕСТО_ВЫСТАВКА not in (
        SELECT "МЕСТОРАСПОЛОЖЕНИЕ"
        from "ЭКСКУРСИЯ_МУЗЕЙ"
                 join "МУЗЕЙ" М on М.id = "ЭКСКУРСИЯ_МУЗЕЙ"."МУЗЕЙ_id"
        where "ЭКСКУРСИЯ_МУЗЕЙ"."ЭКСКУРСИЯ_id" = new."ЭКСКУРСИЯ_id"
    )
    THEN
        RAISE EXCEPTION 'Экскурсия % не проходит в месте, где находится выставка %', new."ЭКСКУРСИЯ_id", new."ВЫСТАВКА_id";
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER check_ЭКСКУРСИЯ_ВЫСТАВКА_trigger
    AFTER INSERT OR UPDATE
    ON "ЭКСКУРСИЯ_ВЫСТАВКА"
    FOR EACH ROW
EXECUTE PROCEDURE check_ЭКСКУРСИЯ_ВЫСТАВКА();

CREATE OR REPLACE FUNCTION check_АККРЕДИТАЦИЯ()
    RETURNS TRIGGER AS
$$
DECLARE
    it_МУЗЕЙ_id integer;
BEGIN
    for it_МУЗЕЙ_id in select "МУЗЕЙ_id" from "ЭКСКУРСИЯ_МУЗЕЙ" where "ЭКСКУРСИЯ_id" = new."ЭКСКУРСИЯ_id"
        loop
            IF not if_guide_accessed_to_museum(new."ГИД", it_МУЗЕЙ_id)
            THEN
                RAISE EXCEPTION 'Гид % не имеет аккредитации для проведения экскурсий в музее %', new."ГИД", it_МУЗЕЙ_id;
            END IF;
        end loop;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER check_АККРЕДИТАЦИЯ_trigger
    AFTER INSERT OR UPDATE
    ON "ГРУППА"
    FOR EACH ROW
EXECUTE PROCEDURE check_АККРЕДИТАЦИЯ();
