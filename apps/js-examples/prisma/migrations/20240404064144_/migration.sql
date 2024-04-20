-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "email" TEXT,
    "dfda_user_id" INTEGER,
    "first_name" TEXT,
    "username" TEXT,
    "dfda_access_token" TEXT,
    "dfda_refresh_token" TEXT,
    "dfda_expires_in" INTEGER,
    "dfda_scope" TEXT,
    "dfda_access_token_expires_at" TIMESTAMP(3),

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);
