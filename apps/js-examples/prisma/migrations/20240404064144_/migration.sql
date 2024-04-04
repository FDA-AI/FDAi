-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "email" TEXT,
    "fdai_user_id" INTEGER,
    "first_name" TEXT,
    "username" TEXT,
    "fdai_access_token" TEXT,
    "fdai_refresh_token" TEXT,
    "fdai_expires_in" INTEGER,
    "fdai_scope" TEXT,
    "fdai_access_token_expires_at" TIMESTAMP(3),

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);
