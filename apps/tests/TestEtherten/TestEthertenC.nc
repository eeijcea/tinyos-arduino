/*
 * Copyright (c) 2013 Johny Mattsson
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the copyright holders nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "ShellCommand.h"
#include "Atm328pSpi.h"

configuration TestEthertenC
{
}
implementation
{
  // Pre-configured serial commands
  components HelpSerialCmdC, UptimeSerialCmdC;


  // Custom commands with hand-wiring. Note naming of PlatformSerialShellC.
  components PlatformSerialShellC as SerialShell;

  components SpiShellCmdC, GpioShellCmdC;
  components new ResourceShellCmdC() as SpiResourceShellCmdC, PlatformSpiC;
  SpiResourceShellCmdC.Resource -> PlatformSpiC.Resource[unique(SPI_RESOURCE)];

  WIRE_SHELL_COMMAND("spi",    SpiShellCmdC,         SerialShell);
  WIRE_SHELL_COMMAND("gpio",   GpioShellCmdC,        SerialShell);
  WIRE_SHELL_COMMAND("spibus", SpiResourceShellCmdC, SerialShell);

  components IPv4NetworkShellCmdC, IPv4NetworkC;
  IPv4NetworkShellCmdC.IPv4Network -> IPv4NetworkC;
  WIRE_SHELL_COMMAND("ip", IPv4NetworkShellCmdC, SerialShell);

  components EtherShellCmdC;
  WIRE_SHELL_COMMAND("ether", EtherShellCmdC, SerialShell);
}