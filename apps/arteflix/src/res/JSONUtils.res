// remove undefined values from a json object
//
// https://dev.to/ryyppy/rescript-records-nextjs-undefined-and-getstaticprops-4890
//
// it's used in getServerSideProps, to avoit using Null.t for optional field when going through the network
//
let stripUndefined = (json: Js.Json.t): Js.Json.t => {
  open Js.Json
  stringify(json)->parseExn
};
