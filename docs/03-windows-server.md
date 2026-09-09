# Windows Server

## Goal

Prepare `DC01` as the lab's Windows Server host before creating the domain.

## Planned sequence

1. Connect through RDP from the single allowed source address.
2. Install Windows updates.
3. Confirm the network adapter uses Azure-provided addressing.
4. Rename the computer to `DC01` with `01-rename-server.ps1` if necessary.
5. Restart only when ready.
6. Install the AD DS role with `02-install-adds-role.ps1`.
7. Confirm the role before forest promotion.

## Important Azure rule

Do not manually set a static IPv4 address inside Windows. The private address is reserved on the Azure NIC. Manually changing the guest adapter can break connectivity.

## Evidence to capture later

- Azure VM overview showing `DC01` running
- Server Manager showing AD DS installed
- `hostname` output after rename
- Windows version output

