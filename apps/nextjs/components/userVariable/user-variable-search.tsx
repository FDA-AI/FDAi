"use client";
import { FC, useEffect, useState } from "react";
import {UserVariableList} from "@/components/userVariable/user-variable-list";

type UserVariableSearchProps = {
  user: {
    id: string;
  };
};

export const UserVariableSearch: FC<UserVariableSearchProps> = ({ user }) => {

  // State to manage search phrase
  const [searchPhrase, setSearchPhrase] = useState("");
  const [debouncedSearchPhrase, setDebouncedSearchPhrase] = useState(searchPhrase);

  // Define search parameters
  const searchParams = {
    includePublic: true,
    sort: '-numberOfUserVariables',
    limit: 10,
    offset: 0,
    searchPhrase: debouncedSearchPhrase, // Use debounced value
  };

  useEffect(() => {
    const handler = setTimeout(() => {
      console.log(`New search made: ${searchPhrase}`);
      setDebouncedSearchPhrase(searchPhrase);
    }, 500); // Delay of 500ms

    return () => clearTimeout(handler);
  }, [searchPhrase]);

  return (
    <div className="search-container flex flex-col"> {/* Added flex container */}
      <div className="mb-4">
        <input
          type="text"
          value={searchPhrase}
          onChange={(e) => setSearchPhrase(e.target.value)}
          placeholder="Search variables..."
          className="input-class form-control block w-full px-3 py-1.5 text-base font-normal text-gray-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded-full transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
        />
      </div>
      <UserVariableList user={user} searchParams={searchParams}/>
    </div>
  );
};
