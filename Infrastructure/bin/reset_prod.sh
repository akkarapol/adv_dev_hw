#!/bin/bash
# Reset Production Project (initial active services: Blue)
# This sets all services to the Blue service so that any pipeline run will deploy Green
if [ "$#" -ne 1 ]; then
    echo "Usage:"
    echo "  $0 GUID"
    exit 1
fi

GUID=$1
echo "Resetting Parks Production Environment in project ${GUID}-parks-prod to Green Services"

# Code to reset the parks production environment to make
# all the green services/routes active.
# This script will be called in the grading pipeline
# if the pipeline is executed without setting
# up the whole infrastructure to guarantee a Blue
# rollout followed by a Green rollout.

# To be Implemented by Student
oc get route/mlbparks -n ${GUID}-parks-prod |grep 'mlbparks-blue'
if [ $? = true ]; then
    echo "mlbparks-blue to mlbparks-green"
    oc patch route/mlbparks -p '{"spec":{"to":{"name":"mlbparks-green"}}}' -n $GUID-parks-prod
    else
    echo "mlbparks-green svc currently"
fi
oc get route/nationalparks -n ${GUID}-parks-prod |grep 'nationalparks-blue'
if [ $? == "nationalparks-blue" ]; then
    echo "nationalparks-blue to nationalparks-green"
    oc patch route/nationalparks -p '{"spec":{"to":{"name":"nationalparks-green"}}}' -n $GUID-parks-prod
    else
    echo "nationalparks-green svc currently"
fi
oc get route/parksmap -n ${GUID}-parks-prod |grep 'parksmap-blue'
if [ $? == "parksmap-blue" ]; then
    echo "parksmap-blue to parksmap-green"
    oc patch route/parksmap -p '{"spec":{"to":{"name":"parksmap-green"}}}' -n $GUID-parks-prod
    else
    echo "parksmap-green svc currently"
fi

