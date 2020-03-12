USE hmiltenberger;
ALTER DATABASE hmiltenberger CHARACTER SET utf8 COLLATE utf8_unicode_ci;

/* if you have do delete tables because of an error drop it last to first table you typed */
DROP TABLE IF EXISTS articleTag;
DROP TABLE IF EXISTS article;
DROP TABLE IF EXISTS tag;
DROP TABLE IF EXISTS author;

CREATE TABLE author(
	authorId BINARY(16) NOT NULL,
	authorActivationToken CHAR(32),
	authorAvatarUrl VARCHAR(255),
	authorEmail VARCHAR(128) NOT NULL,
	authorHash CHAR(97) NOT NULL,
	authorUserName VARCHAR(32) NOT NULL,
	UNIQUE(authorEmail),
	UNIQUE(authorUsername),
	INDEX(authorEmail),
	PRIMARY KEY(authorId)
);

CREATE TABLE tag(
	tagId BINARY(16) NOT NULL,
	tagName VARCHAR(32) NOT NULL,
	PRIMARY KEY(tagId)
);

CREATE TABLE article(
	articleId BINARY(16) NOT NULL,
	articleAuthorId BINARY(16) NOT NULL,
	articleContent VARCHAR(4000) NOT NULL,
	articleDate DATETIME(6) NOT NULL,
	articleImage VARCHAR(255),
	INDEX(articleAuthorId),
	FOREIGN KEY (articleAuthorId) REFERENCES author (authorId),
	PRIMARY KEY(articleId)
);

/* weak entity.*/
CREATE TABLE articleTag(
	articleTagArticleId BINARY(16) NOT NULL,
	articleTagTagId BINARY(16) NOT NULL,
	INDEX(articleTagArticleId),
	INDEX(articleTagTagId),
	FOREIGN KEY(articleTagArticleId) REFERENCES article(articleId),
	FOREIGN KEY(articleTagTagId) REFERENCES tag(tagId),
	PRIMARY KEY(articleTagArticleId, articleTagTagId)
);
