/*USER*/ 
CREATE TABLE IF NOT EXISTS USER(
USER_ID INT AUTO_INCREMENT PRIMARY KEY,
USER_TYPE CHAR(1),
FIRST_NAME VARCHAR(25),
MIDDLE_NAME VARCHAR(25),
LAST_NAME VARCHAR(25),
DOB DATE,
ADDRESS1 VARCHAR(100),
ADDRESS2 VARCHAR(100),
CITY VARCHAR(25),
STATE VARCHAR(25),
COUNTRY VARCHAR(25),
MOBILE INT,
MAIL_ID VARCHAR(25),
CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/*USER_CREDENTIALS*/
CREATE TABLE IF NOT EXISTS USER_CREDENTIALS(
CREDENTIALS_ID INT AUTO_INCREMENT PRIMARY KEY,
USER_ID INT,
PASSWORD VARCHAR(25),
LAST_LOGIN_DT DATE,
USER_STATUS VARCHAR(10),
CONSTRAINT fk_userId
    FOREIGN KEY (USER_ID) 
        REFERENCES USER(USER_ID)
);

/*PARENT_DETAILS*/
CREATE TABLE IF NOT EXISTS PARENT_DETAILS(
PARENT_ID INT AUTO_INCREMENT PRIMARY KEY,
STUDENT_ID INT,
PARENT_FIRST_NAME VARCHAR(25),
PARENT_MIDDLE_NAME VARCHAR(25),
PARENT_LAST_NAME VARCHAR(25),
RELATION_TO_STUDENT VARCHAR(25),
PARENT_MOBILE INT,
PARENT_MAIL_ID VARCHAR(25),
CONSTRAINT fk_studentId
    FOREIGN KEY (STUDENT_ID) 
        REFERENCES USER(USER_ID)
);

/*COURSE*/
CREATE TABLE IF NOT EXISTS COURSE(
COURSE_ID INT AUTO_INCREMENT PRIMARY KEY,
COURSE_NAME VARCHAR(100),
DURATION VARCHAR(50)
);

/*MODULE*/
CREATE TABLE IF NOT EXISTS MODULE(
MODULE_ID INT AUTO_INCREMENT PRIMARY KEY,
MODULE_NAME VARCHAR(100),
COURSE_ID INT,
CONSTRAINT fk_courseId
    FOREIGN KEY (COURSE_ID) 
        REFERENCES COURSE(COURSE_ID)
);

/*TOPIC*/
CREATE TABLE IF NOT EXISTS TOPIC(
TOPIC_ID INT AUTO_INCREMENT PRIMARY KEY,
TOPIC_NAME VARCHAR(50),
MODULE_ID INT,
SEQ_NO INT,
PAGE_LINK VARCHAR(100),
CONSTRAINT fk_moduleId
    FOREIGN KEY (MODULE_ID) 
        REFERENCES MODULE(MODULE_ID)
);

/*TOPIC_DETAILS*/
CREATE TABLE IF NOT EXISTS TOPIC_DETAILS(
TOPIC_DETAILS_ID INT AUTO_INCREMENT PRIMARY KEY,
TOPIC_DESCRIPTION VARCHAR(100),
TOPIC_ID INT,
SEQ_NO INT,
PAGE_LINK VARCHAR(100),
CONSTRAINT fk_topicId
    FOREIGN KEY (TOPIC_ID) 
        REFERENCES TOPIC(TOPIC_ID)
);

/*CLASS*/
CREATE TABLE IF NOT EXISTS CLASS(
CLASS_ID INT AUTO_INCREMENT PRIMARY KEY,
COURSE_ID INT,
BATCH_NAME VARCHAR(25),
START_DATE TIMESTAMP,
END_DATE TIMESTAMP,
CONSTRAINT fk_classCourseId
    FOREIGN KEY (COURSE_ID) 
        REFERENCES COURSE(COURSE_ID)
);

/*COURSE_ASSIGNED_TEACHERS*/
CREATE TABLE IF NOT EXISTS COURSE_ASSIGNED_TEACHERS(
CLASS_ID INT,
MODULE_ID INT,
TEACHER_ID INT,
CONSTRAINT fk_classId
    FOREIGN KEY (CLASS_ID) 
        REFERENCES CLASS(CLASS_ID),
CONSTRAINT fk_couAssTeacherModuleId
    FOREIGN KEY (MODULE_ID) 
        REFERENCES MODULE(MODULE_ID),
CONSTRAINT fk_teacherId
    FOREIGN KEY (TEACHER_ID) 
        REFERENCES USER(USER_ID)
);

/*STUDENT_CLASS*/
CREATE TABLE IF NOT EXISTS STUDENT_CLASS(
STUDENT_CLASS_ID INT AUTO_INCREMENT PRIMARY KEY,
CLASS_ID INT,
USER_ID INT,
ATTENDANCE VARCHAR(5),
COMPLETION_STATUS VARCHAR(10),
CONSTRAINT fk_studentClassId
    FOREIGN KEY (CLASS_ID) 
        REFERENCES CLASS(CLASS_ID),
CONSTRAINT fk_studentUserId
    FOREIGN KEY (USER_ID) 
        REFERENCES USER(USER_ID)
);

/*STUDENT_ASSIGNMENT*/
CREATE TABLE IF NOT EXISTS STUDENT_ASSIGNMENT(
STUDENT_CLASS_ID INT,
MODULE_ID INT,
TOPIC_ID INT,
DATE_ASSIGNED DATE,
DATE_TO_COMPLETE DATE,
COMPLETION_STATUS VARCHAR(10),
CONSTRAINT fk_studentAssClassId
    FOREIGN KEY (STUDENT_CLASS_ID) 
        REFERENCES STUDENT_CLASS(STUDENT_CLASS_ID),
CONSTRAINT fk_studentAssModuleId
    FOREIGN KEY (MODULE_ID) 
        REFERENCES MODULE(MODULE_ID),
CONSTRAINT fk_studentAssTopicId
    FOREIGN KEY (TOPIC_ID) 
        REFERENCES TOPIC_DETAILS(TOPIC_ID)
);

/*ASSESSMENT*/
CREATE TABLE IF NOT EXISTS ASSESSMENT(
ASSESSMENT_ID INT AUTO_INCREMENT PRIMARY KEY,
STUDENT_CLASS_ID INT,
MODULE_ID INT,
NAME VARCHAR(25),
ASSESSMENT_DATE DATE,
MARKS INT(10),
CONSTRAINT fk_assStudentClassId
    FOREIGN KEY (STUDENT_CLASS_ID) 
        REFERENCES STUDENT_CLASS(STUDENT_CLASS_ID),
CONSTRAINT fk_assModuleId
    FOREIGN KEY (MODULE_ID) 
        REFERENCES MODULE(MODULE_ID)
);

/*LIVE_SESSION*/
CREATE TABLE IF NOT EXISTS LIVE_SESSION(
SESSION_ID INT AUTO_INCREMENT PRIMARY KEY,
CLASS_ID INT,
MODULE_ID INT,
TEACHER_ID INT,
SESSION_DATE DATE,
STATUS VARCHAR(10),
CONSTRAINT fk_sessionClassId
    FOREIGN KEY (CLASS_ID) 
        REFERENCES CLASS(CLASS_ID),
CONSTRAINT fk_sessionModuleId
    FOREIGN KEY (MODULE_ID) 
        REFERENCES MODULE(MODULE_ID),
CONSTRAINT fk_sessionUserId
    FOREIGN KEY (TEACHER_ID) 
        REFERENCES USER(USER_ID)
);