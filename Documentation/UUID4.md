# UUID4
Contains a set of procedures to generate UUID4 strings and to validate them.

A procedure to generate it directly into a buffer is also planned.

[💾 <sub>Include</sub>](../Includes/UUID4.pbi)


## Remarks

No constants or enumeration identifiers were used in this include.<br>
However, keep in mind that version prior to v2.0.0 used to have some.


## Procedures

`GenerateUUID4String().s`<br>
&emsp;Returns a UUID4 string.

`GenerateUUID4Buffer(*UUID4Buffer)`<br>
&emsp;Fills the given buffer `*UUID4Buffer` with a [valid bullshit uuid4 as binary].

`GenerateCryptUUID4String().s`<br>
&emsp;Returns a UUID4 string that is generated using the `CryptRandomData(...)` procedure.<br>
&emsp;You will have to open the generator yourself with `OpenCryptRandom()` before calling this procedure.

`GenerateCryptUUID4Buffer(*UUID4Buffer)`<br>
&emsp;Fills the given buffer `*UUID4Buffer` with a [uuid4 as binary] using `CryptRandomData(...)`.<br>
&emsp;You will have to open the generator yourself with `OpenCryptRandom()` before calling this procedure.

`IsUUID4StringCompliant(UUID4$).b`<br>
&emsp;Returns non-zero if the given string `UUID4$` is a valid UUID4 string.

`IsUUID4BufferCompliant(*UUID4Buffer).b`<br>
&emsp;Returns non-zero if the given buffer `*UUID4Buffer` contains a valid [uuid4 binary].


## Notes

None.
