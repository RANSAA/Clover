/*
 * Brightness shortcut key mapping
 *
 * Need to be renamed
 *
 * In config ACPI, Rename _Q12 to XQ12
 * Find:     5F513132 00
 * Replace:  58513132 00
 *
 */
DefinitionBlock("", "SSDT", 2, "HASEE", "BrightFN", 0)
{
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    External(_SB.PCI0.LPCB.EC.XQ12, MethodObj)
    External(_SB.PCI0.LPCB.EC.OEM2, FieldUnitObj)
     

    Scope (_SB.PCI0.LPCB.EC)
    {
        //The defined temporary variable is used to store the changed value of Fn+F8/Fn+F9.
        Name (TKBR, Zero)
        Method (_Q12, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {      
                If ((OEM2 == 0x00))//Fn+F8
                {
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
                }
                ElseIf((OEM2 == 0x07))//Fn+F9
                {
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
                }
                Else
                {
                    If ((OEM2 > TKBR))//Fn+F9
                    {
                        Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
                    }
                    Else//Fn+F8
                    {
                        Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
                    }
                }
                TKBR = OEM2           
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ12()
            }
        }
       
    }
}
//EOF
