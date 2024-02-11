#include <histogram.hpp>
#include <pybind11/numpy.h>
#include <pybind11/pybind11.h>

using namespace Histogram;
namespace py = pybind11;

Collector Collector_init(unsigned int traceLength,
                         py::array_t<Collector::BinT> histograms) {
  // Verify shape and type
  auto info = histograms.request();
  if (info.itemsize != sizeof(uint32_t)) {
    throw std::invalid_argument("Incorrect sample type");
  } else if (info.ndim != 2) {
    throw std::invalid_argument("Expected 2D array");
  } else if (info.shape[1] != Collector::NumberOfBins) {
    throw std::invalid_argument("Incorrect number of bins per histogram");
  }

  auto histP = static_cast<Collector::CacheT *>(info.ptr);
  return Collector(traceLength, histP);
}

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
      .def(pybind11::init(&Collector_init))
      .def("addTrace8", &Collector_addTrace8)
      .def("addTrace10", &Collector_addTrace10)
      .def("decimate", &Collector::decimate);
}