#include <histogram.hpp>
#include <pybind11/pybind11.h>

using namespace Histogram;
namespace py = pybind11;

PYBIND11_MODULE(histogram, m) {
  // m.doc() = ""

  py::class_<Collector>(m, "Collector")
      .def(pybind11::init<int &>())
      .def("addTrace", &Collector::addTrace)
      .def("getHistograms", &Collector::getHistograms);
}