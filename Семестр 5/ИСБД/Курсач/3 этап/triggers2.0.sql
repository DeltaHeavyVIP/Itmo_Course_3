CREATE OR REPLACE FUNCTION check_date_issue_document_accreditation()
    RETURNS TRIGGER AS
$$
DECLARE
BEGIN
    IF NEW."DATE_ISSUE" <= '2010-01-01'
    THEN
        RAISE EXCEPTION 'Wrong dates in DOCUMENT_ACCREDITATION([id:%])',
            NEW.id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER check_date_issue_document_accreditation
    AFTER INSERT OR UPDATE
    ON db_course_work_backend_document_accreditation
    FOR EACH ROW
EXECUTE PROCEDURE check_date_issue_document_accreditation();

CREATE OR REPLACE FUNCTION check_date_issue_document_status()
    RETURNS TRIGGER AS
$$
DECLARE
BEGIN
    IF NEW."DATE_ISSUE" <= '1940-01-01'
    THEN
        RAISE EXCEPTION 'Wrong dates in DOCUMENT_STATUS([id:%])',
            NEW.id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER check_date_issue_document_status
    AFTER INSERT OR UPDATE
    ON db_course_work_backend_document_status
    FOR EACH ROW
EXECUTE PROCEDURE check_date_issue_document_status();

CREATE OR REPLACE FUNCTION check_guide_data()
    RETURNS TRIGGER AS
$$
DECLARE
BEGIN
    IF NOT (NEW."MOBILE_NUMBER"::text ~ '^[0-9]{11}$')
    THEN
        RAISE EXCEPTION 'Wrong MOBILE_NUMBER in GUIDE([id:%])',
            NEW.id;
    END IF;
    IF NOT (NEW."EMAIL" ~ '^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$')
    THEN
        RAISE EXCEPTION 'Wrong EMAIL in GUIDE([id:%])',
            NEW.id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER check_guide_data
    AFTER INSERT OR UPDATE
    ON db_course_work_backend_guide
    FOR EACH ROW
EXECUTE PROCEDURE check_guide_data();

CREATE OR REPLACE FUNCTION check_passport_date()
    RETURNS TRIGGER AS
$$
DECLARE
BEGIN
    IF NEW."DATE_BIRTHDAY" <= '1940-01-01'
    THEN
        RAISE EXCEPTION 'Wrong DATE_BIRTHDAY in PASSPORT([id:%])',
            NEW.id;
    END IF;
    IF NEW."DATE_ISSUE" <= '1960-01-01'
    THEN
        RAISE EXCEPTION 'Wrong DATE_ISSUE in PASSPORT([id:%])',
            NEW.id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER check_passport_date
    AFTER INSERT OR UPDATE
    ON db_course_work_backend_passport
    FOR EACH ROW
EXECUTE PROCEDURE check_passport_date();
