"use client"

import * as React from "react"
import HighchartsReact from 'highcharts-react-official';
import Highcharts from 'highcharts';

import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import { toast } from "@/components/ui/use-toast"
import { Icons } from "@/components/icons"
import { UserVariable } from "@/types/models/UserVariable";

interface UserVariableChartsProps extends React.HTMLAttributes<HTMLFormElement> {
  userVariable: UserVariable
}

export function UserVariableCharts({
  userVariable,
  className,
  ...props
}: UserVariableChartsProps) {


  return (

      <Card>
        <CardHeader>
          <CardTitle>{userVariable.name}</CardTitle>
          {userVariable.description && (
            <CardDescription>{userVariable.description}</CardDescription>
          )}
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="card transparent-bg highcharts-container">
            <HighchartsReact
              highcharts={Highcharts}
              options={userVariable.charts?.lineChartWithoutSmoothing?.highchartConfig}
            />
          </div>
        </CardContent>
        <CardFooter>
        </CardFooter>
      </Card>
  )
}
