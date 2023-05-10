# Deploying The Dashboard

## Introduction

In this walkthrough, you'll deploy and configure the pMAx Dashboard.

<walkthrough-tutorial-difficulty difficulty="3"></walkthrough-tutorial-difficulty>
<walkthrough-tutorial-difficulty difficulty="3"></walkthrough-tutorial-difficulty>

## Project setup

GCP organizes resources into projects. This allows you to
collect all of the related resources for a single application in one place.

Begin by creating a new project or selecting an existing project for this
dashboard.

<walkthrough-project-setup billing></walkthrough-project-setup>

For details, see
[Creating a project](https://cloud.google.com/resource-manager/docs/creating-managing-projects#creating_a_project).

## Turn on Google Cloud APIs

Dataflow processes data in many GCP data stores and messaging services,
including BigQuery, Google Cloud Storage, and Cloud Pub/Sub. Enable the APIs for
these services to take advantage of Dataflow's data processing capabilities.

<walkthrough-enable-apis apis=
  "compute.googleapis.com,
  dataflow,
  cloudresourcemanager.googleapis.com,
  logging,
  storage_component,
  storage_api,
  bigquery,
  pubsub">
</walkthrough-enable-apis>

## Change directory

```bash
cd pmax_dashboard
```

```bash
something with yaml
```

## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

<walkthrough-inline-feedback></walkthrough-inline-feedback>
