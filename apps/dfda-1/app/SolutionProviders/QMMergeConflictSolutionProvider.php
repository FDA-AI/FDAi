<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\SolutionProviders;

use Facade\IgnitionContracts\BaseSolution;
use Facade\IgnitionContracts\HasSolutionsForThrowable;
use Illuminate\Support\Str;
use ParseError;
use Symfony\Component\Debug\Exception\FatalThrowableError;
use Throwable;

class QMMergeConflictSolutionProvider implements HasSolutionsForThrowable
{
    public function canSolve(Throwable $throwable): bool
    {
        if (! ($throwable instanceof FatalThrowableError || $throwable instanceof ParseError)) {
            return false;
        }

        if (! Str::startsWith($throwable->getMessage(), 'syntax error, unexpected \'<<\'')) {
            return false;
        }

        $file = file_get_contents($throwable->getFile());

        if (strpos($file, '=======') === false) {
            return false;
        }

        if (strpos($file, '>>>>>>>') === false) {
            return false;
        }

        return true;
    }

    public function getSolutions(Throwable $throwable): array
    {
        $file = file_get_contents($throwable->getFile());
        preg_match('/\>\>\>\>\>\>\> (.*?)\n/', $file, $matches);
        $source = $matches[1];

        $target = $this->getCurrentBranch(basename($throwable->getFile()));

        return [
            BaseSolution::create("Merge conflict from branch '$source' into $target")
                ->setSolutionDescription('You have a Git merge conflict. To undo your merge do `git reset --hard HEAD`'),
        ];
    }

    private function getCurrentBranch(string $directory): string
    {
        $branch = "'".trim(shell_exec("cd ${directory}; git branch | grep \\* | cut -d ' ' -f2"))."'";

        if (! isset($branch) || $branch === "''") {
            $branch = 'current branch';
        }

        return $branch;
    }
}
