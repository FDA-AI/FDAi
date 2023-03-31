<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Storage\S3;
use App\Utils\Env;
class S3PrivateGlobal extends S3Helper {
    /**
     * @param string $s3Path
     * @return string
     * @noinspection PhpDocMissingThrowsInspection
     */
    public static function url(string $s3Path): string {
        /** @noinspection PhpUnhandledExceptionInspection */
        return static::getUrlForS3BucketAndPath(static::BUCKET . "/$s3Path");
    }
	public static function getBucketName(): string{
		return Env::getRequired('STORAGE_BUCKET_PRIVATE_GLOBAL'); 
	}
}
