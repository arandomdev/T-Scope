#include <histogram.hpp>
#include <pybind11/pybind11.h>

using namespace Histogram;
namespace py = pybind11;

void Collector_addTrace8(Collector &c, py::buffer b) {
  auto info = b.request();

  if (info.format != py::format_descriptor<uint8_t>::format()) {
    throw std::invalid_argument("Incorrect sample type");
  }
  if (info.ndim != 1) {
    throw std::invalid_argument("Expected 1D array");
  }

  uint8_t *begin = (uint8_t *)info.ptr;
  c.addTrace8(begin, begin + info.size);
}

void Collector_addTrace10(Collector &c, py::buffer b) {
  auto info = b.request();

  if (info.format != py::format_descriptor<uint16_t>::format()) {
    throw std::invalid_argument("Incorrect sample type");
  }
  if (info.ndim != 1) {
    throw std::invalid_argument("Expected 1D array");
  }

  uint16_t *begin = (uint16_t *)info.ptr;
  c.addTrace10(begin, begin + info.size);
}

PYBIND11_MODULE(_pyHistogram, m) {
  m.doc() = "Wrapper for the Histogram library.";

  // Collector
  py::class_<Collector>(m, "Collector")
      .def(pybind11::init<int &>())
      .def("addTrace8", &Collector_addTrace8)
      .def("addTrace10", &Collector_addTrace10)
      .def("getHistograms", &Collector::getHistograms);

  // CacheT, allows conversion to numpy array
  py::class_<Collector::CacheT>(m, "HistogramCache", py::buffer_protocol())
      .def_buffer([](Collector::CacheT &c) -> py ::buffer_info {
        constexpr size_t BinTSize = sizeof(Collector::BinT);
        return py::buffer_info(
            c.data()->data(), // Pointer to beginning of data
            BinTSize,         // size of element
            py::format_descriptor<Collector::BinT>::format(), // format desc
            2,                                                // number of dims
            // dimensions
            std::vector<size_t>{c.size(), Collector::NumberOfBins},
            // stride per index
            std::vector<size_t>{BinTSize * Collector::NumberOfBins, BinTSize});
      });
}