# Troubleshooting Log

## Region policy blocked deployment

**Symptom:** Azure returned `RequestDisallowedByAzure` in an unapproved region.

**Cause:** The Azure for Students policy limited available deployment regions.

**Resolution:** The lab design was moved to `centralus`, an allowed region.

**Lesson:** Subscription policy is part of the infrastructure boundary and must be checked before selecting a region.

## Cloud Shell ran out of memory

**Symptom:** `Get-AzComputeResourceSku` raised `System.OutOfMemoryException`.

**Cause:** The cmdlet attempted to load a very large SKU catalog into a small Cloud Shell session.

**Resolution:** Use the narrower Azure CLI query later when SKU validation is needed:

```powershell
az vm list-skus --location centralus --size Standard_B2s --resource-type virtualMachines --output table
```

## Cloud Shell storage creation selected a blocked region

**Symptom:** Automatic Cloud Shell storage creation failed in South Central US.

**Cause:** That region was outside the subscription's allowed list.

**Resolution:** Create or select persistent Cloud Shell storage in an allowed region such as Central US.

## Accidental nested repository folders

**Symptom:** Files appeared under repeated paths such as `docs/powershell/azure/powershell/azure`.

**Cause:** Entering the full path while already inside a nested GitHub folder repeated the directory names.

**Resolution:** Move the scripts to the single intended path: `powershell/azure/`.

## How to add a new entry

Record the symptom, exact error, cause, investigation, resolution, and lesson. Remove IDs, credentials, IP addresses, and personal data first.

