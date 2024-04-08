"use client";
import { EmptyPlaceholder } from "@/components/empty-placeholder"
import { Icons } from "@/components/icons"

import { UserVariableAddButton } from "./user-variable-add-button"
import { UserVariableItem } from "./user-variable-item"
import { useEffect, useState } from "react";
import { UserVariable } from "@/types/models/UserVariable";


export function UserVariableList() {
  const [userVariables, setUserVariables]  =useState<UserVariable[]>([]);

  useEffect(() => {
    fetch('/api/userVariables')
      .then(response => response.json())
      .then(userVariables => {
        debugger
        console.log(userVariables);
        setUserVariables(userVariables);
      })
      .catch(error => console.error('Error fetching war images:', error));

  }, [setUserVariables]);

  return (
    <>
      {userVariables?.length ? (
        <>
          {userVariables.map((userVariable) => (
            <UserVariableItem key={userVariable.id} userVariable={userVariable} />
          ))}
        </>
      ) : (
        <EmptyPlaceholder>
          <div className="flex h-20 w-20 items-center justify-center rounded-full bg-muted">
            <Icons.activity className="h-10 w-10" />
          </div>
          <EmptyPlaceholder.Title>No Variables Created</EmptyPlaceholder.Title>
          <EmptyPlaceholder.Description>
            Add a Variable to start tracking.
          </EmptyPlaceholder.Description>
          <UserVariableAddButton variant="outline" />
        </EmptyPlaceholder>
      )}
    </>
  )
}
