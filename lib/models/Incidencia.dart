class Incidencia {
  int idIncidencia;
  String descripcion;
  String procedimiento;
  double latitudDispositivo;
  double longitudDispositivo;
  double latitudIncidencia;
  double longitudIncidencia;
  int idOperativo;
  int idCategoria;
  int idTipoIncidencia;
  int idZona;
  String zona;
  String fechaCreacion;

  Incidencia(
      this.idIncidencia,
      this.descripcion,
      this.procedimiento,
      this.latitudDispositivo,
      this.longitudDispositivo,
      this.latitudIncidencia,
      this.longitudIncidencia,
      this.idOperativo,
      this.idCategoria,
      this.idTipoIncidencia,
      this.idZona,
      this.zona,
      this.fechaCreacion);
}
