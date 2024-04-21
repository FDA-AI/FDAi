"use client"
import React, { useState } from 'react';
import { Button } from "@/components/ui/button";
import {
  Credenza,
  CredenzaContent,
  CredenzaDescription,
  CredenzaHeader,
  CredenzaTitle
} from '@/components/ui/credenza';
import { MeasurementsAddForm } from "@/components/userVariable/measurements/measurements-add-form";
import { UserVariable } from "@/types/models/UserVariable"; // Ensure this import is correct
import { toast } from "@/components/ui/use-toast";
import { Icons } from "@/components/icons";
import { ButtonProps } from 'react-day-picker';

interface MeasurementButtonProps extends ButtonProps {
  userVariable: Pick<
    UserVariable,
    "id" | "name" | "description" | "createdAt" | "imageUrl" |
    "combinationOperation" | "unitAbbreviatedName" | "variableCategoryName" |
    "lastValue" | "unitName"
  >
}

export function MeasurementButton({ userVariable, ...props }: MeasurementButtonProps) {

  const [isFormOpen, setIsFormOpen] = useState(false);
  const [showMeasurementAlert, setShowMeasurementAlert] = React.useState<boolean>(false)

  async function onClick() {
    setShowMeasurementAlert(true)
    //router.refresh();
  }

  // Destructure `ref` out of props to avoid passing it to the Button component
  const { ref, ...buttonProps } = props;

  return (
    <>
      <Button onClick={onClick} {...buttonProps}>
        <Icons.add className="h-4 w-4" />
      </Button>
      {isFormOpen && (
        <Credenza>
          <MeasurementsAddForm
            userVariable={userVariable}
            setShowMeasurementAlert={setShowMeasurementAlert}
          />
        </Credenza>
      )}
      <Credenza open={showMeasurementAlert} onOpenChange={setShowMeasurementAlert}>
        <CredenzaContent>
          <CredenzaHeader>
            <CredenzaTitle>Record a Measurement</CredenzaTitle>
            <CredenzaDescription>
              This will record a {userVariable.name} measurement.
            </CredenzaDescription>
          </CredenzaHeader>
          <MeasurementsAddForm
            userVariable={userVariable}
            setShowMeasurementAlert={setShowMeasurementAlert}
          />
        </CredenzaContent>
      </Credenza>
    </>
  );
}
