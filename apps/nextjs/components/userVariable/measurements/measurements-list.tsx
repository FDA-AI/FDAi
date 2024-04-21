"use client";
import { FC, useState, useEffect } from "react";
import { Measurement } from "@/types/models/Measurement";
import { DataTable } from "@/components/data-table";
import { measurementColumns } from "@/components/userVariable/measurements/measurements-columns";

type MeasurementsListProps = {
  user: {
    id: string;
  };
  variableId: number;
};

export const MeasurementsList: FC<MeasurementsListProps> = ({ user, variableId }) => {

  const [measurements, setMeasurements] = useState<Measurement[]>();
  const [isLoading, setIsLoading] = useState(true); // Add a loading state

  useEffect(() => {
    setIsLoading(true); // Set loading to true when starting to fetch
    const url = `/api/dfda/measurements?variableId=${variableId}`;

    fetch(url)
      .then(response => response.json())
      .then(measurements => {
        setMeasurements(measurements);
        setIsLoading(false); // Set loading to false once data is fetched
      })
      .catch(error => {
        console.error('Error fetching user variables:', error);
        setIsLoading(false); // Ensure loading is set to false even if there's an error
      });

  }, [user, variableId]);

  if (isLoading) {
    return <div>Loading...</div>; // Show a loader or a loading component
  }

  // Ensure measurements is defined before trying to access its properties
  if (!measurements) {
    return <div>No data found.</div>; // Handle the case where measurements is undefined
  }

  return (
    <>
      <DataTable columns={measurementColumns} data={measurements ?? []}>
        Measurements
      </DataTable>
    </>
  );
}
